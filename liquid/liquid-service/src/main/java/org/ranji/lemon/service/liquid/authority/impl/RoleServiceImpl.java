package org.ranji.lemon.service.liquid.authority.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.liquid.authority.Operation;
import org.ranji.lemon.model.liquid.authority.Role;
import org.ranji.lemon.persist.liquid.authority.prototype.IRoleDao;
import org.ranji.lemon.service.liquid.authority.prototype.IRoleService;
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
 * RoleService实现类
 * @author LiJianBo
 * @date 2017-9-14
 * @since JDK1.7
 * @version 1.0
 */
@Service
public class RoleServiceImpl extends GenericServiceImpl<Role, Integer> implements IRoleService {
	@Override
	public Role findByRoleName(String roleName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("roleName", roleName);
		List<Role> roles = ((IRoleDao) dao).findAll(params);
		if (roles.isEmpty()) {
			return null;
		} else {
			return roles.get(0);
		}
	}

	@Override
	public void saveRoleAndOperationRelation(int roleId, int operationId) {
		((IRoleDao) dao).saveRoleAndOperationRelation(roleId, operationId);
	}

	@Override
	public void deleteRoleAndOperationRelation(int roleId, int operationId) {
		((IRoleDao) dao).deleteRoleAndOperationRelation(roleId, operationId);

	}

	@Override
	public void deleteRoleAndOperationsRelationByRoleId(int roleId) {
		((IRoleDao) dao).deleteRoleAndOperationsRelationByRoleId(roleId);

	}

	@Override
	public List<Integer> findRoleAndOperationsRelationByRoleId(int roleId) {
		return ((IRoleDao) dao).findRoleAndOperationsRelationByRoleId(roleId);
	}

	@Override
	public List<Operation> findOperationByRoleId(int roleId) {
		return ((IRoleDao) dao).findOperationByRoleId(roleId);
	}
	
	
	@Override
	public List<Role> findRoleTree() {
		//return find(-1); //递归查询方法
		List<Role> roles= findAll(); //查出所有角色
		return listToTree(roles);	//转化为树形结构
	}
	//将集合转化为树形结构
	private List<Role> listToTree(List<Role> roles){
		List<Role> rootTrees = new ArrayList<Role>();
		for (Role role : roles) {
            if(role.getRoleExtendPId() == -1){
                rootTrees.add(role);
            	}
	        for (Role r : roles) {
	            if(r.getRoleExtendPId() == role.getId()){
	                if(role.getList() == null){
	                    List<Role> myRoles = new ArrayList<Role>();
	                    myRoles.add(r);
	                    role.setList(myRoles);
	                }else{
	                    role.getList().add(r);
	                }
	            }
	         }
       }
		return rootTrees;
	}
	//递归查询角色树
	private List<Role> find(int pid){
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("roleExtendPId", pid);
		
		List <Role> role = findAll(map);
		
		if(role.size()>0){
			for(Role r:role){
					r.setList(find(r.getId())); 	
			}
		}
		return role;
	}
	
}
