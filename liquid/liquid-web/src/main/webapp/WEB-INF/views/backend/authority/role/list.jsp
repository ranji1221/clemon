<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/role/list.js"></script>
<script src="${pageContext.request.contextPath}/js/twbs-pagination-1.4.1/jquery.twbsPagination.js"></script>

<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonForm.js"></script>

<script >
function roleListInit(){
	$("#rolesList").LemonCreateTable({
	    requestListUrl : '${pageContext.request.contextPath}/backend/authority/role/data',
	    pageClassName:".tfoot",
	   	trForm : function(index,value){
			var Pname = value.rolePName == null ? '无':value.rolePName ;
			var tr_data = '<tr role_id='+value.id+'>'+
				'<td class="checkboxtd">'+
					'<label>'+
						'<input  type="checkbox" name="layout">'+
					'</label>'+
				'</td>'+
				'<td>'+
					(index+1) +
				'</td>'+
				'<td title="首页">'+
					value.roleName +//${role.roleName}
				'</td>'+
				'<td title="首页">'+
				     Pname +
				'</td>'+
				'<td>'+
					'<span class="icon-eye-open iconact lookRole"></span> '+
				'</td>'+
				'<td>'+
					'<span class="icon-pencil iconact editRole" n_id="1"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-trash iconact removeBtn"></span>'+
				'</td>'+
				'<td>'+
					'<span class="icon-key iconact"></span>'+
				'</td>'+
			'</tr>';
	       	return tr_data; 
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
			console.log(data.success)
			if(data.success == true) {
				$('.alertArea').showAlert({content:'删除成功'});
				removeStorage();
				roleListInit();
			}else{
				$('.alertArea').showAlert({content:'删除失败',type:'danger'});
			}
		},'json') 
	}
});
</script>

<div class="rolelist roleslist">
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="${pageContext.request.contextPath}/backend/authority/role/list">角色管理</a>
	    </li>
	    <li class="active">角色列表</li>
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
			<%-- <c:forEach items="${roleList}" var = "role">
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						01
					</td>
					<td title="首页">
						${role.roleName}
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole" n_id="1"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				</c:forEach> --%>
				<!-- <tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						02
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole" n_id="2"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						03
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						04
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						05
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						06
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr>
				<tr>
					<td class='checkboxtd'>
						<label>
							<input  type="checkbox" name="layout">
						</label>
					</td>
					<td>
						07
					</td>
					<td title="首页">
						首页
					</td>
					<td title="首页">
						首页
					</td>
					<td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td>
					<td>
						<span class="icon-pencil iconact editRole"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn"></span>
					</td>
					<td>
						<span class="icon-key iconact"></span>
					</td>
				</tr> -->
				
			</tbody>
		</table>
		<div class="tfoot">
			<div class="btns">
				<span class="newPro" url="${pageContext.request.contextPath}/backend/authority/role/add">
					<img src="${pageContext.request.contextPath}/img/sys/icons4.png" alt="">
					新建
				</span>
				<span>
					<img src="${pageContext.request.contextPath}/img/sys/icons1.png" alt="">
					刷新
				</span>
				<span class="removeBtn">
					<img src="${pageContext.request.contextPath}/img/sys/icons2.png" alt="">
					删除
				</span>
			</div>
			
		</div>
	</div>

<!-- 最大化容器 -->
<div class="maxcontainer">
	
</div>