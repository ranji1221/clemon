package org.ranji.lemon.persist.jersey.oatuh2;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.common.core.util.DateUtil;
import org.ranji.lemon.common.jersey.util.GuidUtil;
import org.ranji.lemon.model.jersey.oauth2.Client;
import org.ranji.lemon.persist.jersey.oauth2.prototype.IClientDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/spring-persist.xml")
public class ClientDaoTest {
	
	@Autowired
	IClientDao clientDao;
	
	@Test
	public void testAddClient(){
		Client c = new Client();
		c.setClientName("aaaapp");
		c.setClientId(GuidUtil.generateClientId());
		c.setClientSecret(GuidUtil.generateClientSecret());
		
		System.out.println(c);
		clientDao.save(c);
	}
	
	@Test
	public void testFindClient(){
		Client c = clientDao.find(1);
		System.out.println(c);
		System.out.println(DateUtil.toDateText(c.getCreateTime(), DateUtil.DEFAULT_DATE_TIME_FORMAT));
		System.out.println(DateUtil.toDateText(c.getUpdateTime(), DateUtil.DEFAULT_DATE_TIME_FORMAT));
		
		c.setClientName("estore");
		c.setUpdateTime(DateUtil.now());
		c.setScope("read,write");
		clientDao.update(c);
		System.out.println(c);
		System.out.println(c.getGuid());
		System.out.println(DateUtil.toDateText(c.getCreateTime(), DateUtil.DEFAULT_DATE_TIME_FORMAT));
		System.out.println(DateUtil.toDateText(c.getUpdateTime(), DateUtil.DEFAULT_DATE_TIME_FORMAT));
	}
}
