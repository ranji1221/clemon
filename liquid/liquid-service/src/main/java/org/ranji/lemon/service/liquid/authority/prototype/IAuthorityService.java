package org.ranji.lemon.service.liquid.authority.prototype;

import java.util.List;

import org.ranji.lemon.model.liquid.authority.Operation;
import org.ranji.lemon.model.liquid.authority.Resource;
import org.ranji.lemon.model.liquid.authority.Role;
import org.ranji.lemon.model.liquid.authority.User;


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
 * Authority模块中的IAuthorityService接口类
 * @author LiJianBo
 * @date 2017-9-22
 * @since JDK1.7
 * @version 1.0
 */
public interface IAuthorityService {
	
	public List<Role> userFindRole();
	
	/**
	 * 查询用户的所有角色及父级角色
	 * @param userId 用户id
	 * @return 角色对象集合
	 */
	public  List<Role> findRolesByUserId(int userId);
	
	/**
	 * 查询用户的所有操作列表
	 * @param userId 用户id
	 * @return 操作对象集合
	 */
	public List<Operation> findOperationsByUserId(int userId);
	
	/**
	 * 查询所有用户（包含用户的角色信息）
	 * @param params 分页或模糊查询参数
	 * @return 用户对象集合json
	 */
	public String findAllUserInduleRoles(String params);
	
	/**
	 * 根据用户id查询所有操作
	 * @param roleId 角色id
	 * @return 操作集合
	 */
	public List<Operation> findOperationsByRoleId(int roleId);
	
	/**
	 * 保存资源操作相关内容
	 * @param resource 资源对象
	 * @param array 操作字符集
	 * 
	 */
	public void saveResourceAndOperation(Resource resource,String []array);
	
	/**
	 * 更新资源操作相关内容
	 * @param resource 资源对象
	 * @param array 操作字符集
	 * 
	 */
	public void updateResourceAndOperation(Resource resource,String []array);
	/**
	 * 角色授权
	 * @param roleId 角色id
	 * @param list 操作id集
	 * 
	 */
	public void authRole(int roleId, List<Integer> list);
}
