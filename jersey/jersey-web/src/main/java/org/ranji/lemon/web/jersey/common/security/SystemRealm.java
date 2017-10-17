package org.ranji.lemon.web.jersey.common.security;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
		UsernamePasswordToken token = (UsernamePasswordToken)authToken;
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("username", token.getUsername());
		List<User> users = userService.findAll(params);
		User user = null;
		if(users!=null && users.size()>0) user = users.get(0);
		
		AuthenticationInfo authenInfo = null;
		if(user != null)
			authenInfo = new SimpleAuthenticationInfo(user.getUsername(),user.getPassword(),getName());
		return authenInfo;
	}
}
