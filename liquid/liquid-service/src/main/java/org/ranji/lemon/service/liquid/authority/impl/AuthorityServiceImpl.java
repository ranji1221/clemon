package org.ranji.lemon.service.liquid.authority.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.ranji.lemon.common.core.pagination.PagerModel;
import org.ranji.lemon.model.liquid.authority.Operation;
import org.ranji.lemon.model.liquid.authority.Role;
import org.ranji.lemon.model.liquid.authority.User;
import org.ranji.lemon.service.liquid.authority.prototype.IAuthorityService;
import org.ranji.lemon.service.liquid.authority.prototype.IOperationService;
import org.ranji.lemon.service.liquid.authority.prototype.IResourceService;
import org.ranji.lemon.service.liquid.authority.prototype.IRoleService;
import org.ranji.lemon.service.liquid.authority.prototype.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class AuthorityServiceImpl implements IAuthorityService{
	
	@Autowired
	private IUserService userService;
	@Autowired
	private IRoleService roleService;
	@Autowired
	private IResourceService resourceService;
	@Autowired
	private IOperationService operationService;

	
	private List<Role> roles = new ArrayList<Role>();//存储角色
	private List<Role> recRole	=new ArrayList<Role>();  //存储递归角色
	private List<Operation> operations= new ArrayList<Operation>(); //存储用户操集合
	private List<Operation> roleOperation = new ArrayList<Operation>(); //存储角色集合
	
	@Override
	public List<Role> userFindRole() {
		// TODO Auto-generated method stub
		return null;
	}
	
	//查询用户的所有角色及父级角色
	@Override
	public  List<Role> findRolesByUserId(int userId){	
		List<Role> list = userService.findRoleByUserId(userId);
			for(Role r:list){
				roles.add(r);
				int id = r.getRoleExtendPId();
				if(id>=0){
				 List<Role> r1=findRolesByRoleId(id);
				 roles.addAll(r1);
				}
			}
		return roles;
	}
	// 递归查询角色
	private List<Role> findRolesByRoleId(int roleId){
		Role r = roleService.find(roleId);
		recRole.add(r);
		if(r.getRoleExtendPId()>=0){
			findRolesByRoleId(r.getRoleExtendPId());
		}
		return recRole;
	}
	// 查询用户对应操作
	@Override
	public List<Operation> findOperationsByUserId(int userId) {
		List <Role> roleIds = findRolesByUserId(userId);
		List <Operation> opera = new ArrayList<Operation>();//临时存储操作集合（单一角色）
		for (Role role:roleIds){
			 opera = roleService.findOperationByRoleId(role.getId());
			 opera.removeAll(operations); // 移除所有和operations中一致的操作
			 operations.addAll(opera); //将剩余操作加入集合中
		}
		return operations;
	}
	// 查询角色对应操作
	@Override
	public List<Operation> findOperationsByRoleId(int roleId){
		
		roleOperation = roleService.findOperationByRoleId(roleId);
		for(Operation o :roleOperation){
			o.setState(true);
		}
		Role r = roleService.find(roleId);
		if(r.getRoleExtendPId()>=0){
			findRolesByRoleId(r.getRoleExtendPId());
		}
		for(Role r1 :recRole){
			List<Operation> opera = roleService.findOperationByRoleId(r1.getId());
			opera.removeAll(roleOperation); // 移除所有和operations中一致的操作
			roleOperation.addAll(opera); //将剩余操作加入集合中
		}
		return roleOperation;
	}

	@Override
	public String findAllUserInduleRoles(String params) {
		try {
			ObjectMapper om = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			if (!StringUtils.isEmpty(params)) {
				// 参数处理
				map = om.readValue(params, new TypeReference<Map<String, Object>>() {});
			}
			PagerModel<User> pg = userService.findPaginated(map);
			List<User> userList = pg.getData();
			for(User u: userList){
				List<Role> roles = userService.findRoleByUserId(u.getId());
				u.setRoleList(roles);
			}
			//序列化查询结果为JSON
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", pg.getTotal());
			result.put("rows", userList);
			return om.writeValueAsString(result);
		} catch (Exception e) {
			e.printStackTrace();
			return "{ \"total\" : 0, \"rows\" : [] }";
		}
	}
}


