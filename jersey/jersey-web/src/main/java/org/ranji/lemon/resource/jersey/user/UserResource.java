package org.ranji.lemon.resource.jersey.user;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.ranji.lemon.model.liquid.authority.User;
import org.ranji.lemon.service.liquid.authority.prototype.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
 * 测试用的hello webservice接口，没有实际的用处，仅仅是个示例而已
 * @author RanJi
 * @date 2017-9-23
 * @since JDK1.7
 * @version 1.0
 */

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
		
		ObjectMapper om = new ObjectMapper();
		String userJsonData = "";
		
		try {
			//-- 加入writeWithDefaultPrettyPrinter()方法仅仅是为了更加的格式化
			userJsonData = om.writerWithDefaultPrettyPrinter().writeValueAsString(u);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return userJsonData;
	}
	
	@POST
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json")
	@Path("/save")
	public Object saveUser(@FormParam("userName") String userName,@FormParam("userPass") String userPass){
		
		User u = new User();
		u.setUserName(userName);
		u.setUserPass(userPass);
		try {
			userService.save(u);
		} catch (Exception e) {
			return Response.ok("{\"access\":\"failure\"}").status(HttpServletResponse.SC_INTERNAL_SERVER_ERROR ).header("Access-Control-Allow-Origin", "*").build();
		}
		
		return Response.ok("{\"id\":"+u.getId()+"}").status(HttpServletResponse.SC_OK).header("Access-Control-Allow-Origin", "*").build();
	}
	
}
