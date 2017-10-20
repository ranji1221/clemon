package org.ranji.lemon.service.liquid.database.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ResourceBundle;
import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.liquid.database.BackupDatabaseInfo;
import org.ranji.lemon.service.liquid.database.prototype.IBackupDatabaseService;
import org.springframework.stereotype.Repository;

@Repository
public class BackupDatabaseServiceImpl extends GenericServiceImpl<BackupDatabaseInfo, Integer>implements IBackupDatabaseService {
	
	private static String hostIP;     //数据库IP地址
	private static String userName;	  //数据库用户名
	private static String password;   //数据库密码
	//private static String dbName;     //数据库名
		
	@Override
	public void backup(String path) throws IOException{
		initVariableByProperties();
		Runtime runtime = Runtime.getRuntime();
		//-u后面是用户名，-p是密码-p后面最好不要有空格，-family是数据库的名字
		String cmd = "cmd /c mysqldump -h "+ hostIP +" -u "+ userName +" -p"+ password +" --set-charset=UTF8 lemon";
		System.out.println(cmd);
		Process process = runtime.exec(cmd);
		InputStream inputStream = process.getInputStream();//得到输入流，写成.sql文件
		InputStreamReader reader = new InputStreamReader(inputStream,"utf-8");
		BufferedReader br = new BufferedReader(reader);
		String s = null;
		StringBuffer sb = new StringBuffer();
		while((s = br.readLine()) != null){
			sb.append(s+"\r\n");
		}
		s = sb.toString();
		File file = new File(path);
		file.getParentFile().mkdirs();
		FileOutputStream fileOutputStream = new FileOutputStream(file);
		fileOutputStream.write(s.getBytes());
		fileOutputStream.close();
		br.close();
		reader.close();
		inputStream.close();
	}
	
	@Override
	public void recover(String path) throws IOException {
		initVariableByProperties();  //初始化数据库连接
		Runtime runtime = Runtime.getRuntime();
		Process process = runtime.exec("cmd /c mysql -h "+ hostIP +" -u "+ userName +" -p"+ password +" --default-character-set=utf8 lemon");
		OutputStream outputStream = process.getOutputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(path)));
		String str = null;
		StringBuffer sb = new StringBuffer();
		while((str = br.readLine()) != null){
			sb.append(str+"\r\n");
		}
		str = sb.toString();
		System.out.println(str);
		OutputStreamWriter writer = new OutputStreamWriter(outputStream,"utf-8");
		writer.write(str);
		writer.flush();
		outputStream.close();
		br.close();
		writer.close();
		
	}
	/**
	 * 初始化数据库连接信息（通过properties文件获取）
	 * @throws IOException 
	 */
	private void initVariableByProperties() throws IOException{
		//1  通过java.util.ResourceBundle类来读取
		ResourceBundle resource = ResourceBundle.getBundle("config/jdbc");
		userName = resource.getString("jdbc.username");
		password = resource.getString("jdbc.password");
		String url = resource.getString("jdbc.url");
		//获取IP地址
		hostIP = url.split("/")[2].split(":")[0];
	}
	
	
}
