<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal-contentbox">
	<ol class="breadcrumb breadcrumb_margin">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">角色管理</a>
	    </li>
	    <li><a href="" url="./pages/role/rolelist">角色列表</a></li>
	    <li class="active">查看角色</li>
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
<div class="modal-dialog modal-lg" role="document">
	<!-- 传id -->
	<input type="hidden" value="${role.id}" name="roleId" id="roleId">
	<div class="modal-content">
	<div class="row role_hearder">
	        <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 role_hearde_font">
	            <span>查看角色</span>
	        </div>
	        <div class="pull-right col-lg-2 col-md-2 col-sm-3 col-xs-4 role_hearde_icon">
	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon red_border">
	            	
	            	<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
	                <!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
	            </div>
	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1  role_hearde_this_icon  blue_border">
	                <!--<a href=""><span class="glyphicon glyphicon-resize-small blue_back"></span></a>-->
	                
	                <img src="${pageContext.request.contextPath}/img/sys/modal3.png" alt="" />
	            </div>
	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon green_border dom_minimize">
	                <!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
	                <img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
	                <div class="hidmission">
						<span class="icon-eye-open icon-slidenav"></span>
						<p url="./pages/role/look" mintype='2'>查看角色</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>
	            </div>
	        </div>
	    </div>
		<div class="modal-header">
			<div class="pull-right">
				<a href="javascript:;" data-dismiss="modal" class="minus module_minimize">
					<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
					<div class="hidmission">
						<span class="icon-eye-open icon-slidenav"></span>
						<p class="lookRole" mintype='1'>查看角色</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>
				</a>
				<a  href="javascript:;" class="external-link">
					<img src="${pageContext.request.contextPath}/img/sys/modal3.png"/>
				</a>
				<a href="javascript:;" class="remove" data-dismiss="modal">
					<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
				</a>
			</div>
			<h4 class="modal-title">
							<span>|</span><b>查看角色</b>
						</h4>
		</div>
		<div class="modal-body">
			<table class="table table-striped">
				<tr>
					<td class="col-lg-2">角色名称</td>
					<td>${role.roleName}</td>
				</tr>
				<tr>
					<td>父级角色</td>
					<td><c:out value="${role.rolePName }" default="无"/></td>
				</tr>
				<tr>
					<td>依赖角色</td>
					<td><c:out value="${role.roleRelyName }" default="无"/></td>
				</tr>
				<tr>
					<td>最大限制用户数</td>
					<td>${role.roleMaxNum }</td>
				</tr>
				<tr>
					<td>备注消息</td>
					<td><c:out value="${role.remarks }" default="无"/></td>
				</tr>
			</table>
		</div>
	</div>
</div>
</div>
<script>
//放大
$(".external-link").on("click", function(e) {
	e.preventDefault()
	e.stopPropagation()
	$(this).closest('.modal').modal('hide')
	$(this).closest('.modal-contentbox').addClass('looklg')
	$(this).closest('.modal-contentbox').appendTo($(".ajax_dom"))
	$('.ajax_dom').show(0)
})
// 缩小
$(".blue_border").on("click", function() {
	$(this).closest('.modal-contentbox').appendTo('#lookRoleModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
    $(this).closest('.modal-contentbox').removeClass('looklg')
    $(this).closest('.modal').modal('show')
})
// 关闭按钮
$('.red_border').on('click',function(){
	$(this).closest('.modal-contentbox').remove();
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
// 最小化隐藏
$('.dom_minimize').on('click',function(){
	$(this).closest(".modal-contentbox").prependTo($(".minbox"));
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
$('.module_minimize').on('click',function(){
	$(this).closest('.modal').modal('hide');
	$(this).closest(".modal-contentbox").prependTo($(".minbox"));
})
</script>