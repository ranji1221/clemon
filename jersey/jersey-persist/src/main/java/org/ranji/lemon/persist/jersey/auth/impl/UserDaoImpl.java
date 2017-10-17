package org.ranji.lemon.persist.jersey.auth.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ranji.lemon.common.core.persist.impl.GenericDaoImpl;
import org.ranji.lemon.model.jersey.auth.User;
import org.ranji.lemon.model.jersey.auth.Role;
import org.ranji.lemon.persist.jersey.auth.prototype.IUserDao;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl extends GenericDaoImpl<User, Integer> implements IUserDao {

	@Override
	public void saveUserAndRoleRelation(int userId, int roleId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roleId", roleId);
		sqlSessionTemplate.insert(typeNameSpace + ".saveUserAndRoleRelation", params);	
	}

	@Override
	public void deleteUserAndRoleRelation(int userId, int roleId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roleId", roleId);
		sqlSessionTemplate.delete(typeNameSpace + ".deleteUserAndRoleRelation", params);	
	}

	@Override
	public void deleteUserAndRolesRelationByUserId(int userId) {
		sqlSessionTemplate.delete(typeNameSpace + ".deleteUserAndRolesRelationByUserId", userId);
		
	}

	@Override
	public List<Integer> findUserRolesRelationByUserId(int userId) {
		return sqlSessionTemplate.selectList(typeNameSpace + ".findUserRolesRelationByUserId", userId);
	}
	
	@Override
	public List<Role> findRoleByUserId(int userId){
		return sqlSessionTemplate.selectList(typeNameSpace + ".findRoleByUserId", userId);
	}
}
