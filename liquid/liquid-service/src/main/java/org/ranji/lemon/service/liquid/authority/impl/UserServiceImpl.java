package org.ranji.lemon.service.liquid.authority.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.liquid.authority.Role;
import org.ranji.lemon.model.liquid.authority.User;
import org.ranji.lemon.persist.liquid.authority.prototype.IUserDao;
import org.ranji.lemon.service.liquid.authority.prototype.IUserService;
import org.springframework.stereotype.Service;
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
 * UserService实现类
 * @author RanJi
 * @date 2013-10-1
 * @since JDK1.7
 * @version 1.0
 */
@Service
public class UserServiceImpl extends GenericServiceImpl<User, Integer> implements IUserService {

	@Override
	public User findByUserName(String userName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userName", userName);
		List<User> users = ((IUserDao) dao).findAll(params);
		if (users.isEmpty()) {
			return null;
		} else {
			return users.get(0);
		}
	}

	@Override
	public User validate(String userName, String userPass) {
		User u = findByUserName(userName);
		if (u != null && u.getUserPass().equals(userPass)) {
			// 密码正确，通过验证
			return u;
		} else {
			// 密码错误
			return null;
		}
	}

	@Override
	public void saveUserAndRoleRelation(int userId, int roleId) {
		((IUserDao) dao).saveUserAndRoleRelation(userId, roleId);
		
	}

	@Override
	public void deleteUserAndRoleRelation(int userId, int roleId) {
		((IUserDao) dao).deleteUserAndRoleRelation(userId, roleId);
		
	}

	@Override
	public void deleteUserAndRolesByUserId(int userId) {
		((IUserDao) dao).deleteUserAndRolesRelationByUserId(userId);
		
	}

	@Override
	public List<Integer> findUserAndRolesByUserId(int userId) {
		return ((IUserDao) dao).findUserRolesRelationByUserId(userId);
	}

	@Override
	public List<Role> findRoleByUserId(int userId) {
		
		return ((IUserDao) dao).findRoleByUserId(userId);
	}

}
