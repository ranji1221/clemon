package org.ranji.lemon.web.jersey.resource.user;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import org.ranji.lemon.common.core.util.JsonUtil;
import org.ranji.lemon.model.liquid.authority.User;
import org.ranji.lemon.service.liquid.authority.prototype.IUserService;
import org.ranji.lemon.web.jersey.common.annotation.CheckAccessToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
 * 测试用的user webservice接口，仅仅是个示例而已
 * @author RanJi
 * @date 2017-9-23
 * @since JDK1.7
 * @version 1.0
 */

@CheckAccessToken
@Component
@Path("/user")
public class UserResource {
	@Autowired
	private IUserService userService;
	
	@GET
	@Produces("application/json")
	@Path("/{id}")
	public String getUser(@PathParam("id") int id){
		User u = userService.find(id);
		return JsonUtil.objectToJson(u);
	}
	
	@POST
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json")
	@Path("/save")
	public Object saveUser(@FormParam("userName") String userName,@FormParam("userPass") String userPass){
		String jsonData = "";
		User u = new User();
		u.setUserName(userName);
		u.setUserPass(userPass);
		try {
			userService.save(u);
		} catch (Exception e) {
			//-- 统一在过滤器中添加跨域访问的header信息，所以这里就不添加了
			jsonData = JsonUtil.toJsonByProperty("addUser","failure");
			return Response.ok(jsonData).status(HttpServletResponse.SC_INTERNAL_SERVER_ERROR ).build();
		}
		jsonData = JsonUtil.toJsonByProperty("id", u.getId());
		return Response.ok(jsonData).status(HttpServletResponse.SC_OK).build();
	}
}
