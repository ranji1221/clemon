<%@ page language="java" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/common/common.js"></script>
<script type="text/javascript">
$("#btn").click(function(){
	$.post("${pageContext.request.contextPath}/backend/database/backup/backup",{
		infoName:$("#infoName").val(),
		remark:$("#remark").val(),
	},function(data){
		if(data.success){
			removeStorage();
			$(".ajax_dom").empty()
			/* $.ajax({
				url:"${pageContext.request.contextPath}/backend/database/backup/backupJump"
			}).done(function(data){
				$(data).appendTo($(".ajax_dom"))
				$('.alertArea').showAlert({content:'备份成功'});
			}) */
			alert("备份成功")
		
		}
		else{
			alert("失败啦")
		}
	},'json'); 
})	
</script>
<div class="modal-contentbox">

<ol class="breadcrumb breadcrumb_margin">
	<li>
		<i class="glyphicon glyphicon-home"></i>
		<a href="#" data="2" url="home">首页</a>
	</li>
	<li>
		<a href="#">数据库管理</a>
	</li>
	<li class="active">备份数据库</li>
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
<div class="container-fluid backupEasy">
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i>

		温馨提示：备份数据库不在本地，请重新寻找中

		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>

	<!--编辑角色最大化开始-->
	<div class="row role_hearder database_hearder">
		<div class="col-xs-5 role_hearde_font">
			<span>备份数据库</span>
		</div>
		<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">
			<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon red_border">
            	
            	<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
                <!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
            </div>
		</div>
	</div>
	<div class="row role_content form_content" u_id="5" n_id="-1">
		<form action="" > 
			<div class="row role_form ">
				<div class="form-horizontal col-xs-12">
					<div class="form-group ">
						<div class="col-xs-1 form_clire  text-center">
							<span></span>
						</div>
						<label class="col-md-2 col-sm-3 col-xs-3 control-label">备份文件名：</label>
						<div class="col-xs-8 col-md-7 form_input">
							<input type="text" id="infoName" name="name" class="form-control " placeholder="请输入文件名..." style="padding: 0;">
						</div>
						<div class="col-md-1 col-xs-12 proinfo">
						</div>
					</div>
				</div>
			</div>
			<div class="row role_remarks">
				<div class="col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<label class="col-lg-2 col-md-2 col-sm-3 col-xs-3 control-label">备注 ：</label>
				<div class="col-xs-8 col-md-7 role_write">
					<textarea  id="remark" placeholder="请输备注..." name="beizhu"></textarea>
				</div>
				<div class="col-md-2 col-xs-12 proinfo">
				</div>
			</div>
			<div class="row role_remarks role_button">
				<div class="col-xs-1 form_clire  text-center">
					<span></span>
				</div>
				<div class="col-xs-11 col-md-9 role_succse">
					<button id = "btn" type="button" name="beizhu" class="btn btn-default startBackup">开始备份</button>
				</div>
			</div>
		</form>
	</div>
	<!--编辑角色最大化结束-->
</div>

</div>
<script>
	$(function() {
		$('[data-toggle="select"]').select2();
		// 关闭按钮
	    $('.backupEasy .red_border').on('click',function(){
			$(this).closest('.modal-contentbox').remove();
			if(!$('.ajax_dom').html()){
				$('.ajax_dom').hide()
			}
	    })
	})
</script>