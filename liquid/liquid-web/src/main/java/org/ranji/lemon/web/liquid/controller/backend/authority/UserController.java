package org.ranji.lemon.web.liquid.controller.backend.authority;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.ranji.lemon.common.core.annotation.SystemControllerLog;
import org.ranji.lemon.common.core.annotation.SystemControllerPermission;
import org.ranji.lemon.common.core.pagination.PagerModel;
import org.ranji.lemon.model.liquid.authority.User;
import org.ranji.lemon.service.liquid.authority.prototype.IAuthorityService;
import org.ranji.lemon.service.liquid.authority.prototype.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
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
 * Authority模块中的UserController控制器类
 * @author RanJi
 * @date 2013-10-1
 * @since JDK1.7
 * @version 1.0
 */
@Controller
@RequestMapping(value = "/backend/authority/user")
public class UserController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IAuthorityService authService;
	
	//@RequiresPermissions("user:add")
	@SystemControllerPermission("user:add")
	@RequestMapping(value = "/add")
	@SystemControllerLog(description="权限管理-添加用户")
	public String addUser() {
		return "backend/authority/user/add";
	}
	
//	@SystemControllerPermission("user:list")
	@RequestMapping(value = "/list")
	@SystemControllerLog(description="权限管理-用户列表")
	public String listUser() {
		return "backend/authority/user/list";
	}
	
//	@SystemControllerPermission("user:adds")
	@RequestMapping(value = "/adds")
	@SystemControllerLog(description="权限管理-批量添加用户")
	public String AddsUser() {
		return "backend/authority/user/adds";
	}
	
	//@RequiresPermissions("user:lookuser")
//	@SystemControllerPermission("user:view")
	@RequestMapping(value = "/view/{size}/{id}")
	@SystemControllerLog(description="权限管理-查看用户")
	public String viewUser(@PathVariable String size,@PathVariable int id) {
		
		if("modal".equals(size)){
			return "backend/authority/user/viewmodal";
		}else if("max".equals(size)){
			return "backend/authority/user/view";
		}
		return null;
		
	}
	
//	@SystemControllerPermission("user:edit")
	@RequestMapping(value = "/edit/{size}")
	@SystemControllerLog(description="权限管理-更新用户")
	public String editUser(@PathVariable String size) {
		if("modal".equals(size)){
			return "backend/authority/user/editmodal";
		}else if("max".equals(size)){
			return "backend/authority/user/edit";
		}
		return null;
		
	}
	
//	@SystemControllerPermission("user:auth")
	@RequestMapping(value = "/auth/{size}")
	@SystemControllerLog(description="权限管理-给用户分配角色")
	public String authUser(@PathVariable String size) {
		if("modal".equals(size)){
			return "backend/authority/user/authmodal";
		}else if("max".equals(size)){
			return "backend/authority/user/auth";
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "/adduser")
	public String add(User obj) {
		try {
			userService.save(obj);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"success\" : false, \"msg\" : \"操作失败\" }";
		}
	}


	@ResponseBody
	@RequestMapping(value = "/delete")
	public String deleteUser(int id) {
		try {
			userService.delete(id);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"success\" : false, \"msg\" : \"操作失败\" }";
		}
	}

/*	@ResponseBody
	@RequestMapping(value = "/deleteAll")
	public String multiDelete(@RequestParam("ids[]") Integer[] ids) {
		try {
			userService.deleteByIDS(Arrays.asList(ids));
			return "{ \"success\" : true }";
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"success\" : false, \"msg\" : \"操作失败\" }";
		}
	}*/

	@ResponseBody
	@RequestMapping(value = "/get/{id}")
	public String get(@PathVariable int id) {
		try {
			ObjectMapper om = new ObjectMapper();
			User obj = userService.find(id);
			return om.writeValueAsString(obj);
		} catch (Exception e) {
			e.printStackTrace();
			return "{}";
		}
	}
	
	//@SystemControllerPermission("user:list")
	@ResponseBody
	@SystemControllerLog(description="权限管理-用户列表")
	@RequestMapping(value = "/data")
	public String data(String params,HttpSession session) {
		return authService.findAllUserInduleRoles(params);
	}
}
