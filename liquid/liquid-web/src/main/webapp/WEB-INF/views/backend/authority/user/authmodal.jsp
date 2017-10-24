<%@ page language="java" pageEncoding="UTF-8" %>
<script>
/**
* 查看用户授权模态框
*/
var is_first_into_page = true;
function userAuth(data) {
	$("#auth_userName").val(data.userName).attr('user_id',data.id);
	createTreePlug('.user-authorizationtree',data);
	this_user_role_list = [];
	$('.tree input').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	 });
	$('.checkallRoleaut,.slidedownallRoleaut').iCheck('uncheck')
}

//渲染树插件
function createTreePlug(className,data){
	var url = '${pageContext.request.contextPath}/backend/authority/user/getRole';
	var request_data = {"userId":data.id};
	
	if(!is_first_into_page) {$(className).jstree("destroy");}
	is_first_into_page = false;
	
	$(className).jstree({
		'core' : {
			'themes':{'icons':false,"responsive":false},
	        'data' : function (obj, callback) {
	        	var jstree_roleData = jsTree_dealRequestByRoleData(getRoleData());
	        	
		        $.ajax({
		            type: "POST",
		            url:url,
		            data:request_data,
		            dataType:"json",
		            async: false,
		            success:function(data) {
		            	role_data = jsTree_selectedOperation(jstree_roleData,data);
		            },
		            error:function(){
		            	console.log('获取本人所有的操作请求地址错误!:'+url);
		            }
		        });
	            callback.call(this, role_data);
	        }
	    },
		"plugins": ["checkbox"],
		"checkbox": {
			"keep_selected_style": false,
			'cascade_to_disabled':false,
			'three_state':false,
		},
		"check_callback" : true,
	});
	$(className).on("changed.jstree", function (e, data) {
		allRole = getListByTree(getRoleData());
		if(! (data.action == 'select_node' || data.action == 'deselect_node')) return false;
		var is_find = false;
		for(var i=0;i<allRole.length;i++){
			//找到选中的节点
			if(data.node.id == allRole[i].id){
				//如果是选中节点,判断是否有依赖节点
				if(data.action == 'select_node'){
					//找到它的父亲
					var roleRelyId = allRole[i].roleRelyId;
					if(roleRelyId > 0){
						for(var j=0;j<data.selected.length;j++){
							if(roleRelyId == data.selected[j]) {
								is_find = true;
								break;
							}
						}
						if(!is_find){
							//如果没有找到,执行这个操作
							alert('本角色的依赖角色没有选择 ,请先选择依赖角色:'+allRole[i].roleName);
							$(className).jstree(true).uncheck_node ([data.node.id]);
							return false;
						}
					}
					break;
				}else if(data.action == 'deselect_node'){
					//找到谁关联着他,如果他作为依赖角色,那么他的子角色将取消选中
					// 1 获取到他的id
					thieRoleId = allRole[i].id;
					// 2 获取依赖他的ids
					var arr_relyedIds = [];
					for(var k=0;k<allRole.length;k++){
						if(allRole[k].roleRelyId || allRole[k].roleRelyId == thieRoleId) arr_relyedIds.push(allRole[k]);
					}
					// 3 判断他的依赖角色是否没有被选中  如果选择上,那么提示用户,需要先将依赖他的角色取消点击
					for(var k=0;k<data.selected.length;k++){
						for(var j=0;j<arr_relyedIds.length;j++){
							if(data.selected[k] == arr_relyedIds[j].id){
								alert(arr_relyedIds[j].roleName+' 角色依赖于本角色,请先将其删除');
								$(className).jstree(true).check_node ([thieRoleId]);
								return false;
							}
						}
					}
				}

			}
		}
	  
	});  
}

//与树插件有关的方法
//获取角色列表
function getRoleData(){
	var resourceAndOperationData = getStorage('roleListData');
	if(resourceAndOperationData){
		return resourceAndOperationData;
	}else{
        $.ajax({
            type: "POST",
            url:"backend/authority/role/listAll",
            dataType:"json",
            async: false,
            success:function(data) {
            	setStorage('roleListData',data);
            	return data;
            },
            error:function(){
            	console.log('获取角色的请求地址错误!:'+url);
            }
        });
	}
}
function jsTree_dealRequestByRoleData(data){
    var	role_list = getListByTree(data);
    var role_form = [];
	for(var i=0;i<role_list.length;i++){
		role_form.push(createJsTreeItem(role_list[i].id,role_list[i].roleExtendPId,role_list[i].roleName));
	}
	return role_form;
}
function jsTree_selectedOperation(jstree_roleData,data){
	var tem_user_role = [];
	for(var i=0;i<data.length;i++){
		tem_user_role.push(createJsTreeItem(data[i].id,'','',true));
	}
	return selectJsTree(jstree_roleData,tem_user_role);
}
$('.user_auth_submit').on('click',function(){
	var request_data = {};
	request_data.userId = $("#auth_userName").attr('user_id');
	request_data.roleIds = jsTree_getSelectedNodes('.user-authorizationtree');
	var url = '${pageContext.request.contextPath}/backend/authority/user/auth';
	$.post(url,request_data,function(data){
		if(data.success == true) {
			$('.alertArea').showAlert({content:'授权成功'});
		}else{
			$('.alertArea').showAlert({content:'授权失败',type:'danger'});
		}
	},'json');
})
</script>

<!-- 用户授权 -->
<!-- Modal -->
<div class="modal fade modalToBody" id="user-authorization" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
  <div class="maxcontainer editpage modal-contentbox" >
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">角色管理</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">角色列表</a>
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
	<!--  页面中的红色提示框-->
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i> 温馨提示：此页面展示角色授权操作。单击右方x号，可以关闭此条提示语！
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	<div class="title">
		<p>角色授权</p>
		<div class="btns">
			<!-- <a href="javascript:;" class="min dom_minimize">
				<img src="./assets/images/sys/modal2.png" alt="">
				<div class="hidmission">
					<span class="icon-key icon-slidenav"></span>
					<p url='./pages/role/role-authorizationlg'>编辑角色</p>
					<span class="iconfont icon-chuyidong1 del"></span>
				</div>
			</a>
			<a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4">
				<img src="./assets/images/sys/modal3.png" alt="">
			</a> -->
			<a href="javascript:;" class="zclose edit_external_link" data-dismiss="modal">
				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
			</a>
		</div>
	</div>
	<div class="form_content">
		<form class="form-role-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >角色名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax form_input sliderInput">
				    	<input type="text" class="form-control rolenameinput" id="auth_roleName" placeholder="请输入角色名称" name='username' disabled>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-role-edit-name">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		 <div class="form-group tree">
		    	<label for="" >角色授权：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<header>
							<label for="checkallRoleaut">
								<input  type="checkbox" name="checkallaut" class="checkallRoleaut">
								选中全部
							</label>
							<label for='slidedownallRoleaut'>
								<input  type="checkbox" name="slidedownallaut" class="slidedownallRoleaut">
								展开全部
							</label>
							<label class="prompt visible-md visible-lg">
								温馨小提示：此
								<input  type="checkbox" name="disabled" checked disabled>
								为您的上级权限您无权更改
							</label>
						</header>
						<div class="treezl">
							<div class="role-authorization">
							
							</div>
						</div>
			    	
				    	<label class="prompt visible-sm visible-xs">
							温馨小提示：此
							<input  type="checkbox" name="disabled" checked disabled>
							为您的上级权限您无权更改
						</label>
			  	
				    	<span class="errormessage errormessage-role-edit-aut">
			    		
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="btnbox">
				<button type="button" class="btn btn-default submitbtn-role-edit" disabled>确定</button>
				<button type="button" class="btn btn-default">取消</button>
		  	</div>
		</form>
	</div>
</div>
</div>