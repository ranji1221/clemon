package org.ranji.lemon.persist.jersey.auth.impl;

import org.ranji.lemon.common.core.persist.impl.GenericDaoImpl;
import org.ranji.lemon.model.jersey.auth.Role;
import org.ranji.lemon.persist.jersey.auth.prototype.IRoleDao;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDaoImpl extends GenericDaoImpl<Role, Integer> implements IRoleDao {

}
