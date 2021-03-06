package org.ranji.lemon.persist.liquid.log;

import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.ranji.lemon.model.liquid.log.SystemLog;
import org.ranji.lemon.persist.liquid.log.prototype.ISystemLogDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the"License"); 
 * you may not use this file except in compliance with the License.  
 * You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
 * See the License for the specific language governing permissions and limitations under the License.
 * Copyright [2017] [RanJi] [Email-jiran1221@163.com]
 * 
 * Authority模块中的SystemLogDao测试类
 * @author LiJianBo
 * @date 2017-9-21
 * @since JDK1.7
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/spring-persist.xml")
public class SystemLogDaoTest {

	@Autowired
	private ISystemLogDao systemLogDao;
	

	@Before
	public void init(){}
	
	//存储日志测试方法
	@Test
	public void testAddSystemLog(){
		for(int i = 1; i < 10; i++){
			SystemLog systemLog = new SystemLog();
			systemLog.setLogType("警告" + i);
			systemLog.setLogTitle("访问首页");
			systemLog.setRemoteAddr("192.168.1.16");
			systemLog.setRequestUri("192.168.1.16");
			systemLog.setMethod("post");
			systemLog.setParams("3");
			systemLog.setException("exception");
			systemLog.setAuthStatus(1);
			systemLog.setOperateDate(new Date());
			systemLog.setTimeout("3000");
			systemLog.setUserName("zhangsan");
			systemLogDao.save(systemLog);
		}
		
	}
	//删除日志测试方法
	@Test
	public void testDeleteSystemLog(){
		systemLogDao.delete(1);
	}
		
	//删除全部日志测试方法
	@Test
	public void testDeleteAllSystemLog(){
		systemLogDao.deleteAll();
	}
	
	//更新 日志测试方法
	@Test
	public void testUpdateSystemLog(){
		SystemLog sl = new SystemLog();
		sl.setId(2);
		sl.setLogType("警告11111");
		sl.setLogTitle("访问首页1");
		sl.setRemoteAddr("192.168.1.17");
		sl.setRequestUri("192.168.1.17");
		sl.setMethod("post1");
		sl.setParams("5");
		sl.setException("exception1");
		sl.setAuthStatus(2);
		sl.setOperateDate(new Date());
		sl.setTimeout("3000");
		sl.setUserName("zhangsan");
		systemLogDao.update(sl);
	}
	//查询所有日志测试方法
	@Test
	public void testFindAllSystemLog(){
		List<SystemLog> logs = systemLogDao.findAll();
		for(SystemLog ls: logs){
			System.out.println(ls.getLogType());
		}
	}
}
