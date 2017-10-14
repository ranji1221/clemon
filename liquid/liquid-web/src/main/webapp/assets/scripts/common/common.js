/**
 * Created by BOBO on 2017/10/11.
 */


	/**
	 * 处理lemon云平台本地存储
	 * @param key
	 * @param value
	 * @param storageType
	 */
	//把数据保持到缓存中
	function setStorage(key,value,storageType) {
		var storage = storageType || sessionStorage;
		var value = JSON.stringify(value);
		storage.setItem(key, value);
	}
	
	//获取缓存中的数据
	function getStorage(key,storageType) {
		var storage = storageType || sessionStorage;
		var valueString = storage.getItem(key);
		if(valueString) {
			var valueObject = JSON.parse(valueString);
			return valueObject;
		}else {
			return null;
		}
	}
	
	//删除缓存中的数据
	function removeStorage(key,storageType) {
		var storage = storageType || sessionStorage;
		if(key) {
			storage.removeItem(key);
		}else {
			storage.clear();
		}
	}
	
	//获取某条具体的数据
	function getDataByStorage(storageName,index){
		var data = getStorage(storageName);
		if(data && data.rows && data.rows[index]){
			return data.rows[index];
		}else{
			return null;
		}
	}
	//树转数组，（入口方法）
	function getListByData(tree){
		var listData = [];
		return treeToList(tree,listData,0);
		
	}
	//树转数组
	function treeToList(tree,listData,level){
		for(var i=0; i<tree.length;i++){
			var tem_childern_data = tree[i].list;
			tem_tree = tree[i];
			tem_tree.list = {};
			tem_tree.level = level;
			listData.push(tem_tree);
			if(tem_childern_data.length > 0){
				treeToList(tem_childern_data,listData,level+1);
			}
			
		}
		return listData;
	}
