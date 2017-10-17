package org.ranji.lemon.persist.jersey.atuh;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.model.jersey.auth.Role;
import org.ranji.lemon.persist.jersey.auth.prototype.IRoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/spring-persist.xml")
public class RoleTest {
	
	@Autowired
	IRoleDao roleDao;
	
	@Test
	public void testAddRole(){
		Role r = new Role();
		r.setRoleName("wwwwwww");
		r.setDescription("234");
		System.out.println(r);
		roleDao.save(r);
	}
	
	@Test
	public void testFindRole(){
		Role r = roleDao.find(1);
		System.out.println(r);
		
	}
	@Test
	public void testUpdateRole(){
		Role r = new Role();
		r.setRoleName("wrerr");
		r.setId(1);
		roleDao.update(r);
	}
}
