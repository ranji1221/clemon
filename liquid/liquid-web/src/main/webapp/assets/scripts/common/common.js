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
	function getListByTree(tree){
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
	
	//获取资源和操作的树结构
	function getResourceAndOperationData(){
		var resourceAndOperationData = getStorage('resourceAndOperationData');
		if(resourceAndOperationData){
			return resourceAndOperationData;
		}else{
	        $.ajax({
	            type: "POST",
	            url:"backend/authority/resource/get/resourceAndOperation",
	            dataType:"json",
	            async: false,
	            success:function(data) {
	            	data = jsTree_DealRequest(data);
	            	jsonarray = jsTree_DealTreeData(data);
	            	setStorage('resourceAndOperationData',jsonarray);
	            	return jsonarray;
	            },
	            error:function(){
	            	console.log('获取资源和操作的请求地址错误!:'+url);
	            }
	        });
		}
	}
	function jsTree_DealRequest(data){
		var operation = data.operation;
		var resource = data.resource;
		for(var i=0;i<resource.length;i++){
			resource[i].id = 'r_'+resource[i].id;
			resource[i].type='resource';
			if(resource[i].resourcePId > 0) resource[i].resourcePId = 'r_'+resource[i].resourcePId;
		}
		for(var i=0;i<operation.length;i++){
			var tem_data = {};
			tem_data.type='operation';
			tem_data.id = 'o_'+operation[i].id;
			tem_data.resourceName = operation[i].operationName;
			tem_data.resourcePId = 'r_'+operation[i].resourceId;
			resource.push(tem_data);
		}
		return resource;
	}
	function jsTree_DealTreeData(data){
		var tree_data = [];
		for(var i=0;i<data.length;i++){
			var tem_item = {};
			tem_item.id = data[i].id;
			if(data[i].resourcePId <= 0){
				tem_item.parent = '#';
			}else{
				tem_item.parent = data[i].resourcePId;	
			}
			
			tem_item.text = data[i].resourceName;
			
			tem_item.state = {};
			//tem_item.state.selected = true;
			//if(!data[i].state) tem_item.state.disabled = true;
			
			tem_item.state.opened = true;
			tree_data.push(tem_item);
		}
		return tree_data;
	}
	function jsTree_selectedOperation(resourceAndOperationData,selectedOperationData){
		for(var i=0;i<selectedOperationData.length;i++){
			for(var j=0;j<resourceAndOperationData.length;j++){
				if( 'o_'+selectedOperationData[i].id == resourceAndOperationData[j].id){
					resourceAndOperationData[j].state.selected = true;
					if(!selectedOperationData[i].state) resourceAndOperationData[j].state.disabled = true;
					continue;
				}
			}
		}
		return resourceAndOperationData;
	}
	function jsTree_getSelectedOperationIds(class_name){
		var treeResult = $(class_name).jstree(true).get_checked([]);
		var new_treeData = '';
		for(var i=0;i<treeResult.length;i++){
			if(treeResult[i].state.disabled == false){
				var id = treeResult[i].id;
				var type = id.substring(0,1);
				if(type == 'o'){
					if(new_treeData){
						new_treeData += ','+id.substring(2);
					}else{ 
						new_treeData = id.substring(2);
					}
				}
			}
		}
		return new_treeData;
	}