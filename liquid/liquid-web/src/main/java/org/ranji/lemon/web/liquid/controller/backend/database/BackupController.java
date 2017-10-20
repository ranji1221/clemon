package org.ranji.lemon.web.liquid.controller.backend.database;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.ranji.lemon.common.core.annotation.SystemControllerLog;
import org.ranji.lemon.common.core.pagination.PagerModel;
import org.ranji.lemon.common.liquid.util.BackupUtil;
import org.ranji.lemon.model.liquid.database.BackupDatabaseInfo;
import org.ranji.lemon.service.liquid.database.prototype.IBackupDatabaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
 * database模块中的备份控制器类
 * @author fengjie
 * @date 2017-10-19
 * @since JDK1.7
 * @version 1.0
 */
@Controller
@RequestMapping(value = "/backend/database/backup")
public class BackupController {
	
	@Autowired
	private IBackupDatabaseService backupService;
	
	
	@RequestMapping(value = "/backupJump")
	@SystemControllerLog(description="数据库管理-备份数据库跳转")
	public String backupJump() {
		return "backend/database/backup";
	}
	
	@RequestMapping(value = "/recoverlist")
	@SystemControllerLog(description="数据库管理-恢复数据库跳转")
	public String recoverlist() {
		return "backend/database/recoverlist";
	}
	
	@RequestMapping(value = "/backup")
	@SystemControllerLog(description="数据库管理-备份数据库")
	@ResponseBody
	public String backup(BackupDatabaseInfo backup,HttpSession session) {
		try {
			//命名文件
			String sqlName = BackupUtil.rename("sql");
			// 获取存储路径
			String absolutePath = BackupUtil.getAbsolutePath("/lemon", session); //绝对地址
			String relativePath = BackupUtil.getRelativePath("/lemon", session); //相对地址
			backupService.backup(absolutePath + "/" + sqlName);
			backup.setPath(relativePath + "/" + sqlName);
			backupService.save(backup);
			return "{ \"success\" : true }";
		} catch (IOException e) {
			e.printStackTrace();
			return "{ \"success\" : false }";
		}
	}
	
	@RequestMapping(value = "/recover")
	@SystemControllerLog(description="数据库管理-还原数据库")
	@ResponseBody
	public String recover(int id,HttpSession session) {
		try {
			BackupDatabaseInfo backupInfo = backupService.find(id);
			// 获取存储路径
			String absolutePath = BackupUtil.getAbsolutePath("/", session); //绝对地址
			String path = backupInfo.getPath(); //相对地址
			backupService.recover(absolutePath + path); //还原数据库操作
			return "{ \"success\" : true }";
		} catch (IOException e) {
			e.printStackTrace();
			return "{ \"success\" : false }";
		}
	}
	
	@RequestMapping(value = "/listAll")
	@SystemControllerLog(description="数据库管理-查看备份数据列表")
	@ResponseBody
	public List<BackupDatabaseInfo> listAllRole() {
		List <BackupDatabaseInfo> backupList = backupService.findAll();
		return backupList;
	}
	
	@SystemControllerLog(description="数据库管理-角色列表")
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
			PagerModel<BackupDatabaseInfo> pg = backupService.findPaginated(map);
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
}
