﻿<%@ page language="java" pageEncoding="UTF-8" %>

<script>
	$("[type='checkbox']").iCheck({
		checkboxClass: 'icheckbox_flat-blue',
		increaseArea: '20%' // optional
	});
	$(".sliderInput").css("width","0");
	var minlimitNum=5;
	$(".minlimitNum").html(minlimitNum);
//	var docu_w = parseInt($(".sliderInput").css("width"));
	$(".error_box").slider({
		orientation: "horizontal",
		range: "min",
		value: 70,
		max:70,
		slide: function(event, ui) {
	var ui_value = ui.value
			$(".sliderInput").css("width",ui_value+"%");
			$(".minlimitNum").html(minlimitNum+parseInt(ui_value/10)-);
			$(".sliderInput").find("input").val($(".sliderInput").find("input").val().slice(0,minlimitNum+parseInt(ui_value/10)))
			$(".sliderInput").find("input").prop("maxlength",minlimitNum+parseInt(ui_value/10))
			limitChangeLength($(".form_input input"),minlimitNum+parseInt(ui_value/10) );
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
	limitChangeLength($(".form_input .resources_name"),parseInt($(".minlimitNum").html()))
	
	$(document).on("click","#submit_addResource",function(){
	$.post("${pageContext.request.contextPath}/backend/authority/resource/save",
		{
			resourcesName:$("#add_resourcesName").val(),
			resourceType:$("#add_resourceType option:selected").val(),
			resourcePId:$("#add_resourcePId option:selected").val()
		},function(data){
			if(data.success){
				removeStorage();
				$(".ajax_dom").empty()
				$.ajax({
					url:"${pageContext.request.contextPath}/backend/authority/resource/list"
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
<div class="modal-contentbox">
<ol class="breadcrumb breadcrumb_margin">
	<li>
		<i class="glyphicon glyphicon-home"></i>
		<a href="#" data="2" url="home">首页</a>
	</li>
	<li>
		<a href="#" url="${pageContext.request.contextPath}/backend/authority/resource/list">资源管理</a>
	</li>
	<li class="active">添加资源</li>
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
	<!--编辑资源最大化开始-->
	<div class="row resources_hearder">
		<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 resources_hearde_font">
			<span>添加资源</span>
		</div>
		<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">
			<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon red_border">

				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
				<!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
			</div>

			<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon green_border dom_minimize">
				<!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
				<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
				<div class="hidmission">
					<span class="icon-pencil icon-slidenav"></span>
					<p url="${pageContext.request.contextPath}/backend/authority/resource/add">添加资源</p>
					<span class="iconfont icon-chuyidong1 del"></span>
				</div>
			</div>
		</div>
	</div>
	<div class="row resources_content form_content" u_id="1" n_id="-1">
		<form action="">
		<div class="row resources_form">
			<div action="" class="form-horizontal col-lg-8 col-md-8 col-sm-9 col-xs-12">
				<div class="form-group">
					<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
						<span></span>
					</div>
					<label class="col-lg-2 col-md-3 col-sm-3 col-xs-3 control-label">资源名称：</label>
					<div class="col-lg-8 col-md-7 col-sm-6 col-xs-6 form_input col-lg-offset-1 col-md-offset-1 col-sm-offset-0  res_name sliderInput">
						<input type="text" name="name" maxlength="15" class="form-control resources_name" placeholder="请输入资源名称" id="add_resourcesName">
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
		<ul class="row resources_fath">
			<li class="col-lg-7 col-md-12 col-sm-12 col-xs-12 fath_select">
				<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<label class="col-lg-3 col-md-3 col-sm-3 col-xs-3 control-label fath_select_font">资源类型：</label>
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 form_input">
					<select class="form-control select select-primary select-block mbl" name="yilai" data-toggle="select" id="add_resourceType">
						<option value="0" disabled="disabled">选择资源类型</option>
						<option value="1">资源列表</option>
						<option value="2">首页</option>
						<option value="3">资源列表</option>
						<option value="4">资源列表</option>
					</select>
				</div>
				<div class="error_font col-lg-4 col-md-3 col-sm-4 col-xs-4">
					<!--visible-->
					<span class="error_icon icon-exclamation-sign"></span>
					<span>您还未选择依赖资源</span>
				</div>
			</li>
			<li class="col-lg-5 col-md-12 col-xs-12 fath_select">
				<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<label class="col-lg-4 col-md-3 col-sm-3 col-xs-3 control-label fath_select_font">父级资源：</label>
				<div class="col-lg-4 col-md-3 col-sm-3  col-xs-3 form_input">
					<select class="form-control select select-primary select-block mbl" name="fath" data-toggle="select" id="add_resourcePId">

						<option value="0" disabled="disabled">选择父级资源</option>
						<option value="1">资源列表</option>
						<option value="2">首页</option>
						<option value="3">资源列表</option>
						<option value="4">资源列表</option>

					</select>
				</div>
				<div class="error_font col-lg-4 col-md-4 col-sm-4 col-xs-4">
					<!--visible-->
					<span class="error_icon icon-exclamation-sign"></span>
					<span>您还未选择依赖资源</span>
				</div>
			</li>
		</ul>
		<div class="row resources_remarks">
			<div class="col-lg-1 col-md-1 col-sm-1 col-xs-1 form_clire  text-center">
				<span></span>
			</div>
			<label class="col-lg-2 col-md-2 col-sm-3 col-xs-3 control-label">相关操作 ：</label>
			<div class="col-lg-8 col-md-8 col-sm-8 col-xs-7 resources_write">
				<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 res_checked">
					<label>
                    <input tabindex="2" name="look" type="checkbox"  checked>
                    <p>查看</p>
                    </label>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3  res_checked">
					<label>
                    <input tabindex="2" name="add" type="checkbox"  >
                    <p>增加</p>
                    </label>
				</div>
				<div class="col-lg-2 col-md-2  col-sm-3 col-xs-3 res_checked">
					<label>
                    <input tabindex="2" name="change" type="checkbox"  >
                    <p>更改</p>
                    </label>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 res_checked">
					<label>
                    <input tabindex="2" name="del" type="checkbox" id="input-2" >
                    <p>删除</p>
                    </label>
				</div>
			</div>
		</div>
		<div class="row role_button">
			<div class=" col-sm-6 col-md-4 col-md-6 col-lg-6 col-xs-6 role_succse">
				<button type="button" class="btn btn-default" id="submit_addResource">确认</button>
			</div>
			<div class=" col-sm-4 col-md-4 col-lg-4 col-xs-4 role_remove">
				<button type="button" class="btn btn-default">取消</button>
			</div>
		</div>
	</div>
	</form>
	<!--编辑资源最大化结束-->
</div>
</div>