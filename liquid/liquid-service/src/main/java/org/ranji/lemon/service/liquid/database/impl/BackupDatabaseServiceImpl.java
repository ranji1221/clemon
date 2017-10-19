package org.ranji.lemon.service.liquid.database.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ResourceBundle;

import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.liquid.database.BackupDatabaseInfo;
import org.ranji.lemon.service.liquid.database.prototype.IBackupDatabaseService;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.stereotype.Repository;

import com.mchange.v2.c3p0.ComboPooledDataSource;

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
	/**
	 * 初始化数据库连接信息（通过properties文件获取）
	 * @throws IOException 
	 */
	private void initVariableByProperties() throws IOException{
		/*
		 * 1 利用类加载器获取配置文件信息
		 */
//		InputStream inStream = DBOperationImpl.class.getClassLoader().getResourceAsStream("config/jdbc.properties");
//		Properties prop = new Properties();  
//		prop.load(inStream);  
//		userName = prop.getProperty("jdbc.username","root"); //设置默认值
//		password = prop.getProperty("jbbc.password","root");
//		String url = prop.getProperty("jdbc.url");
		//2 通过java.util.ResourceBundle类来读取
		ResourceBundle resource = ResourceBundle.getBundle("config/jdbc");
		userName = resource.getString("jdbc.username");
		password = resource.getString("jdbc.password");
		String url = resource.getString("jdbc.url");
		//获取IP地址
		hostIP = url.split("/")[2].split(":")[0];
	}
	/**
	 * 初始化数据库连接信息（通过xml文件获取）
	 * 
	 */
	public void initVariableByXml(){
		URL path = BackupDatabaseServiceImpl.class.getClassLoader().getResource("config/spring-persist.xml");  //获取xml文件路径
		AbstractApplicationContext ac = new FileSystemXmlApplicationContext(path.toString());
		ComboPooledDataSource dataSource =(ComboPooledDataSource) ac.getBean("dataSource");
		ac.close();
		userName = dataSource.getUser();
		password = dataSource.getPassword();
		String url = dataSource.getJdbcUrl();
		//获取IP地址
		hostIP = url.split("/")[2].split(":")[0];
	}
}
