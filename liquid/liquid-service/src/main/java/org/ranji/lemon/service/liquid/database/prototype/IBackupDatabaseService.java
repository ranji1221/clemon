package org.ranji.lemon.service.liquid.database.prototype;

import java.io.IOException;
import java.util.List;

import org.ranji.lemon.common.core.service.prototype.IGenericService;
import org.ranji.lemon.model.liquid.database.BackupDatabaseInfo;

/**
 * 数据库备份服务接口类
 * @author fengjie
 * @date 2017-10-16
 * @since JDK1.7
 * @version 1.0
 */
public interface IBackupDatabaseService extends IGenericService<BackupDatabaseInfo, Integer>{
	
	/**
	 * 数据库备份
	 * @param path 备份文件存储路径
	 * @param table 排除备份表集合
	 */
	public void backup(String path,List<String> table) throws IOException;
	
	/**
	 * 数据库还原
	 * @param path 备份文件存储路径
	 * 
	 */
	public void recover(String path) throws IOException;
}
