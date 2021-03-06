package org.ranji.lemon.web.jersey.resource.test;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

import org.ranji.lemon.web.jersey.common.annotation.CheckAccessToken;

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
@CheckAccessToken
@Path("")
public class HelloResource {
	
	
	@GET
	@Path("/hello")
	public String sayHello(HttpServletRequest request){
		return "hello jersey.";
	}
}
