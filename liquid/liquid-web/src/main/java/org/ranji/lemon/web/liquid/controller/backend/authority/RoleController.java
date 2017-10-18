package org.ranji.lemon.web.liquid.controller.backend.authority;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.ranji.lemon.common.core.annotation.SystemControllerLog;
import org.ranji.lemon.common.core.pagination.PagerModel;
import org.ranji.lemon.model.liquid.authority.Operation;
import org.ranji.lemon.model.liquid.authority.Role;
import org.ranji.lemon.service.liquid.authority.prototype.IAuthorityService;
import org.ranji.lemon.service.liquid.authority.prototype.IRoleService;
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
 * 角色控制器类
 * @author FengJie
 * @date 2017-9-29
 * @since JDK1.7
 * @version 1.0
 */

@Controller
@RequestMapping(value = "/backend/authority/role")
public class RoleController {
	
	@Autowired
	private IRoleService roleService;
	@Autowired
	private IAuthorityService authService;
		
	//@SystemControllerPermission("role:list")
	@RequestMapping(value = "/list")
	@SystemControllerLog(description="权限管理-角色列表")
	public String listRole(HttpSession session) {
		//List <Role> roleList = roleService.findAll();
		//session.setAttribute("roleList", JsonUtils.objectToJson(roleList));
		//session.setAttribute("roleList", roleList);
		return "backend/authority/role/list";
		//session.setAttribute("roleList", roleList); //页面
		//return "backend/authority/role/rolelist";
	}
	
	@RequestMapping(value = "/listAll")
	@SystemControllerLog(description="权限管理-角色全部列表")
	@ResponseBody
	public List<Role> listAllRole(HttpSession session) {
		List <Role> roleList = roleService.findRoleTree();
		//session.setAttribute("roleList", JsonUtils.objectToJson(roleList));
		//session.setAttribute("roleList", roleList);
		return roleList;
		//session.setAttribute("roleList", roleList); //页面
		//return "backend/authority/role/rolelist";
	}
	
	@RequestMapping(value = "/getOperation")
	@SystemControllerLog(description="权限管理-角色操作列表")
	@ResponseBody
	public List<Operation> getOperationByRoleId(int roleId) {
		
		return authService.findOperationsByRoleId(roleId);
	}
	
	//@SystemControllerPermission("role:list")
	@SystemControllerLog(description="权限管理-角色列表")
	@RequestMapping(value = "/data")
	@ResponseBody
	public String data(String params) {
		try {
			ObjectMapper om = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			if (!StringUtils.isEmpty(params)) {
				// 参数处理
				map = om.readValue(params, new TypeReference<Map<String, Object>>() {});
			}
			PagerModel<Role> pg = roleService.findPaginated(map);
			// 序列化查询结果为JSON
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", pg.getTotal());
			result.put("rows", pg.getData());
			return om.writeValueAsString(result);
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"total\" : 0, \"rows\" : [] }";
		}
	}
	
	//@SystemControllerPermission("role:add")
	@RequestMapping(value = "/add")
	@SystemControllerLog(description="权限管理-添加角色跳转")
	public String addRole() {
		return "backend/authority/role/add";
	}
	
	@ResponseBody
	@RequestMapping(value = "/save")
	@SystemControllerLog(description="权限管理-添加角色")
	public String saveRole(Role newRole) {
		try {
			roleService.save(newRole);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "{ \"success\" : false }";
		}
	}
	//@SystemControllerPermission("role:bulkadd")
	@RequestMapping(value = "/adds")
	@SystemControllerLog(description="权限管理-批量添加角色")
	public String addsRoles() {
		return "backend/authority/role/adds";
	}
	
	//@SystemControllerPermission("role:bulkadd")
	@RequestMapping(value = "/view/{size}/{id}")
	@SystemControllerLog(description="权限管理-查看角色")
	public String viewRole(@PathVariable String size,@PathVariable int id, HttpSession session) {
		
		Role role = roleService.find(id);
		session.setAttribute("role", role);
		if("modal".equals(size)){
			return "backend/authority/role/viewmodal";
		}else if("max".equals(size)){
			return "backend/authority/role/view";
		}
		return null;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/edit")
	@SystemControllerLog(description="权限管理-修改角色")
	public String edit(Role newRole,HttpSession session) {
		try {
			Role role = roleService.find(newRole.getId());
			role.setDisplayName(newRole.getDisplayName());
			role.setRoleExtendPId(newRole.getRoleExtendPId());
			role.setRoleMaxNum(newRole.getRoleMaxNum());
			role.setRemarks(newRole.getRemarks());
			role.setRoleRelyId(newRole.getRoleRelyId());
			roleService.update(role);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "{ \"success\" : false }";
		}
	}
	
	//@SystemControllerPermission("role:bulkadd")
	@RequestMapping(value = "/auth/{size}")
	@SystemControllerLog(description="权限管理-给角色分配资源")
	public String authRole(@PathVariable String size) {
		if("modal".equals(size)){
			return "backend/authority/role/authmodal";
		}else if("max".equals(size)){
			return "backend/authority/role/auth";
		}
		return null;
	}
		@ResponseBody
		@RequestMapping(value = "/delete")
		@SystemControllerLog(description="权限管理-删除角色")
		public String deleteRole(int id) {
			try {
				roleService.delete(id);
				return "{ \"success\" : true }";
			} catch (Exception e) {
				e.printStackTrace();
				return "{ \"success\" : false }";
			}
		}
}
