package org.ranji.lemon.service.jersey.oauth2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.model.jersey.oauth2.AccessToken;
import org.ranji.lemon.service.jersey.oauth2.prototype.IAccessTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/spring-persist.xml","classpath:config/spring-service.xml"})
public class AccessTokenServiceTest {
	
	@Autowired
	IAccessTokenService accessToken;
	
	@Test
	public void testAddAccessToken(){
		AccessToken at = new AccessToken();
		at.setToken("244f");
		at.setUsername("wews");
		accessToken.save(at);
	}
	
}
