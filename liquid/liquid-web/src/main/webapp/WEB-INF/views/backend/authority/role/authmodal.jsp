<%@ page language="java" pageEncoding="UTF-8" %>
<script>

var is_first_into_page = true;

function roleAuthInit(data){
	$("#auth_roleName").val(data.roleName);
	createTreePlug('.role-authorization',data);

}
//渲染树插件
function createTreePlug(className,data){
	getResourceAndOperationData();
	var url = '${pageContext.request.contextPath}/backend/authority/role/getOperation';
	var request_data = {"roleId":data.id};
	if(!is_first_into_page){
		$(className).jstree("destroy");
	}
	is_first_into_page = false;
	$(className).jstree({
		'core' : {
			'themes':{'icons':false,"responsive":false},
	        'data' : function (obj, callback) {
	        	var resourceAndOperationData = getResourceAndOperationData();
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
	$result = jsTree_getSelectedOperationIds('.role-authorization');
	console.log($result);
})
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