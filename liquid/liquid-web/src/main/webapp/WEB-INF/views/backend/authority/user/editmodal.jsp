<%@ page language="java" pageEncoding="UTF-8" %>
<script  src="${pageContext.request.contextPath}/js/validate/validate.js "></script>
<script>
$(document).on("click","#submit_editUser",function(){
	$.post("${pageContext.request.contextPath}/backend/authority/user/edits",
		{
			id:$("#edit_userId").val(),
			userName:$("#edit_userName").val(),
			phone:$("#edit_phone").val(),
			email:$("#edit_email").val()
		},function(data){
			if(data.success){
				removeStorage();
				userListInit();
				alert("成功啦");
			}
			else{
				alert("失败啦")
			}
		}
	,"json")
}) 
</script>
<div id="editModal" class="modalCon modal fade bs-example-modal-lg modalToBody" tabindex="-1" role="dialog">
<div class="maxcontainer editpage modal-contentbox" >
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">用户管理</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">用户列表</a>
	    </li>
	    <li class="active">编辑用户</li>
    	<div class="nav-search" id="nav-search">
			<form class="form-search">
				<div class="input-group">
			        <input type="text" class="form-control" placeholder="搜索你想找到的...">
			        <span class="input-group-btn">
			        <button class="btn btn-default" type="button">
						<img src="./assets/images/sys/iconsearch.png" alt="">
			        </button>
			        </span>
			    </div><!-- /input-group -->
			</form>
		</div>
	</ol>
	<!--  页面中的红色提示框-->
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i> 温馨提示：此页面展示角色查看操作。单击右方x号，可以关闭此条提示语！
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	<div class="title">
		<p>编辑用户</p>
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
		<form class="form-user-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >用户名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入用户名称" name='username'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-name">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group select">
		    	<label for="" >分配用户：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="fath">

							<option value="0" disabled="disabled">选择分配用户</option>
							<option value="1">用户列表</option>
							<option value="2">首页</option>
							<option value="3">用户列表</option>
							<option value="4">用户列表</option>

						</select>
				    	<span class="errormessage errormessage-role-edit-fath">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group phone">
		    	<label for="" >联系电话：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入联系电话" name='phone'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-phone">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group email">
		    	<label for="" >邮箱：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入邮箱" name='email'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-email">
			    		<!-- 您输入了特殊符号！ -->
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