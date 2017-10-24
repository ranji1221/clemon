<%@ page language="java" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonGetList.js"></script>
<script>
(function($) {
	$(function() {
		if($(".input_num input").text() == 10) {

			$(".add").removeClass("active")
			$(".reduce").addClass("active")
		} else if($(".input_num input").text() == 0) {
			$(".reduce").removeClass("active")
			$(".add").addClass("active")

		} else {
			$(".add").addClass("active")
			$(".reduce").addClass("active")

		}
		

		function limitChangeLength(elm, limitLength) {
			$(elm).attr("maxLength", limitLength);
			$(elm).keyup(function() {
				var length = $(elm).val().length;
				$(elm).siblings("span").html(limitLength - length);
			});
		}
		limitChangeLength($(".form_input input"), parseInt($(".minlimitNum").html()))
		//加减数字
		
		$(".reduce").click(function(e) {

			e.preventDefault();
			var numVal = $(".input_num input").val();
			if(numVal == 1) {
				$(".add").addClass("active")
				$(".reduce").removeClass("active")
			}
			if(numVal > 0) {
				//					alert(1)
				$(".add").addClass("active")
				numVal--;
				$(".input_num input").val(numVal);
			}
		});
		$(".add").click(function(e) {
			e.preventDefault();
			var numVal = $(".input_num input").val();
			if(numVal < 10) {
				numVal++;
				$(".add").addClass("active")
				$(".reduce").addClass("active")
				$(".input_num input").val(numVal);
			}
			if(numVal == 10) {
				$(".reduce").addClass("active")
				$(".add").removeClass("active")
			}
		});
	})
})(jQuery)

function createRoleList(){
	$('.form-control').LemonGetList({
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
			/* 下拉框样式 */
		}
	})
}
createRoleList();

$(document).on("click","#submit_addRole",function(){
	$.post("${pageContext.request.contextPath}/backend/authority/role/save",
		{
		displayName:$("#add_displayName").val(),
		roleMaxNum:$("#add_roleMaxNum").val(),
		remarks:$("#add_remarks").val(),
		roleExtendPId:$("#add_roleExtendPId option:selected").val(),
		roleRelyId:$("#add_roleRelyId option:selected").val()
		},function(data){
			if(data.success){
				removeStorage();
				$(".ajax_dom").empty()
				$.ajax({
					url:"${pageContext.request.contextPath}/backend/authority/role/list"
				}).done(function(data){
					$(data).appendTo($(".ajax_dom"))
					$('.alertArea').showAlert({content:'添加成功'});
				})
			
			}
			else{
				alert("失败啦")
			}
		}
	,"json")
}) 
</script>
<!--<link rel="stylesheet" href="assets/styles/role/role.css">-->
<div class="modal-contentbox">
<ol class="breadcrumb breadcrumb_margin">
	<li>
		<i class="glyphicon glyphicon-home"></i>
		<a href="#" data="2" url="home">首页</a>
	</li>
	<li>
		<a href="#" url="${pageContext.request.contextPath}/backend/authority/role/list">角色管理</a>
	</li>
	<li class="active">添加角色</li>
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
<div class="maxcontainer editpage modal-contentbox" >
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
	    <li class="active">添加角色</li>
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
	
	<div class="title">
		<p>添加角色</p>
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
			</a> 
			<a href="javascript:;" class="zclose edit_red_border" data-dismiss="modal">
				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
			</a>-->
		</div>
	</div>
	<div class="form_content">
		<form class="form-role-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >角色名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax form_input sliderInput">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入角色名称" name='username'>
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
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="fath">

							<option value="0" disabled="disabled">选择父级角色</option>
							<option value="1">角色列表</option>
							<option value="2">首页</option>
							<option value="3">角色列表</option>
							<option value="4">角色列表</option>

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
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="yilai">

							<option value="0" disabled="disabled">选择依赖角色</option>
							<option value="1">角色列表</option>
							<option value="2">首页</option>
							<option value="3">角色列表</option>
							<option value="4">角色列表</option>

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
				    	<a class=" reduce ">
							-
						</a>
						<div class="input_num input">
							<input type="text" id="edit_roleMaxNum" readonly value='0'  name="max_num">
						</div>
						<a class="add active">
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
				    	<textarea name="beizhu" id="" placeholder="请输入备注"></textarea>
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
