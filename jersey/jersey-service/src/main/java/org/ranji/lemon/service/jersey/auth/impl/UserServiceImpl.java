package org.ranji.lemon.service.jersey.auth.impl;

import java.util.List;

import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.jersey.auth.User;
import org.ranji.lemon.persist.jersey.auth.prototype.IUserDao;
import org.ranji.lemon.service.jersey.auth.prototype.IUserService;
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
	public void save(User entity) {
		entity.setPassword(new DefaultPasswordService().encryptPassword(entity.getPassword()));
		super.save(entity);
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

}
