package org.ranji.lemon.web.liquid.controller.backend.authority;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.ranji.lemon.common.core.annotation.SystemControllerLog;
import org.ranji.lemon.common.core.pagination.PagerModel;
import org.ranji.lemon.common.core.util.JsonUtil;
import org.ranji.lemon.model.liquid.authority.Operation;
import org.ranji.lemon.model.liquid.authority.Resource;
import org.ranji.lemon.service.liquid.authority.prototype.IOperationService;
import org.ranji.lemon.service.liquid.authority.prototype.IResourceService;
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
 * 资源控制器类
 * @author yaoyao
 * @date 2017-9-29
 * @since JDK1.7
 * @version 1.0
 */

@Controller
@RequestMapping(value="/backend/authority/resource")
public class ResourceController {
	@Autowired
	private IResourceService resourceService;
	@Autowired
	private IOperationService operationService;
	
//	@SystemControllerPermission("resource:list")
	@RequestMapping(value = "/list")
	@SystemControllerLog(description="权限管理-资源列表")
	public String listResource() {
		return "backend/authority/resources/list";
	}

//	@SystemControllerPermission("resource:add")
	@RequestMapping(value = "/add")
	@SystemControllerLog(description="权限管理-添加资源跳转")
	public String addResources() {
		return "backend/authority/resources/add";
	}
	
	@ResponseBody
	@RequestMapping(value = "/save")
	@SystemControllerLog(description="权限管理-添加资源")
	public String saveResources(Resource resource) {
		try {
			resourceService.save(resource);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return "{ \"success\" : false }";
		}
	}
//	@SystemControllerPermission("resource:looksource")
	@RequestMapping(value = "/view/{request_param}")
	@SystemControllerLog(description="权限管理-查看资源")
	public String viewSource(@PathVariable String request_param) {
		if("modal".equals(request_param)){
			return "backend/authority/resources/viewmodal";
		}else if("max".equals(request_param)){
			return "backend/authority/resources/view";
		}
		return null;
	}
//	@SystemControllerPermission("resource:looksource")
	@RequestMapping(value = "/edit/{request_param}")
	@SystemControllerLog(description="权限管理-查看资源")
	public String editSource(@PathVariable String request_param) {
		if("modal".equals(request_param)){
			return "backend/authority/resources/editmodal";
		}else if("max".equals(request_param)){
			return "backend/authority/resources/edit";
		}
		return null;
	}	
	
	//@SystemControllerPermission("resource:list")
	@SystemControllerLog(description="权限管理-资源列表")
	@RequestMapping(value = "/data")
	@ResponseBody
	public String data(String params,HttpSession session) {
		try {
			ObjectMapper om = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			// 当前只查询管理员
			if (!StringUtils.isEmpty(params)) {
				// 参数处理
				map = om.readValue(params, new TypeReference<Map<String, Object>>() {});
			}
			PagerModel<Resource	> pg = resourceService.findPaginated(map);
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
	
	
	@ResponseBody
	@RequestMapping(value = "/get/resourceAndOperation")
	public String findResourceAndOperation() {
		List<Resource> resourceList = resourceService.findAll();
		List<Operation> operationList = operationService.findAll();
		Map <String,Object> map = new HashMap<String,Object>();
		map.put("resource", resourceList);
		map.put("operation", operationList);
		return JsonUtil.toJsonByProperties(map);
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete")
	public String deleteResource(int id) {
		try {
			resourceService.delete(id);
			return "{ \"success\" : true }";
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"success\" : false, \"msg\" : \"操作失败\" }";
		}
	}
}
