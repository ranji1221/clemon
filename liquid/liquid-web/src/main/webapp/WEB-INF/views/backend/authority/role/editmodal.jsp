<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script  src="${pageContext.request.contextPath}/js/validate/validate.js "></script>
<script type="text/javascript">
	function dealDataToModal(data){
		//获取到本地的某条数据 示例代码
		$("#edit_roleId").val(data.id);
		$("#edit_displayName").val(data.displayName);
		$("#edit_roleMaxNum").val(data.roleMaxNum);
		$("#edit_remarks").val(data.remarks);
		$('.select_roleList').LemonGetList({
			requestListUrl:'${pageContext.request.contextPath}/backend/authority/role/listAll',
			beforeFun:function(data){
				return getListByTree(data);
			},
			generateItemFun:function(index,value){
				var itemHtml = '';
				if(index == 0 ){ itemHtml += '<option value="0" '+'>选择角色</option>';}
				
				var kongge_str = '';
				for(var i=0;i<value.level;i++){
					kongge_str += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
				}
				kongge_str += '|-';
				
				itemHtml += '<option  value="'+value.id+'" ';
				itemHtml += ' >'+kongge_str+value.roleName+'</option>';
				return itemHtml;
			},
			afterFun:function(){
				
				//.roleExtendPId
				if(data.roleExtendPId >= 1){
					$('#edit_roleExtendPId option').each(function(val){
						if($(this).attr('value') == data.roleExtendPId){
							$(this).attr('selected','selected');
						}
					})
				}
				
				if(data.roleRelyId >= 1){
					$('#edit_roleRelyId option').each(function(val){
						if($(this).attr('value') == data.roleRelyId){
							$(this).attr('selected','selected');
						}
					})
				}
			}
		})
	}
	function beforeMaxEditModal(){
		var minlimitNum = 5;
		$(".minlimitNum").html(minlimitNum);
		$(".error_box").slider({
			orientation: "horizontal",
			range: "min",
			max: 70,
			value: 70,
			slide: function(event, ui) {
				var ui_value = ui.value
				$(".sliderInput").css("width", ui_value+"%");
				$(".minlimitNum").html(minlimitNum + parseInt(ui_value / 10));
				$(".sliderInput").find("input.form_input").val($(".sliderInput").find("input.form_input").val().slice(0, minlimitNum + parseInt(ui_value / 10)))
				$(".sliderInput").find("input.form_input").prop("maxlength", minlimitNum + parseInt(ui_value / 10))
				limitChangeLength($(".form_input input"), parseInt($(".minlimitNum").html()));
			}
		})
				
	$(".sliderInput").css("width", $(".error_box").slider("value")+"%");
	$(".minlimitNum").html(minlimitNum + parseInt($(".error_box").slider("value") / 10))	
	
		$('.breadcrumb').on("click", function(e) {
			var el = e.target || window.event
			e.preventDefault()
			var url = $(el).attr("url")
			var ajax_dom = $(".ajax_dom")
			if($(el).attr('data')) {
				
			} else {
				if(url){
					$.ajax({
						url: url + ".html",
						dataType: "html"
					}).done(function(data) {
						ajax_dom.empty()
						ajax_dom.html(data)
					})
				}
			}
		});
	}
	$(document).on("click","#submit_editRole",function(){
		$.post("${pageContext.request.contextPath}/backend/authority/role/edit",
			{
				id:$("#edit_roleId").val(),
				displayName:$("#edit_displayName").val(),
				roleMaxNum:$("#edit_roleMaxNum").val(),
				remarks:$("#edit_remarks").val(),
				roleExtendPId:$("#edit_roleExtendPId option:selected").val(),
				roleRelyId:$("#edit_roleRelyId option:selected").val()
			},function(data){
				if(data.success){
					removeStorage();
					roleListInit();
					alert("成功啦");
				}
				else{
					alert("失败啦")
				}
			}
		,"json")
	}) 
</script>

<div id="editModal" class="modalCon modal fade bs-example-modal-lg editRole_modal  modalToBody" tabindex="-1" role="dialog">
	<div class="maxcontainer editpage modal-contentbox" narrowClassName="#editModal">
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">角色管理</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">角色列表</a>
	    </li>
	    <li class="active">编辑角色</li>
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
		<p>编辑角色</p>
		<div class="btns">
			<!-- <a href="javascript:;" class="min dom_minimize">
				<img src="./assets/images/sys/modal2.png" alt="">
				<div class="hidmission">
					<span class="icon-key icon-slidenav"></span>
					<p url='./pages/role/role-authorizationlg'>编辑角色</p>
					<span class="iconfont icon-chuyidong1 del"></span>
				</div>
			</a>
			<a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4">
				<img src="./assets/images/sys/modal3.png" alt="">
			</a> -->
			<a href="javascript:;" class="zclose closeAction" data-dismiss="modal">
				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
			</a>
		</div>
	</div>
	<div class="form_content">
		<form class="form-role-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >角色名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax form_input sliderInput">
		    			<input type="hidden" name="roleId" id="edit_roleId">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入角色名称" id="edit_displayName">
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-role-edit-name">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group select">
		    	<label for="" >父级角色：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
						<select name="fath" data-toggle="select" class="form-control select select-primary select-block mbl" id="edit_roleExtendPId">
						</select>
				    	<span class="errormessage errormessage-role-edit-fath">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group select">
		    	<label for="" >依赖角色：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
						<select name="yilai" data-toggle="select" class="form-control select select-primary select-block mbl" id="edit_roleRelyId">
						</select>
				    	<span class="errormessage errormessage-role-edit-yilai">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group number">
		    	<label for="" >最大限制用户数：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax row-lg-h numCtr">
				    	<a class="reduce active">
							-
						</a>
						<div class="input">
							<input type="text" id="edit_roleMaxNum" readonly value='0'  name="max_num">
						</div>
						<a class="add">
							+
						</a>
				    	<span class="errormessage errormessage-role-edit-num">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group textarea">
		    	<label for="" >备注：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<textarea name="beizhu" id="edit_remarks" placeholder="请输入备注"></textarea>
				    	<span class="errormessage errormessage-role-edit-num">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		 <!--<div class="form-group tree">
		    	<label for="" >角色授权：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<header>
							<label for="checkallRoleaut">
								<input  type="checkbox" name="checkallaut" class="checkallRoleaut">
								选中全部
							</label>
							<label for='slidedownallRoleaut'>
								<input  type="checkbox" name="slidedownallaut" class="slidedownallRoleaut">
								展开全部
							</label>
							<label class="prompt visible-md visible-lg">
								温馨小提示：此
								<input  type="checkbox" name="disabled" checked disabled>
								为您的上级权限您无权更改
							</label>
						</header>
						<div class="treezl">
							<div class="role-authorization">
							
							</div>
						</div>
			    	
				    	<label class="prompt visible-sm visible-xs">
							温馨小提示：此
							<input  type="checkbox" name="disabled" checked disabled>
							为您的上级权限您无权更改
						</label>
			  	
				    	<span class="errormessage errormessage-role-edit-aut">
			    		
			    		</span>
		    		</div>
		    	</div>
		  	</div>    -->
		  	<div class="btnbox">
				<button type="button" class="btn btn-default submitbtn-role-edit" disabled>确定</button>
				<button type="button" class="btn btn-default">取消</button>
		  	</div>
		</form>
	</div>
	
</div>
</div>