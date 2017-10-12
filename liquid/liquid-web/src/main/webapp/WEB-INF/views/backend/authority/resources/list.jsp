<%@ page language="java" pageEncoding="UTF-8" %>
<!-- <link rel="stylesheet" href="./assets/styles/rolelist/rolelistREM.css" /> -->
<script src="${pageContext.request.contextPath}/js/twbs-pagination-1.4.1/jquery.twbsPagination.js"></script>

<script src="${pageContext.request.contextPath}/js/user/list.js"></script>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonForm.js"></script>
<script>
function resourceListInit(){
	$("#resourceList").LemonCreateTable({
	    requestListUrl : '${pageContext.request.contextPath}/backend/authority/resource/data',
	   	trForm : function(index,value){
	   		var thisType = '';
	   		switch(value.resourceType){
	   			case 1:
	   				thisType = '菜单';
	   				break;
	   			case 2:
	   				thisType = '文件';
	   				break;
	   			default:
	   				thisType = '未知';
	   				break;
	   		}
	   		if(!value.resourcePName) value.resourcePName = '无';
	   		var tr_data = '<tr resource_id='+ value.id +'>'+
	   			'<td class="checkboxtd">'+
	   				'<label>'+
	   					'<input  type="checkbox" name="layout">'+
	   				'</label>'+
	   			'</td>'+
	   			'<td>'+
	   				(index+1) +
	   			'</td>'+
	   			'<td title='+ thisType +'>'+
	   				thisType +
	   			'</td>'+
	   			'<td title='+ value.resourceName +'>'+
	   				value.resourceName +
	   			'</td>'+
	   			'<td title='+ value.resourcePName +'>'+
	   				value.resourcePName +
	   			'</td>'+
	   			'<td>'+
	   				'<span class="icon-eye-open iconact lookSource"></span>'+
	   			'</td>'+
	   			'<td>'+
	   				'<span class="icon-pencil iconact editSource" n_id="1"></span>'+
	   			'</td>'+
	   			'<td>'+
	   				'<span class="icon-trash iconact removeBtn"></span>'+
	   			'</td>'+
	   			'<td>'+
	   				'<span class="icon-trash iconact removeBtn"></span>'+
	   			'</td>'+
	   		'</tr>';
	       	return tr_data; 
   		}
	})
	//获取到本地的某条数据 示例代码
	$(document).on("click", ".roleName", function(e) {
		var storage_name = $(this).closest('tr').attr('storage_name');
		var storage_id = $(this).closest('tr').attr('storage_id');
		console.log(getDataByStorage(storage_name,storage_id));
	})
}
resourceListInit();
$('.removeBtn').bindDialogs({
	content : '你确定删除这个用户吗？',
	success:function(handle){
		var resourceId = $(handle).closest('tr').attr('resource_id');
		$.post("${pageContext.request.contextPath}/backend/authority/resource/delete",{
			id:resourceId,
		},function(data){
			if(data.success == true) {
				$('.alertArea').showAlert({content:'删除成功'});
				removeStorage();
				resourceListInit();
			}else{
				$('.alertArea').showAlert({content:'删除失败',type:'danger'});
			}
		},'json');
	}
});
</script>

<div class="rolelist sourcelist">
    <ol class="breadcrumb">
        <li>
            <i class="glyphicon glyphicon-home"></i>
            <a href="#" data="2" url="home">首页</a>
        </li>
        <li>
            <a href="#" url="${pageContext.request.contextPath}/backend/authority/resource/list">资源管理</a>
        </li>
        <li class="active">资源列表</li>
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
        <i class="glyphicon glyphicon-hand-right"></i>

        温馨提示：此页面展示资源列表，您可以对资源查看、编辑、删除、授权及批量删除和新建的操作。单击右方x号，可以关闭此条提示语！

        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    </div>
    <div class="tablewrap">
        <table class="table ">
            <thead>
            <tr>
                <th style="width:0.8rem">
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
                <th style="width:22%">
                    资源类型
                    <span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
                </th>
                <th style="width:22%">
                    资源名称
                    <span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
                </th>
                <th style="width:22%">
                    父级资源
                    <span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
                </th>
                <th style="width:1rem">查看</th>
                <th style="width:1rem">编辑</th>
                <th style="width:1rem">删除</th>
            </tr>
            </thead>
            <tbody id="resourceList">
            
            </tbody>
        </table>
        <div class="tfoot">
            <div class="btns">
				<span class="newPro" url="${pageContext.request.contextPath}/backend/authority/resource/add">
					<img src="${pageContext.request.contextPath}/img/sys/icons4.png" alt="">
					新建
				</span>
                <span>
					<img src="${pageContext.request.contextPath}/img/sys/icons1.png" alt="">
					刷新
				</span>
                <span  class="removeBtn">
					<img src="${pageContext.request.contextPath}/img/sys/icons2.png" alt="">
					删除
				</span>
            </div>
            <div class="pagination">
            
            </div>
        </div>
    </div>
</div>