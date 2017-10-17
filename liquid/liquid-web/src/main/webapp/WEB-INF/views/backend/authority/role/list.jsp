<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/role/list.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jquery.simplePagination.js"></script>
<script src="${pageContext.request.contextPath}/js/common/modal.js"></script>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonGetList.js"></script>

<script >
function roleListInit(){
	$("#rolesList").LemonGetList({
		useLocalStorage : false,
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
   				_this.getData({
   					'params':JSON.stringify({
   						'rNameLike' : $('.nav-search #list_search_str').val()
   					})
   				},true);
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
	editRoleModal(data);
});
//添加查看事件
$(document).on("click", ".viewRole", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	viewRole(data);
});
//添加查看角色授权事件
$(document).on("click", ".roleAuth", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	auth(data);
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