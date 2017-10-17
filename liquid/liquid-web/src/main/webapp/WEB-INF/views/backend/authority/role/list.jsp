<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/role/list.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jquery.simplePagination.js"></script>

<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonGetList.js"></script>

<script >
function roleListInit(){
	$("#rolesList").LemonGetList({
		useLocalStorage : true,
	    requestListUrl : '${pageContext.request.contextPath}/backend/authority/role/data',
	    className_Page : "#page",
	    generateItemFun : function(index,value,data,extend){
			var Pname = value.rolePName == null ? '无':value.rolePName ;
			var tr_data = '<tr listid='+ value.id+extend +' role_id='+ value.id+extend +'>'+
				'<td class="checkboxtd">'+
					'<label>'+
						'<input  type="checkbox" name="layout">'+
					'</label>'+
				'</td>'+
				'<td>'+
					(index+1) +
				'</td>'+
				'<td title='+ value.roleName +'>'+
					value.roleName +//${role.roleName}
				'</td>'+
				'<td title='+ Pname +'>'+
				     Pname +
				'</td>'+
				'<td>'+
					'<span class="icon-eye-open iconact viewRole"></span> '+
				'</td>'+
				'<td>'+
					'<span class="icon-pencil iconact role_editRole"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-trash iconact removeBtn"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-key iconact roleAuth"></span>'+
				'</td>'+
			'</tr>';
	       	return tr_data; 
   		},
   		afterFun : function(){
			$('.tablewrap input').iCheck({
			    checkboxClass: 'icheckbox_flat-blue',
			    radioClass: 'iradio_flat-blue',
			    labelHover : true, 
			  	cursor : false,
			 });
   		},
   		initFun : function(){
   			_this = this;
   			$('.nav-search #list_search_btn').on('click',function(){
   				//刷新当前对象
   				_this.getData({'roleNameLike':$('.nav-search #list_search_str').val()});
   			})
   		}
	})
}
roleListInit();
$('.removeBtn').bindDialogs({
	content : '你确定删除这个角色吗？',
	success:function(handle){
		var roleId = $(handle).closest('tr').attr('role_id');
		$.post("${pageContext.request.contextPath}/backend/authority/role/delete",{
			id:roleId,
		},function(data){
			if(data.success == true) {
				$('.alertArea').showAlert({content:'删除成功'});
				removeStorage();
				roleListInit();
			}else{
				$('.alertArea').showAlert({content:'删除失败',type:'danger'});
			}
		},'json');
	}
});
//刷新页面
$(document).on("click",".renovate",function(){
	removeStorage();
	roleListInit();
});
//添加编辑事件
$(document).on("click", ".role_editRole", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	if($(this).attr('mintype')==1){
		return
	}else{
		//var editRole_id=$(this).closest('tr').attr('listid');
		//editRole(editRole_id);
	}
	showEditModal(data);
});
//添加查看事件
$(document).on("click", ".viewRole", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	viewRole(data);
	
//
//
//creatModule(data,function(data){
//		var appendDom = '<div class="modal-contentbox">'+
//		'<ol class="breadcrumb breadcrumb_margin">'+
//	    '<li>'+
//	    	'<i class="glyphicon glyphicon-home"></i>'+
//	    	'<a href="#" data="2" url="home">首页</a>'+
//	    '</li>'+
//	    '<li>'+
//	    	'<a href="#" url="/backend/authority/role/list">角色管理</a>'+
//	    '</li>'+
//	    '<li><a href="">角色列表</a></li>'+
//	    '<li class="active">查看角色</li>'+
//  	'<div class="nav-search" id="nav-search">'+
//			'<form class="form-search">'+
//				'<div class="input-group">'+
//			        '<input type="text" class="form-control" placeholder="搜索你想找到的...">'+
//			        '<span class="input-group-btn">'+
//			        '<button class="btn btn-default" type="button">'+
//						'<img src="/img/sys/iconsearch.png" alt="">'+
//			        '</button>'+
//			        </span>
//			    </div><!-- /input-group -->
//			</form>
//		</div>
//	</ol>
//<div class="modal-dialog modal-lg" role="document">
//	<!-- 传id -->
//	<input type="hidden" value="" name="roleId" id="roleId">
//	<div class="modal-content">
//		<div class="row role_hearder">
//	        <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 role_hearde_font">
//	            <span>查看角色</span>
//	        </div>
//	        <div class="pull-right col-lg-2 col-md-2 col-sm-3 col-xs-4 role_hearde_icon">
//	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon view_red_border">
//	            	
//	            	<img src="/img/sys/modal1.png" alt="">
//	                <!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
//	            </div>
//	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1  role_hearde_this_icon  view_blue_border">
//	                <!--<a href=""><span class="glyphicon glyphicon-resize-small blue_back"></span></a>-->
//	                
//	                <img src="/img/sys/modal3.png" alt="">
//	            </div>
//	            <div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon green_border dom_minimize">
//	                <!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
//	                <img src="/img/sys/modal2.png" alt="">
//	                <div class="hidmission">
//						<span class="icon-eye-open icon-slidenav"></span>
//						<p url="./pages/role/look" mintype="2">查看角色</p>
//						<span class="iconfont icon-chuyidong1 del"></span>
//					</div>
//	            </div>
//	        </div>
//	    </div>
//		<div class="modal-header">
//			<div class="pull-right">
//				<a href="javascript:;" data-dismiss="modal" class="minus module_minimize">
//					<img src="/img/sys/modal2.png" alt="">
//					<div class="hidmission">
//						<span class="icon-eye-open icon-slidenav"></span>
//						<p class="lookRole" mintype="1">查看角色</p>
//						<span class="iconfont icon-chuyidong1 del"></span>
//					</div>
//				</a>
//				<a href="javascript:;" class="view_external_link">
//					<img src="/img/sys/modal3.png">
//				</a>
//				<a href="javascript:;" class="remove" data-dismiss="modal">
//					<img src="/img/sys/modal1.png" alt="">
//				</a>
//			</div>
//				<h4 class="modal-title">
//					<span>|</span><b>查看角色</b>
//				</h4>
//			</div>
//			<div class="modal-body">
//				<table class="table table-striped">
//					<tbody><tr>
//						<td class="col-lg-2">角色名称</td>
//						<td id="view_roleName"></td>
//					</tr>
//					<tr>
//						<td>父级角色</td>
//						<td id="view_rolePName"></td>
//					</tr>
//					<tr>
//						<td>依赖角色</td>
//						<td id="view_roleRelyName"></td>
//					</tr>
//					<tr>
//						<td>最大限制用户数</td>
//						<td id="view_roleMaxNum">3</td>
//					</tr>
//					<tr>
//						<td>备注消息</td>
//						<td id="view_remarks"></td>
//					</tr>
//				</tbody></table>
//			</div>
//		</div>
//	</div>
//</div>
//	})
});
//添加查看角色授权事件
$(document).on("click", ".roleAuth", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	roleAuth(data);
});
</script>

<div class="rolelist roleslist">
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#">角色管理</a>
	    </li>
	    <li class="active">角色列表</li>
    	<div class="nav-search" id="nav-search">
    		<form class="form-search">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="搜索你想找到的..." id="list_search_str">
					<span class="input-group-btn">
			        <button class="btn btn-default" type="button" id="list_search_btn">
						<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
			        </button>
			        </span>
				</div>
				<!-- /input-group -->
			</form>
    	</div>
	</ol>
	<div class="alertArea"></div>
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i>

		<span class="alert_font">	温馨提示：此页面展示角色列表，您可以对角色查看、编辑、删除、授权及批量删除和新建的操作。单击右方x号，可以关闭此条提示语！</span>
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	<div class="tablewrap">
		<table class="table ">
			<thead>
				<tr>
					<th style="width:0.8rem" class='checkboxth'>
						<label for="checkall">
							<input  type="checkbox" name="layout" id="checkall" >
						</label>
					</th>
					<th style="min-width:94px;">
						编号
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<!-- <th style="width:25%"> -->
					<th>
						名称
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th>
						父角色
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th style="width:0.6rem">查看</th>
					<th style="width:0.6rem">编辑</th>
					<th style="width:0.6rem">删除</th>
					<th style="width:0.9rem;">授权</th>
				</tr>
			</thead>
			<tbody id = "rolesList">

			</tbody>
		</table>
		<div class="tfoot">
			<div class="btns">
				<span class="newPro" url="${pageContext.request.contextPath}/backend/authority/role/add">
					<img src="${pageContext.request.contextPath}/img/sys/icons4.png" alt="">
					新建
				</span>
				<span class="renovate">
					<img src="${pageContext.request.contextPath}/img/sys/icons1.png" alt="">
					刷新
				</span>
				<span class="removeBtn">
					<img src="${pageContext.request.contextPath}/img/sys/icons2.png" alt="">
					删除
				</span>
			</div>
			<div id="page" class=""></div>
		</div>
	</div>

<!-- 最大化容器 -->
<div class="maxcontainer">
	
</div>
<!-- 模态框加载  -->
<%@ include file="editmodal.jsp" %>
<%@ include file="viewmodal.jsp" %>
<%@ include file="authmodal.jsp" %>