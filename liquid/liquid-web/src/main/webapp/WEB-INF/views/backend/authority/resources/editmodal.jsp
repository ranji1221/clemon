﻿<%@ page language="java" pageEncoding="UTF-8" %>
<script  src="${pageContext.request.contextPath}/js/validate/validate.js "></script>
<script>
function beforeMaxEditResourceModal(){
	$(".relateCtl [type='checkbox']").iCheck({
		checkboxClass: 'icheckbox_flat-blue',
		increaseArea: '20%' // optional
	});
	
	$(".in_input_num .limitlength").html(12-$(".in_input_num input").val().length)
	$(".in_input_num input").on("keyup",function(){
		var val = $(this).val().length
		$(".in_input_num .limitlength").html(12-val)
	})
}
beforeMaxEditResourceModal()

function dealDataToModal(data){
	$("#edit_resourceId").val(data.id)
	$("#edit_resourceName").val(data.resourceName)
	$("#edit_resourceType").val(data.resourceType)
	$('.select_resourceList').LemonGetList({
		requestListUrl:'${pageContext.request.contextPath}/backend/authority/resource/listAll',
		beforeFun:function(data){
			console.log(data)
			return getListByTree(data);
		},
		generateItemFun:function(index,value){
			console.log(value)
			var itemHtml = '';
			if(index == 0 ){ itemHtml += '<option value="0" '+'>选择资源</option>';}
			
			var kongge_str = '';
			for(var i=0;i<value.level;i++){
				kongge_str += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			}
			kongge_str += '|-';
			
			itemHtml += '<option  value="'+value.id+'" ';
			itemHtml += ' >'+kongge_str+value.resourceName+'</option>';
			return itemHtml;
		},
		afterFun:function(){
			if(data.resourcePId >= 1){
				$('.select_resourceList option').each(function(val){
					if($(this).attr('value') == data.resourcePId){
						$(this).attr('selected','selected');
					}
				})
			}
		},
		emptyDataFun : function(){
			return '<option value="0" '+'>没有数据</option>';
		}
	})
}
$(document).on("click","#submit_editResource",function(){
	var tem_str = '';
	$("#edit_operation input:checked").each(function(){
		if(!tem_str) {
			tem_str += $(this).val();
		}else{
			tem_str +=',' + $(this).val();
		}
	})
	$.post("${pageContext.request.contextPath}/backend/authority/resource/edit",
		{
			id:$("#edit_resourceId").val(),
			resourceName:$("#edit_resourceName").val(),
			resourceType:$("#edit_resourceType option:selected").val(),
			resourcePId:$("#edit_resourcePId option:selected").val(),
			operation:tem_str
		},function(data){
			if(data.success){
				removeStorage();
				resourceListInit();
				alert("成功啦");
			}
			else{
				alert("失败啦")
			}
		}
	,"json")
}) 
</script>
<div id="editModal" class="modalCon modal fade bs-example-modal-lg modalToBody editSour_modal" tabindex="-1" role="dialog">
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
						<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
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
		<p>编辑资源</p>
		<div class="btns"> 
			<a href="javascript:;" class="zclose edit_external_link" data-dismiss="modal">
				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
			</a>
		</div>
	</div>
	<div class="form_content">
		<form class="form-source-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >资源名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax in_input_num">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入资源名称" maxlength="12" name='username'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-source-edit-name">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group select">
		    	<label for="" >资源类型：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="fath">

							<option value="0" disabled="disabled">请选择资源类型</option>
							<option value="1">菜单</option>
							<option value="2">元素</option>
							<option value="3">文件</option>
							<option value="4">操作</option>

						</select>
				    	<span class="errormessage errormessage-role-edit-fath">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	 	<div class="form-group select">
		    	<label for="" >父级资源：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="fath">

							<option value="0" disabled="disabled">选择资源</option>
							<option value="1"></option>
							<option value="2"></option>
							<option value="3"></option>
							<option value="4"></option>

						</select>
				    	<span class="errormessage errormessage-role-edit-fath">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group phone">
		    	<label for="" >相关操作：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<div class="col-xs-3 relateCtl">
							<input name="look" id="sourcecheck" type="checkbox" checked>
							<label for="sourcecheck">查看</label>
						</div>
						<div class="col-xs-3 relateCtl">
							<input name="change" id="sourceChange" type="checkbox">
							<label for="sourceChange">更改</label>
						</div>
						<div class="col-xs-3 relateCtl">
							<input name="add" id="sourceAdd" type="checkbox">
							<label for="sourceAdd">增加</label>
						</div>
						<div class="col-xs-3 relateCtl">
							<input name="del" id="sourceDel" type="checkbox">
							<label for="sourceDel">删除</label>
						</div>
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
