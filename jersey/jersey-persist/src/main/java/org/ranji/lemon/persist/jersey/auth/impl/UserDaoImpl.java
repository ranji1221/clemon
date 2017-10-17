package org.ranji.lemon.persist.jersey.auth.impl;

import org.ranji.lemon.common.core.persist.impl.GenericDaoImpl;
import org.ranji.lemon.model.jersey.auth.User;
import org.ranji.lemon.persist.jersey.auth.prototype.IUserDao;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl extends GenericDaoImpl<User, Integer> implements IUserDao {

}
