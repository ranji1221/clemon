<%@ page language="java" pageEncoding="UTF-8" %>
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
	<div class="modal-contentbox"  maxClassName="looklg" narrowClassName="#editModal">
		<ol class="breadcrumb breadcrumb_margin">
			<li>
				<i class="glyphicon glyphicon-home"></i>
				<a href="#" data="2">首页</a>
			</li>
			<li>
				<a href="#" url="${pageContext.request.contextPath}/backend/authority/user/list">用户管理</a>
			</li>
			<li>
				<a href="">用户列表</a>
			</li>
			<li class="active">用户编辑</li>
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="搜索你想找到的...">
						<span class="input-group-btn">
					        <button class="btn btn-default" type="button">
								<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
					        </button>
					        </span>
					</div>
					<!-- /input-group -->
				</form>
			</div>
		</ol>
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content" u_id="3" >
			<div class="row user_hearder">
					<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 user_hearde_font">
						<span>编辑用户</span>
					</div>
					<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">
						<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon closeAction">
		
							<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
							<!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
						</div>
				
						
					</div>
				</div>
				
				<div class="modal-header">
					<div class="pull-right">
						
						<a href="javascript:;" class="edit_external_link">
							<img src="${pageContext.request.contextPath}/img/sys/modal3.png" />
						</a>
						<a href="javascript:;" class="remove" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
						</a>
					</div>
					<h4 class="modal-title">
									<span>|</span><b>编辑用户</b>
								</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<div class="col-xs-12 roleNameError text-right row-xs-h">
								<!--不要输入特殊符号-->
							</div>
							<div class="col-sm-2 col-xs-3 row-lg-h">
								<label for="userName" class=" control-label"><span class="dot">·</span>用户名：</label>
							</div>
							<div class="col-sm-10 col-xs-9 row-lg-h name_input">
								<input type="hidden" id="edit_userId">
								<input name="name" type="text" class="form-control bg-grey" id="edit_userName" placeholder="请输入用户名">
								<span class="wordNum">15</span>
							</div>
						</div>
						<div class="form-group has-feedback">
							<div class="col-xs-12 roleNameError text-right row-xs-h">
								<!--请输入正确的电话号码-->
							</div>
							<div class="col-sm-2 col-xs-3 row-lg-h">
								<label for="userTel" class=" control-label"><span class="dot">·</span>联系电话：</label>
							</div>
							<div class="col-sm-10 col-xs-9 row-lg-h">
								<input name="tel" type="text" class="form-control bg-grey" id="edit_phone" placeholder="请输入用户联系方式">
								<!--<span class="glyphicon glyphicon-ok form-control-feedback"></span>-->
								<!--<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>-->
							</div>
						</div>
						<div class="form-group has-feedback">
							<div class="col-xs-12 roleNameError text-right row-xs-h">
								<!--请输入正确的邮箱地址-->
							</div>
							<div class="col-sm-2 col-xs-3 row-lg-h">
								<label for="userName" class=" control-label"><span class="dot">·</span>邮箱：</label>
							</div>
							<div class="col-sm-10 col-xs-9 row-lg-h">
								<input name="emily" type="text" class="form-control bg-grey" id="edit_email" placeholder="请输入用户邮箱">
								<!--<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>-->
								<!--<span class="glyphicon glyphicon-exclamation-sign form-control-feedback" aria-hidden="false"></span>-->
							</div>
						</div>
						<div class="form-group">
							<div class="role_button">
								<div class="col-xs-6 role_succse" data-dismiss="modal">
									<button type="button" class="btn btn-default editSourceSubmit" id="submit_editUser">确定</button>
								</div>
								<div class="col-xs-6 role_remove">
									<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>