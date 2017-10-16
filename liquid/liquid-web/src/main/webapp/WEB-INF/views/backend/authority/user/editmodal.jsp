<%@ page language="java" pageEncoding="UTF-8" %>
<div class="modal-contentbox">
<ol class="breadcrumb breadcrumb_margin">
	<li>
		<i class="glyphicon glyphicon-home"></i>
		<a href="#" data="2">首页</a>
	</li>
	<li>
		<a href="#" url="./pages/user/list">用户管理</a>
	</li>
	<li>
		<a href="" url="./pages/user/list">用户列表</a>
	</li>
	<li class="active">编辑用户</li>
	<div class="nav-search" id="nav-search">
		<form class="form-search">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="搜索你想找到的...">
				<span class="input-group-btn">
			        <button class="btn btn-default" type="button">
						<img src="./assets/images/sys/iconsearch.png" alt="">
			        </button>
			        </span>
			</div>
			<!-- /input-group -->
		</form>
	</div>
</ol>
<div class="modal-dialog modal-lg" role="document">
	<div class="modal-content" u_id="3" >
	<div class="row user_hearder">
			<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 user_hearde_font">
				<span>编辑用户</span>
			</div>
			<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon red_border">

					<img src="./assets/images/sys/modal1.png" alt="" />
					<!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
				</div>
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1  role_hearde_this_icon  blue_border">
					<!--<a href=""><span class="glyphicon glyphicon-resize-small blue_back"></span></a>-->

					<img src="./assets/images/sys/modal3.png" alt="" />
				</div>
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon green_border dom_minimize">
					<!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
					<div class="hidmission">
						<span class="icon-pencil icon-slidenav"></span>
						<p url="./pages/user/edit" u_id="3" mintype='2'>编辑用户</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>
					<img src="./assets/images/sys/modal2.png" alt="" />
				</div>
			</div>
		</div>
		
		<div class="modal-header">
			<div class="pull-right">
				<a href="javascript:;" data-dismiss="modal" class="minus module_minimize">
					<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
					<div class="hidmission">
						<span class="icon-pencil icon-slidenav"></span>
						<p u_id="3" class="editUser"  mintype='1' >编辑用户</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>
				</a>
				<a href="javascript:;" class="external-link">
					<img src="${pageContext.request.contextPath}/img/sys/modal3.png" />
				</a>
				<a href="javascript:;" class="remove" data-dismiss="modal">
					<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
				</a>
			</div>
			<h4 class="modal-title">
							<span>|</span><b>编辑用户</b>
						</h4>
		</div>
		<div class="modal-body">
			<form class="form-horizontal">
				<div class="form-group">
					<div class="col-xs-12 roleNameError text-right row-xs-h">
						<!--不要输入特殊符号-->
					</div>
					<div class="col-sm-2 col-xs-3 row-lg-h">
						<label for="userName" class=" control-label"><span class="dot">·</span>用户名：</label>
					</div>
					<div class="col-sm-10 col-xs-9 row-lg-h name_input">
						<input name="name" type="text" class="form-control bg-grey" id="userName" placeholder="请输入用户名">
						<span class="wordNum">15</span>
					</div>
				</div>
				<div class="form-group fath_select">
					<div class="col-xs-12">
						<div class="col-xs-6 col-sm-5 row-xs-h parentRoleError text-right"> </div>
					</div>
					<div class="col-sm-2 col-xs-3 row-lg-h">
						<label for="parentRole" class="control-label">
                <span class="dot">·</span>分配用户：
            </label>
					</div>
					<div class="col-xs-3 row-lg-h">
						<select  name="fath" data-toggle="select" class="form-control select mrs mbm" id="parentRole">
							<option value="0" disabled="disabled">选择分配用户</option>
							<option value="1">用户列表</option>
							<option value="2">首页</option>
							<option value="3">用户列表</option>
							<option value="4">用户列表</option>
							<option value="4">用户列表</option>
							<option value="4">用户列表</option>
						</select>
					</div>
					<div class="col-xs-6 row-lg-h allotRoleError">
						<!--您还未选择分配用户-->
					</div>
				</div>
				<div class="form-group has-feedback">
					<div class="col-xs-12 roleNameError text-right row-xs-h">
						<!--请输入正确的电话号码-->
					</div>
					<div class="col-sm-2 col-xs-3 row-lg-h">
						<label for="userTel" class=" control-label"><span class="dot">·</span>联系电话：</label>
					</div>
					<div class="col-sm-10 col-xs-9 row-lg-h">
						<input name="tel" type="text" class="form-control bg-grey" id="userTel" placeholder="请输入用户联系方式">
						<!--<span class="glyphicon glyphicon-ok form-control-feedback"></span>-->
						<!--<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>-->
					</div>
				</div>
				<div class="form-group has-feedback">
					<div class="col-xs-12 roleNameError text-right row-xs-h">
						<!--请输入正确的邮箱地址-->
					</div>
					<div class="col-sm-2 col-xs-3 row-lg-h">
						<label for="userName" class=" control-label"><span class="dot">·</span>邮箱：</label>
					</div>
					<div class="col-sm-10 col-xs-9 row-lg-h">
						<input name="emily" type="text" class="form-control bg-grey" id="userEmail" placeholder="请输入用户邮箱">
						<!--<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>-->
						<!--<span class="glyphicon glyphicon-exclamation-sign form-control-feedback" aria-hidden="false"></span>-->
					</div>
				</div>
				<div class="form-group">
					<div class="role_button">
						<div class="col-xs-6 role_succse">
							<button type="submit" class="btn btn-default editSourceSubmit">确定</button>
						</div>
						<div class="col-xs-6 role_remove">
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
</div>
<script>
	$('[data-toggle="select"]').select2();
	//字数控制
	$(".form_input .role").trigger("keyup")
	function limitChangeLength(elm, limitLength) {
		var length = $(elm).text().length
		$(elm).siblings("span").html(limitLength - length);
		$(elm).attr("maxLength", limitLength);
		$(elm).keyup(function() {
			var length = $(elm).val().length;
			$(elm).siblings("span").html(limitLength - length);
		});
	}
	limitChangeLength($("input.role"), 15)
	limitChangeLength($("input.phone"), 15)
	limitChangeLength($("input.emlia"), 15)
	// 放大
		$(".external-link").on("click", function(e) {
			e.preventDefault()
			e.stopPropagation()
			$(this).closest('.modal').modal('hide')
			$(this).closest('.modal-contentbox').addClass('edituserlg')
			$(this).closest('.modal-contentbox').appendTo($(".ajax_dom"))
			$('.ajax_dom').show(0)
		})
	// 缩小
	$(".blue_border").on("click", function() {
		$(this).closest('.modal-contentbox').appendTo('#editUserModal');
		if(!$('.ajax_dom').html()){
			$('.ajax_dom').hide()
		}
        $(this).closest('.modal-contentbox').removeClass('edituserlg')
        $(this).closest('.modal').modal('show')
	})
	// 关闭按钮
    $('.red_border').on('click',function(){
		$(this).closest('.modal-contentbox').remove();
		if(!$('.ajax_dom').html()){
			$('.ajax_dom').hide()
		}
    })
	// 最小化隐藏
	$('.dom_minimize').on('click',function(){
		$(this).closest(".modal-contentbox").prependTo($(".minbox"));
		if(!$('.ajax_dom').html()){
			$('.ajax_dom').hide()
		}
    })
    $('.module_minimize').on('click',function(){
		$(this).closest('.modal').modal('hide');
		$(this).closest(".modal-contentbox").prependTo($(".minbox"));
    })
</script>