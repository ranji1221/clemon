<%@ page language="java" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/pagination/jquery.simplePagination.js"></script>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonGetList.js"></script>

<script>
function userListInit(){
	$("#userList").LemonGetList({
	    requestListUrl : '${pageContext.request.contextPath}/backend/authority/user/data',
		useLocalStorage: true,
		className_Page:"#page",
		generateItemFun : function(index,value,data,extend){
			var phone = value.phone == null ? '无':value.phone ;
			var email = value.email == null ? '无':value.email ;
			var createTime = value.createTime == null ? '无':value.createTime.substr(0,10);
			tr_data = '<tr user_id='+ value.id +extend+'>'+
				'<td class="checkboxtd">'+
					'<label>'+
						'<input  type="checkbox" name="layout">'+
					'</label>'+
				'</td>'+
				'<td>'+
					(index+1) +
				'</td>'+
				'<td title='+ value.userName +'>'+
					value.userName +
				'</td>'+
				'<td title='+ phone +'>'+
					phone +
				'</td>'+
				'<td title='+ email +'>'+
					email +
				'</td>'+
				'<td title='+ createTime +'>'+
					createTime +
				'</td>'+
				'<td>'+
					'<span class="icon-eye-open iconact viewUser"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-pencil iconact editUser"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-trash iconact removeBtn"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-key iconact userAuth"></span>'+
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
			$('#checkall').iCheck('uncheck')
   		}
	})
}
userListInit();
//复选框
$('.tablewrap input').iCheck({
    checkboxClass: 'icheckbox_flat-blue',
    radioClass: 'iradio_flat-blue',
    labelHover : true, 
  	cursor : false,
 });
$(document).on('ifChecked','#checkall', function(event){
  	$('.tablewrap input').iCheck('check')
});
	$(document).on('ifUnchecked', '#checkall',function(event){
  	$('.tablewrap input').iCheck('uncheck')
});

$('.user_removeAllBtn').bindDialogs({
	content : '你确定删除这些用户吗？',
	name_successBtn : 'deleteAllBtn',
	name_cancelBtn : 'cancelAllBtn',
	beforeFun:function(){
		if($(".tablewrap input:checked").length){
			return true;
		}else{
			return false;
		}
	},
	success:function(){
		var str="";
	  	$(".tablewrap input:checked").each(function(i,v){
	  		if($(this).closest('tr').attr("user_id")){
		  	str+=$(this).closest('tr').attr("user_id")+","
	  		}
	  		
	  	})
	  	str = str.substring(0,str.length-1)
		$.post("${pageContext.request.contextPath}/backend/authority/user/deleteAll",{
			user_ids:str,
		},function(data){
			if(data.success == true) {
				$('.alertArea').showAlert({content:'删除成功'});
				removeStorage();
				userListInit();
			}else{
				$('.alertArea').showAlert({content:'删除失败',type:'danger'});
			}
		},'json');
	}
})

$('.removeBtn').bindDialogs({
	content : '你确定删除这个用户吗？',
	success:function(handle){
		var userId = $(handle).closest('tr').attr('user_id');
		$.post("${pageContext.request.contextPath}/backend/authority/user/delete",{
			id:userId,
		},function(data){
			if(data.success == true) {
				$('.alertArea').showAlert({content:'删除成功'});
				removeStorage();
				userListInit();
			}else{
				$('.alertArea').showAlert({content:'删除失败',type:'danger'});
			}
		},'json');
	}
});
//刷新页面
$(document).on("click",".renovate",function(){
	removeStorage();
	userListInit();
})
//添加编辑事件
$(document).on("click", ".editUser", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	editUserModal(data);
});
//添加查看事件
$(document).on("click", ".viewUser", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	viewUser(data);
});
//添加查看用户授权事件
$(document).on("click", ".userAuth", function(e) {
	e.preventDefault();
	////获取到本地的某条数据
	var storage_name = $(this).closest('tr').attr('storage_name');
	var storage_id = $(this).closest('tr').attr('storage_id');
	var data = getDataByStorage(storage_name,storage_id);
	userAuth(data);
});
</script>

<div class="rolelist userlist">
	<ol class="breadcrumb">
		<li>
			<i class="glyphicon glyphicon-home"></i>
			<a href="#" data="2" url="home">首页</a>
		</li>
		<li>
			<a href="#" url="${pageContext.request.contextPath}/backend/authority/user/list">用户管理</a>
		</li>
		<li class="active">用户列表</li>
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
	<div class="alertArea"></div>
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i> 温馨提示：此页面展示用户列表，您可以对用户查看、编辑、删除、授权及批量删除和新建的操作。单击右方x号，可以关闭此条提示语！

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
					<th style="width:12.5%;min-width:94px;">
						编号
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<!-- <th style="width:25%"> -->
					<th>
						用户名
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th>
						手机号码
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th>
						邮箱
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th>
						创建时间
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
			<tbody id = "userList">
			
			</tbody>
		</table>
		<div class="tfoot">
			<div class="btns">
				<span class="newPro" url="${pageContext.request.contextPath}/backend/authority/user/add">
					<img src="${pageContext.request.contextPath}/img/sys/icons4.png" alt="">
					新建
				</span>
				<span class="renovate">
					<img src="${pageContext.request.contextPath}/img/sys/icons1.png" alt="">
					刷新
				</span>
				<span  class="user_removeAllBtn">
					<img src="${pageContext.request.contextPath}/img/sys/icons2.png" alt="">
					删除
				</span>
			</div>
			<div id="page">

			</div>
		</div>
	</div>
</div>
<!-- 模态框加载  -->
<%@ include file="viewmodal.jsp" %>
<%@ include file="editmodal.jsp" %>
<%@ include file="authmodal.jsp" %>
