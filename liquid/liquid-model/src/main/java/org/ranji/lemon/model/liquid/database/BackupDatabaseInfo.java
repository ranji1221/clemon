package org.ranji.lemon.model.liquid.database;

import org.ranji.lemon.common.core.model.AbstractModel;
import org.ranji.lemon.common.core.util.JsonUtil;

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
 * 数据库备份实体类
 * @author fengjie
 * @date 2017-10-18
 * @since JDK1.7
 * @version 1.0
 */

public class BackupDatabaseInfo extends AbstractModel{

	private static final long serialVersionUID = 321218137445161535L;
	
	private String infoName;    //备份名
	private String path;		//备份路径
	private String remark;		//备注
	
	public BackupDatabaseInfo(){
		
	}
	
	public String getInfoName() {
		return infoName;
	}
	public void setInfoName(String infoName) {
		this.infoName = infoName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return JsonUtil.objectToJson(this);
	}

}
