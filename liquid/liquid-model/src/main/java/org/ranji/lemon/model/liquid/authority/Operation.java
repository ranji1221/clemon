package org.ranji.lemon.model.liquid.authority;

import java.io.Serializable;

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
 * Authority模块中的Resource资源类
 * @author FengJie
 * @date 2017-9-13
 * @since JDK1.7
 * @version 1.0
 */

public class Operation implements Serializable{

	private static final long serialVersionUID = -7110169615874248183L;
	
	private int id;
	private String operationName; // 操作名 user：list
	private String displayName; // 操作名 中文
	private String operationURL; // 操作链接
	private int resourceId; // 资源ID 
	private int operationPId; //操作父id
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getOperationName() {
		return operationName;
	}
	
	public void setOperationName(String operationName) {
		this.operationName = operationName;
	}
	
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getOperationURL() {
		return operationURL;
	}
	
	public void setOperationURL(String operationURL) {
		this.operationURL = operationURL;
	}
	
	public int getResourceId() {
		return resourceId;
	}
	
	public void setResourceId(int resourceId) {
		this.resourceId = resourceId;
	}
	
	public int getOperationPId() {
		return operationPId;
	}
	
	public void setOperationPId(int operationPId) {
		this.operationPId = operationPId;
	}
	
	//重写对象比较规则
	@Override
	public boolean equals(Object obj) {  
	        if (this == obj)      //传入的对象就是它自己，如s.equals(s)；肯定是相等的；  
	            return true;   
	        if (obj == null)     //如果传入的对象是空，肯定不相等  
	            return false;  
	        if (getClass() != obj.getClass())  //如果不是同一个类型的，如Studnet类和Animal类，  
	                                           //也不用比较了，肯定是不相等的  
	            return false;  
	        Operation other = (Operation) obj;       
	        if (id == 0) {  
	            if (other.id != 0)  
	                return false;  
	        } else if (id!=other.getId())   //如果id属性相等，则相等  
	            return false;  
	        return true;  
	    }  
}