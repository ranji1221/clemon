<%@ page language="java" pageEncoding="UTF-8" %>

<!-- 用户授权 -->
<!-- Modal -->
<div class="modal fade modalToBody" id="user-authorization" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
  	<div class="modal-contentbox" maxClassName="user-authorizationlg" narrowClassName="#user-authorization">
	  	<div class="modal-dialog" role="document">
	    	<div class="modal-content">
					<ol class="breadcrumb">
					    <li>
					    	<i class="glyphicon glyphicon-home"></i>
					    	<a href="#" data="2" url="home">首页</a>
					    </li>
					    <li>
					    	<a href="#" url="${pageContext.request.contextPath}/backend/authority/user/list" >用户管理</a>
					    </li>
					    <li>
					    	<a href="#" >用户列表</a>
					    </li>
					    <li class="active">用户授权</li>
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
						<p>用户授权</p>
						<div class="btns">
							<a href="javascript:;" class="maxuser enlargeAction">
								<img src="${pageContext.request.contextPath}/img/sys/modal3.png" alt="">
							</a>
							<a href="javascript:;" class="zclose" data-dismiss="modal">
								<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
							</a>
						</div>
					</div>
					<div class="titleautlg">
						<p>用户授权</p>
						<div class="btns">
							
							<a href="javascript:;" class="zclose  closeAction" data-dismiss="modal">
								<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
							</a>
						</div>
					</div>
					<div class="form_content">
					<form>
					  	<div class="form-group">
					    	<label for="username" class="username">用户名称
					    	<!-- <span class="errormessage">
					    		您输入了特殊符号！
					    	</span> -->
					    	</label>
					    	<div class="inputwrapper">
					    		<div class="inputwrappermax">
							    	<input type="text" class="form-control usernameinput" id="auth_userName" readonly>
							    	<span class="usernamelimit">11</span>
							    	<!-- <span class="icon-exclamation-sign"></span>
							    	<span class="icon-ok-sign"></span>
							    	<span class="errormessage">
						    		您输入了特殊符号！
						    		</span> -->
					    		</div>
					    	</div>
					  	</div>
					  	<div class="form-group">
					    	<label for="authorization">用户授权</label>
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
								<div class="treeuser">
									<div class="user-authorization-jstree">
									
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