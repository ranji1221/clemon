package org.ranji.lemon.persist.jersey.atuh;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.model.jersey.auth.User;
import org.ranji.lemon.persist.jersey.auth.prototype.IUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/spring-persist.xml")
public class UserTest {
	
	@Autowired
	IUserDao userDao;
	
	@Test
	public void testAddUser(){
		User u = new User();
		u.setUsername("lisi");
		u.setPassword("123456");
		System.out.println(u.getCreateTime());
		System.out.println(u);
		userDao.save(u);
	}
	
	@Test
	public void testFindUser(){
		User u = userDao.find(1);
		System.out.println(u);
		
	}
}
