<%@ page language="java" pageEncoding="UTF-8" %>

<script src="${pageContext.request.contextPath}/js/common/modal.js"></script>

<div id="viewModal" class="modalCon modal fade bs-example-modal-lg modalToBody" tabindex="-1" role="dialog">
	<div class="modal-contentbox"  maxClassName="looklg" narrowClassName="#viewModal">
		<div class="modal-dialog modal-lg" role="document">
			<ol class="breadcrumb breadcrumb_margin">
	    		<li>
			    	<i class="glyphicon glyphicon-home"></i>
			    	<a href="#" data="2" url="hoem" >首页</a>
			    </li>
			    <li>
	    			<a href="#" url="${pageContext.request.contextPath}/backend/authority/user/list">用户管理</a>
	   			</li>
	   			<li><a href="">用户列表</a></li>
	    		<li class="active">查看用户</li>
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
			<div class="modal-content">
			<!--  页面中的红色提示框-->
			<div class="alert alert-danger">
				<i class="glyphicon glyphicon-hand-right"></i> 温馨提示：此页面展示用户查看操作。单击右方x号，可以关闭此条提示语！
				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
				<div class="row role_hearder">
        			<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 role_hearde_font">
            			<span>查看用户</span>
        			</div>
        			<div class="pull-right col-lg-2 col-md-2 col-sm-3 col-xs-4 role_hearde_icon">
           				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon closeAction">
            				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
            			</div>
            		
        			</div>
    			</div>
				<div class="modal-header">
					<div class="pull-right">
						<a href="javascript:;" class="enlargeAction">
							<img src="${pageContext.request.contextPath}/img/sys/modal3.png"/>
						</a>
						<a href="javascript:;" class="remove" data-dismiss="modal">
							<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
						</a>
					</div>
					<h4 class="modal-title">
						<span>|</span><b>查看用户</b>
					</h4>
				</div>
				<div class="modal-body">
				<div class="row modal_body_title">
					<h3>青柠云后台管理系统</h3>
				</div>
					<table class="table ">
						<tr>
							<td class="col-lg-2">用户名称</td>
							<td id="view_userName">马小米</td>
						</tr>
						<tr>
							<td>分配角色</td>
							<td id="view_role">超级管理员</td>
						</tr>
						<tr>
							<td>手机号码</td>
							<td id="view_phone">18666666666</td>
						</tr>
						<tr>
							<td>邮箱号码</td>
							<td id="view_email">234892390@qq.com</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>