package org.ranji.lemon.service.jersey.oauth2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.common.jersey.util.GuidUtil;
import org.ranji.lemon.model.jersey.oauth2.Client;
import org.ranji.lemon.service.jersey.oauth2.prototype.IClientService;
import org.ranji.lemon.service.jersey.oauth2.prototype.IOauthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/spring-persist.xml","classpath:config/spring-service.xml"})
public class ClientServiceTest {
	
	@Autowired
	IClientService clientService;
	
	@Autowired
	IOauthService oauthService;
	
	@Test
	public void testAddClient(){
		Client c = new Client();
		c.setClientName("nnnapp");
		c.setClientId(GuidUtil.generateClientId());
		c.setClientSecret(GuidUtil.generateClientSecret());
		
		clientService.save(c);
	}
	
	@Test
	public void testCheckClient(){
		System.out.println(oauthService.checkClientId("4CONO77qhHeYe6dbk70H"));
	}
}
