package org.ranji.lemon.persist.jersey.oatuh2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.common.jersey.util.GuidUtil;
import org.ranji.lemon.model.jersey.oauth2.Client;
import org.ranji.lemon.persist.jersey.oauth2.prototype.IClientDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/spring-persist.xml")
public class ClientTest {
	
	@Autowired
	IClientDao clientDao;
	
	@Test
	public void testAddClient(){
		Client c = new Client();
		c.setClientName("aaaapp");
		c.setClientId(GuidUtil.generateClientId());
		c.setClientSecret(GuidUtil.generateClientSecret());
		
		clientDao.save(c);
	}
}
