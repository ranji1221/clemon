package org.ranji.lemon.persist.jersey.auth.prototype;

import org.ranji.lemon.common.core.persist.prototype.IGenericDao;
import org.ranji.lemon.model.jersey.auth.User;



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
 * Oauth2用户Dao接口
 * @author fengjie
 * @date 2017-10-17
 * @since JDK1.7
 * @version 1.0
 */

public interface IUserDao extends IGenericDao<User,Integer>{
	
}
