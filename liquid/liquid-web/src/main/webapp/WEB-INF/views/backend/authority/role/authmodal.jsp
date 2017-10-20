<%@ page language="java" pageEncoding="UTF-8" %>
<script>

var is_first_into_page = true;

function roleAuthInit(data){
	$("#auth_roleName").val(data.roleName).attr('role_id',data.id);
	createTreePlug('.role-authorization',data);
}
//渲染树插件
function createTreePlug(className,data){
	var url = '${pageContext.request.contextPath}/backend/authority/role/getOperation';
	var request_data = {"roleId":data.id};
	if(!is_first_into_page){ $(className).jstree("destroy"); }
	is_first_into_page = false;
	$(className).jstree({
		'core' : {
			'themes':{'icons':false,"responsive":false},
	        'data' : function (obj, callback) {
	        	var resourceAndOperationData = jsTree_getResourceAndOperationData();
		        $.ajax({
		            type: "POST",
		            url:url,
		            data:request_data,
		            dataType:"json",
		            async: false,
		            success:function(data) {
		            	resourceAndOperationData = jsTree_selectedOperation(resourceAndOperationData,data);
		            },
		            error:function(){
		            	console.log('获取本人所有的操作请求地址错误!:'+url);
		            }
		        });
	            callback.call(this, resourceAndOperationData);
	        }
	    },
		"plugins": ["checkbox"],
		"checkbox": {
			"keep_selected_style": false,
			'cascade_to_disabled':false,
			// 'tie_selection':false,
		},
		"check_callback" : true,
	});
}
//提交编辑数据
$('#resSubmit').on('click',function(){
	var request_data = {};
	request_data.roleId = $("#auth_roleName").attr('role_id');
	request_data.operationIds = jsTree_getSelectedOperationIds('.role-authorization');
	var url = '${pageContext.request.contextPath}/backend/authority/role/auth';
	$.post(url,request_data,function(data){
		if(data.success == true) {
			$('.alertArea').showAlert({content:'授权成功'});
		}else{
			$('.alertArea').showAlert({content:'授权失败',type:'danger'});
		}
	},'json');
})
//与树插件有关的操作
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
            	setStorage('resourceAndOperationData',data);
            	return data;
            },
            error:function(){
            	console.log('获取资源和操作的请求地址错误!:'+url);
            }
        });
	}
}
function jsTree_getResourceAndOperationData(){
   	data = jsTree_DealRequest(getResourceAndOperationData());
   	jsonarray = jsTree_DealTreeData(data);
   	return jsonarray;
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
		tree_data.push(createJsTreeItem(data[i].id,data[i].resourcePId,data[i].resourceName));
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
</script>
<!-- 角色授权 -->
<!-- Modal -->
<div class="modal fade modalToBody" id="role-authorization" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-contentbox" maxClassName="role-authorizationlg" narrowClassName="#role-authorization" beforeMaxFunName="roleAuthFun">
	<div class="modal-dialog" role="document">
		<div class="modal-content" >
				<ol class="breadcrumb">
				    <li>
				    	<i class="glyphicon glyphicon-home"></i>
				    	<a href="#" data="2" url="home">首页</a>
				    </li>
				    <li>
				    	<a href="#" url="${pageContext.request.contextPath}/backend/authority/role/list">角色管理</a>
				    </li>
				    <li>
				    	<a href="#">角色列表</a>
				    </li>
				    <li class="active">角色授权</li>
			    	<div class="nav-search" id="nav-search">
						<form class="form-search">
							<div class="input-group">
						        <input type="text" class="form-control" placeholder="搜索你想找到的...">
						        <span class="input-group-btn">
						        <button class="btn btn-default" type="button">
									<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
						        </button>
						        </span>
						    </div><!-- /input-group -->
						</form>
					</div>
				</ol>
				<div class="titleaut">
					<p>角色授权</p>
					<div class="btns">
						<!-- <a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4"> -->
						<a href="javascript:;" class="maxrole enlargeAction" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal3.png" alt="">
						</a>
						<a href="javascript:;" class="zclose" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
						</a>
					</div>
				</div>
				<div class="titleautlg">
					<p>角色授权</p>
					<div class="btns">
						<!-- <a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4"> -->
						<a href="javascript:;" class="zclose closeAction">
							<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
						</a>
					</div>
				</div>
				<div class="form_content">
					<form>
					  	<div class="form-group">
					    	<label for="rolename" class="rolename">角色名称
					    	<!-- <span class="errormessage">
					    		您输入了特殊符号！
					    	</span> -->
					    	</label>
					    	<div class="inputwrapper">
					    		<div class="inputwrappermax">
					    			
							    	 <input type="text" class="form-control rolenameinput" id='auth_roleName' readonly>
							    	<!-- <span class="rolenamelimit">11</span> -->
							    	<!--<span class="icon-exclamation-sign"></span>
							    	<span class="icon-ok-sign"></span>
							    	  <span class="errormessage">
						    		您输入了特殊符号！
						    		</span>-->
					    		</div>
					    	</div>
					  	</div>
					  	<div class="form-group">
					    	<label for="authorization">角色授权</label>
					    	<div class="wrapper">
								<header>
									<label for="checkallaut">
										<input  type="checkbox" name="checkallaut" class="checkallaut">
										选中全部
									</label>
									<label for='slidedownallaut'>
										<input  type="checkbox" name="slidedownallaut" class="slidedownallaut">
										展开全部
									</label>
									<label class="prompt visible-md visible-lg">
										温馨小提示：此
										<input  type="checkbox" name="disabled" checked disabled>
										为您的上级权限您无权更改
									</label>
								</header>
								<div class="treezl">
									<div class="role-authorization-jstree treezl_j role-authorization">
									
									</div>
								</div>
					    	</div>
					    	<label class="prompt visible-sm visible-xs">
								温馨小提示：此
								<input  type="checkbox" name="disabled" checked disabled>
								为您的上级权限您无权更改
							</label>
					  	</div>
					  	<div class="btnbox">
							<button type="button" class="btn btn-default" data-dismiss="modal" id="resSubmit">确定</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					  	</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>