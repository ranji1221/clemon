<%@ page language="java" pageEncoding="UTF-8" %>
<script>
function roleAuthFun(){
	console.log('this is roleAuthFun');
}
function roleAuthInit(data){
	$("#auth_roleName").val(data.roleName);
	var url = '${pageContext.request.contextPath}/backend/authority/role/getOperation';
	var request_data = {"roleId":data.id};
	$.post(url,request_data,function(respond_data){
		//渲染页面
		createTreePlug(".role-authorization-jstree",respond_data);
	})

}
//渲染树插件
function createTreePlug(className,data){
	console.log(data)
	var tree_data = [];
	for(var i=0;i<data.length;i++){
		var tem_item = {};
		tem_item.id = data[i].id;
		if(data[i].operationPId <= 0){
			tem_item.parent = '#';
		}else{
			tem_item.parent = data[i].operationPId;	
		}
		
		tem_item.text = data[i].operationName;
		
		tem_item.state = {};
		tem_item.state.selected = true;
		//if(!data[i].state) 
			tem_item.state.disabled = true;
		
		tem_item.state.opened = true;
		tree_data.push(tem_item);
			
	}
	console.log(tree_data);
	$(className).jstree({
		'core' : {
			'themes':{'icons':false},
	        'data' : tree_data
	       /* [
		        {"id":"1","parent":"#","text":"研发部"},
		        {"id":"2","parent":"1","text":"UI设计师","state":{"selected":true,"disabled" : true}},
		        {"id":"3","parent":"1","text":"前端工程师","state":{"selected":true,"disable":false}},
		        {"id":"4","parent":"1","text":"PHP工程师","state":{"selected":true}},
		        {"id":"5","parent":"1","text":"JAVA工程师",},
		        {"id":"6","parent":"1","text":"PHP工程师",},
		        {"id":"7","parent":"1","text":"PHP工程师",},
		        {"id":"8","parent":"#","text":"研发部2"},
		        {"id":"9","parent":"8","text":"UI设计师","state":{"selected":true}},
		        {"id":"10","parent":"8","text":"前端工程师","state":{"selected":true}},
		        {"id":"11","parent":"8","text":"PHP工程师","state":{"selected":true}},
		        {"id":"12","parent":"8","text":"JAVA工程师",},
		        {"id":"13","parent":"8","text":"PHP工程师",},
		        {"id":"14","parent":"8","text":"PHP工程师",},
		        {"id":"15","parent":"#","text":"研发部3"},
		        {"id":"16","parent":"15","text":"UI设计师","state":{"selected":true}},
		        {"id":"17","parent":"15","text":"前端工程师","state":{"selected":true}},
		        {"id":"18","parent":"15","text":"PHP工程师","state":{"selected":true}},
		        {"id":"19","parent":"15","text":"JAVA工程师",},
		        {"id":"20","parent":"15","text":"PHP工程师",},
		        {"id":"21","parent":"15","text":"PHP工程师",},
		        {"id":"22","parent":"#","text":"研发部4"},
		        {"id":"23","parent":"22","text":"UI设计师","state":{"selected":true}},
		        {"id":"24","parent":"22","text":"前端工程师","state":{"selected":true}},
		        {"id":"25","parent":"22","text":"PHP工程师","state":{"selected":true}},
		        {"id":"26","parent":"22","text":"JAVA工程师",},
		        {"id":"27","parent":"22","text":"PHP工程师",},
		        {"id":"28","parent":"22","text":"PHP工程师",},
	      	]*/
	    },
		"plugins": ["checkbox"],
		"checkbox": {
			"keep_selected_style": false,
			'cascade_to_disabled':false,
			// 'tie_selection':false,
		},
	});
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
						<a href="javascript:;" class="min module_minimize" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="">
							<div class="hidmission">
								<span class="icon-key icon-slidenav"></span>
								<p class='role-aut' mintype='1'>角色授权</p>
								<span class="iconfont icon-chuyidong1 del"></span>
							</div>
						</a>
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
						<a href="javascript:;" class="min dom_minimize" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="">
							<div class="hidmission">
								<span class="icon-key icon-slidenav"></span>
								<p mintype='2'>角色授权</p>
								<span class="iconfont icon-chuyidong1 del"></span>
							</div>
						</a>
						<!-- <a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4"> -->
						<a href="javascript:;" class="maxrole narrowAction" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal3.png" alt="">
						</a>
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
									<div class="role-authorization-jstree">
									
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
							<button type="submit" class="btn btn-default" data-dismiss="modal">确定</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					  	</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>