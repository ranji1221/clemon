package org.ranji.lemon.web.jersey.controller.oauth2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.oltu.oauth2.as.issuer.MD5Generator;
import org.apache.oltu.oauth2.as.issuer.OAuthIssuer;
import org.apache.oltu.oauth2.as.issuer.OAuthIssuerImpl;
import org.apache.oltu.oauth2.as.request.OAuthTokenRequest;
import org.apache.oltu.oauth2.as.response.OAuthASResponse;
import org.apache.oltu.oauth2.common.error.OAuthError;
import org.apache.oltu.oauth2.common.exception.OAuthProblemException;
import org.apache.oltu.oauth2.common.exception.OAuthSystemException;
import org.apache.oltu.oauth2.common.message.OAuthResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.ranji.lemon.service.jersey.oauth2.prototype.IOauthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the"License"); 
 * you may not use this file except in compliance with the License.  
 * You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
 * See the License for the specific language governing permissions and limitations under the License.
 * Copyright [2017] [RanJi] [Email-jiran1221@163.com]
 * 
 * OAuth2开放平台授权控器
 * OAuth2的角色：
 * (1)资源拥有者（resource owner）：能授权访问受保护资源的一个实体，可以是一个人，那我们称之为最终用户；如新浪微博用户zhangsan
 * (2)资源服务器（resource server）：存储受保护资源，客户端通过access token请求资源，资源服务器响应受保护资源给客户端；
 * 	      存储着用户zhangsan的微博等信息。
 * (3)授权服务器（authorization server）：成功验证资源拥有者并获取授权之后，授权服务器颁发授权令牌（Access Token）给客户端。
 * (4)客户端（client）：如新浪微博客户端weico、微格等第三方应用，也可以是它自己的官方应用；
 *    其本身不存储资源，而是资源拥有者授权通过后，使用它的授权（授权令牌）访问受保护资源，然后客户端把相应的数据展示出来/提交到服务器。
 *    “客户端”术语不代表任何特定实现（如应用运行在一台服务器、桌面、手机或其他设备）。 
 * OAuth2的授权流程：
 * (1)客户端从资源拥有者那请求授权。授权请求可以直接发给资源拥有者，或间接的通过授权服务器这种中介，后者更可取。
 * (2)客户端收到一个授权许可，代表资源服务器提供的授权。
 * (3)客户端使用它自己的私有证书及授权许可到授权服务器验证。
 * (4)如果验证成功，则下发一个访问令牌。
 * (5)客户端使用访问令牌向资源服务器请求受保护资源。
 * (6)资源服务器会验证访问令牌的有效性，如果成功则下发受保护资源。
 * @author RanJi
 * @date 2017-9-14
 * @since JDK1.7
 * @version 1.0
 */

@Controller
@RequestMapping("/oauth2")
public class OltuAuthorizeController {
	
	@Autowired
	IOauthService oauthService;
	
	//-- 1. The Firt Step
	//-- 类似于第三方应用的人在咱们的第三方开放接口平台注册登录后，创建了某应用，我们为此应用创建了相应的ClientId和ClientSecret
	//-- 示例：http://localhost:8080/lemonws/oauth2/applyfor?thirdAppName=estore
	@RequestMapping(value ="/applyfor")
	@ResponseBody
	public String applyeForClientIdAndClientSecretForThirdApp(@RequestParam("thirdAppName")String thirdAppName){
		return oauthService.generateClientIdAndClientSecret(thirdAppName);
	}
	
	//-- 2. The Second Step
	//-- oauth2提供5种grant_type类型：
	//-- (1)authorization_code(最安全，但是稍微麻烦些) (2)password  (3)client_credentials (4)implicit (5)refresh_token
	//-- 利用第一步产生的clientId和clientSecret来获取token，我们采用相对简单的client_credentials模式，这种方式必须为POST请求方式
	//-- 示例：http://localhost:8080/lemonws/oauth2/token?client_id=test&client_secret=test&grant_type=client_credentials&scope=read write
	@RequestMapping(value="/token",method=RequestMethod.POST)
	public Object oltuAuthorize(HttpServletRequest request)throws OAuthSystemException{
		try {
			//-- 1. 构建OAuth2请求
			OAuthTokenRequest oauthRequest = new OAuthTokenRequest(request);
			
			//-- 2. 检查ClientId的正确性
			if(!oauthService.checkClientId(oauthRequest.getClientId())){
				OAuthResponse response = OAuthASResponse
						.errorResponse(HttpServletResponse.SC_BAD_REQUEST)
						.setError(OAuthError.TokenResponse.INVALID_CLIENT).buildJSONMessage();
			    return new ResponseEntity<String>(  
			    		response.getBody(), HttpStatus.valueOf(response.getResponseStatus()));
			}
			//-- 3. 检查ClientSecret的正确性
			if(!oauthService.checkClientSecret(oauthRequest.getClientSecret())){
				OAuthResponse response = OAuthASResponse  
			              .errorResponse(HttpServletResponse.SC_UNAUTHORIZED)  
			              .setError(OAuthError.TokenResponse.UNAUTHORIZED_CLIENT)  
			              .buildJSONMessage();
			    return new ResponseEntity<String>(  
			    		response.getBody(), HttpStatus.valueOf(response.getResponseStatus()));
			}
			
			//-- 4. 生成token
			OAuthIssuer oauthIssuer = new OAuthIssuerImpl(new MD5Generator()); 
			final String accessToken = oauthIssuer.accessToken();
			
			//-- 5. 生成oauth响应
			OAuthResponse response = OAuthASResponse
					.tokenResponse(HttpServletResponse.SC_OK)
					.setAccessToken(accessToken)
					.setExpiresIn("32432")
					.buildJSONMessage();
			return new ResponseEntity<String>(
					response.getBody(), HttpStatus.valueOf(response.getResponseStatus()));
		} catch (OAuthProblemException e) {
			//-- 构建错误响应  
			OAuthResponse response = OAuthASResponse  
		              .errorResponse(HttpServletResponse.SC_BAD_REQUEST).error(e)  
		              .buildJSONMessage();  
		    return new ResponseEntity<String>(
		    		response.getBody(), HttpStatus.valueOf(response.getResponseStatus()));  
		}
		
	}
	
	@RequestMapping(value ="/hello")
	@ResponseBody
	public String hello(){
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken("zhansan", "123456");
		//--4. 登录，即身份验证
		try {
			subject.login(token);
		} catch (AuthenticationException e) {
			e.printStackTrace();
		}
		//System.out.println(subject.isAuthenticated());
		//System.out.println(subject.getPrincipal());
		//-- 6. 退出
		System.out.println(subject.isAuthenticated());
		subject.logout();
		return "hello";
	}
}
