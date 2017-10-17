package org.ranji.lemon.persist.jersey.auth.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ranji.lemon.common.core.persist.impl.GenericDaoImpl;
import org.ranji.lemon.model.jersey.auth.Role;
import org.ranji.lemon.persist.jersey.auth.prototype.IRoleDao;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDaoImpl extends GenericDaoImpl<Role, Integer> implements IRoleDao {

	@Override
	public void saveRoleAndPermissionRelation(int roleId, String permission) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("roleId", roleId);
		params.put("permission", permission);
		sqlSessionTemplate.insert(typeNameSpace + ".saveRoleAndPermissionRelation", params);
		
	}

	@Override
	public void deleteRoleAndPermissionRelation(int roleId, String permission) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("roleId", roleId);
		params.put("permission", permission);
		sqlSessionTemplate.delete(typeNameSpace + ".deleteRoleAndPermissionRelation", params);
		
	}

	@Override
	public void deleteRoleAndPermissionRelationByRoleId(int roleId) {
		sqlSessionTemplate.delete(typeNameSpace + ".deleteRoleAndPermissionRelationByRoleId", roleId);
		
	}

	@Override
	public List<String> findRoleAndPermissionRelationByRoleId(int roleId) {
		return sqlSessionTemplate.selectList(typeNameSpace + ".findRoleAndPermissionRelationByRoleId", roleId);
	}

}
