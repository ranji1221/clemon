<%@ page language="java" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script src="${pageContext.request.contextPath}/js/common/LemonGetList.js"></script>
<script>
(function($) {
	$(function() {
		if($(".input input").text() == 10) {

			$(".add").removeClass("active")
			$(".reduce").addClass("active")
		} else if($(".input input").text() == 0) {
			$(".add").addClass("active")
			$(".reduce").removeClass("active")

		} else {
			$(".add").addClass("active")
			$(".reduce").addClass("active")

		}
		//拖拽问题
		$(".sliderInput").css("width", "0");
		var minlimitNum = 5;
		$(".minlimitNum").html(minlimitNum);
//		var docu_w = parseInt($(".sliderInput").css("width"));
		$(".error_box").slider({
			orientation: "horizontal",
			range: "min",
			max: 72,
			value: 72,
			slide: function(event, ui) {
				var ui_value = ui.value
				$(".sliderInput").css("width",  ui_value+"%");
				$(".minlimitNum").html(minlimitNum + parseInt(ui_value / 10));
				$(".sliderInput").find("input").val($(".sliderInput").find("input").val().slice(0, minlimitNum + parseInt(ui_value / 10)))
				$(".sliderInput").find("input").prop("maxlength", minlimitNum + parseInt(ui_value / 10))
				limitChangeLength($(".form_input input"), parseInt($(".minlimitNum").html()));
			}
		})
		$(".sliderInput").css("width", $(".error_box").slider("value")+"%");
		$(".minlimitNum").html(minlimitNum + parseInt($(".error_box").slider("value") / 10))
		$('[data-toggle="select"]').select2();

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
			var numVal = $(".input input").val();
			if(numVal == 1) {
				$(".add").addClass("active")
				$(".reduce").removeClass("active")
			}
			if(numVal > 0) {
				//					alert(1)
				$(".add").addClass("active")
				numVal--;
				$(".input input").val(numVal);
			}
		});
		$(".add").click(function(e) {
			e.preventDefault();
			var numVal = $(".input input").val();
			if(numVal < 10) {
				numVal++;
				$(".add").addClass("active")
				$(".reduce").addClass("active")
				$(".input input").val(numVal);
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
			$('[data-toggle="select"]').select2();
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
				})
				alert("成功啦");
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
<div class="container-fluid">

	<!--编辑角色最大化开始-->
	<div class="row role_hearder link_xian">
		<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 role_hearde_font">
			<span>添加角色</span>
		</div>
		<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">

		</div>
	</div>
	<div class="row role_content form_content" u_id="2" n_id="-1">
		<form action="" id="jjjj">
			<div class="row role_form ">
				<div class="form-horizontal col-lg-12 col-md-9 col-sm-9 col-xs-12">
					<div class="form-group ">
						<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
							<span></span>
						</div>
						<label class="col-lg-2 col-md-3 col-sm-3 col-xs-3 control-label">角色名称：</label>
						<div class="col-lg-8 col-md-7 col-sm-6 col-xs-6 form_input  col-md-offset-0 col-sm-offset-1 role_name sliderInput">
							<input type="text" maxlength="15" class="form-control " placeholder="请输入角色名称" id="add_displayName">
							<span class="minlimitNum">15</span>
						</div>
					</div>
				</div>
				<div class="error_font col-lg-3 col-md-3 col-sm-3 col-xs-3">
					<!--visible-->
					<span class="error_icon icon-exclamation-sign"></span>
					<span>您输入了特殊符号！</span>
				</div>
			</div>
			<div class="row role_content_error_xian display_block">
				<div class="error_xian col-lg-8 col-md-8 col-sm-8 col-xs-8 ">
					<div class="col-lg-3 col-md-3 col-xs-4"></div>
					<div class="error_box col-lg-5 col-md-7 col-sm-6 col-xs-6"></div>
				</div>
			</div>
			<ul class="row role_fath">
				<li class="col-lg-7 col-md-12 col-sm-12 col-xs-12 fath_select">
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
						<span></span>
					</div>
					<label class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label fath_select_font">父级角色：</label>
					<div class="col-lg-3 col-md-2 col-sm-2 col-xs-2 form_input">
						<select class="form-control select select-primary select-block mbl" name="fath" data-toggle="select" id="add_roleExtendPId">
						</select>
					</div>
					<div class="error_font col-lg-4 col-md-4 col-sm-4 col-xs-4">
						<!--visible-->
						<span class="error_icon icon-exclamation-sign"></span>
						<span>您还未选择依赖角色</span>
					</div>
				</li>
				<li class="col-lg-5 col-md-12 col-sm-12 col-xs-12 fath_select">
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
						<span></span>
					</div>
					<label class="col-lg-4 col-md-3 col-sm-3 col-xs-3 control-label fath_select_font">依赖角色：</label>
					<div class="col-lg-4 col-md-2 col-sm-2 col-xs-2 form_input">
						<select class="form-control select select-primary select-block mbl" name="yilai" data-toggle="select" id="add_roleRelyId">
						</select>
					</div>
				</li>
			</ul>
			<div class="row role_max_number">
				<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<label class="col-lg-2 col-md-3 col-sm-3 col-xs-3 control-label">最大限制用户数 ：</label>
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4 max_number_add">
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 reduce active">
						<a href=""><span>-</span></a>
					</div>
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 input">
						<input type="text" readonly value="0" name="max_num" id="add_roleMaxNum">
					</div>
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 add">
						<a href=""><span>+</span></a>
					</div>
				</div>
			</div>
			<div class="row role_remarks">
				<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<label class="col-lg-2 col-md-2 col-sm-3 col-xs-3 control-label">备注 ：</label>
				<div class="col-lg-9 col-md-9 col-sm-9 col-xs-9 role_write">
					<textarea id="" placeholder="请输入备注" name="beizhu" id="add_remarks"></textarea>
				</div>
			</div>
			<div class="row role_button">
				<div class=" col-md-6 col-lg-6 col-sm-6 col-xs-6 role_succse">
					<button type="button" class="btn btn-default" id="submit_addRole">确认</button>
				</div>
				<div class=" col-md-4 col-lg-4 col-sm-4 col-xs-6 role_remove">
					<button type="button" class="btn btn-default">取消</button>
				</div>
			</div>
	</div>
	</form>
	<!--编辑角色最大化结束-->
</div>
</div>
