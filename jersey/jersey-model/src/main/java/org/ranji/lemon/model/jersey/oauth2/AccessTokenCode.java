package org.ranji.lemon.model.jersey.oauth2;

import org.ranji.lemon.common.core.model.AbstractModel;
import org.ranji.lemon.common.core.util.JsonUtil;

public class AccessTokenCode extends AbstractModel{

	private static final long serialVersionUID = -2581666104681656032L;
	
	private String code;
	private String username;
	private String clientId;
	
	public AccessTokenCode(){
		
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	
	@Override
	public String toString() {
		return JsonUtil.objectToJson(this);
	}

}
