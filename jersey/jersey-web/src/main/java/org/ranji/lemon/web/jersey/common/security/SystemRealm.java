package org.ranji.lemon.web.jersey.common.security;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.ranji.lemon.model.jersey.auth.User;
import org.ranji.lemon.service.jersey.auth.prototype.IUserService;
import org.springframework.beans.factory.annotation.Autowired;

public class SystemRealm extends AuthorizingRealm {
	
	@Autowired
	private IUserService userService;
	
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authToken) throws AuthenticationException {
		AuthenticationInfo authenInfo = null;
		UsernamePasswordToken token = (UsernamePasswordToken)authToken;
		User user = userService.findByUserName(token.getUsername());
		if(user!=null)authenInfo = new SimpleAuthenticationInfo(user.getUsername(),user.getPassword(),getName());
		return authenInfo;
	}
}
