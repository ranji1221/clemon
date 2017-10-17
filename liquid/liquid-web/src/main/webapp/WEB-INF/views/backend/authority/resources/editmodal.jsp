<%@ page language="java" pageEncoding="UTF-8" %>
<div id="editModal" class="modalCon modal fade bs-example-modal-lg modalToBody" tabindex="-1" role="dialog">
	<div class="modal-contentbox" maxClassName="editsourcelg modalCon" narrowClassName="#editModal">
	<ol class="breadcrumb breadcrumb_margin">
		<li>
			<i class="glyphicon glyphicon-home"></i>
			<a href="#" data="2" url="home">首页</a>
		</li>
		<li>
			<a href="#" url="${pageContext.request.contextPath}/backend/authority/resources/list">资源管理</a>
		</li>
		<li class="active">编辑资源</li>
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
		<div class="modal-content" u_id="1">
			<div class="modal-header">
				<div class="pull-right">
					<a href="javascript:;" data-dismiss="modal" class="minus module_minimize">
						<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
						<div class="hidmission">
							<span class="icon-pencil icon-slidenav"></span>
							<p u_id="1" class="editSource" mintype='1'>编辑资源</p>
							<span class="iconfont icon-chuyidong1 del"></span>
						</div>
					</a>
					<a href="javascript:;" class="enlargeAction">
						<img src="${pageContext.request.contextPath}/img/sys/modal3.png" />
					</a>
					<a href="javascript:;" class="remove" data-dismiss="modal">
						<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
					</a>
				</div>
				<h4 class="modal-title">
								<span>|</span><b>编辑资源</b>
							</h4>
			</div>
			<div class="row resources_hearder">
			<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 resources_hearde_font">
				<span>编辑资源</span>
			</div>
			<div class="pull-right col-lg-2 col-md-2 col-sm-3 col-xs-4 role_hearde_icon">
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon closeAction">
	
					<img src="./assets/images/sys/modal1.png" alt="" />
					<!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
				</div>
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1  role_hearde_this_icon narrowAction">
					<!--<a href=""><span class="glyphicon glyphicon-resize-small blue_back"></span></a>-->
	
					<img src="./assets/images/sys/modal3.png" alt="" />
				</div>
				<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon res_green_border dom_minimize">
					<!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
					<img src="./assets/images/sys/modal2.png" alt="" />
					<div class="hidmission">
						<span class="icon-pencil icon-slidenav"></span>
						<p url="./pages/resources/edit" u_id="1"  mintype='2'>编辑资源</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>
				</div>
			</div>
		</div>
			
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group has-feedback">
						<div class="col-xs-12 roleNameError text-right row-xs-h">
							<!--不要输入特殊符号-->
						</div>
						<div class="col-sm-2 col-xs-3 row-lg-h">
							<label for="resourceName" class=" control-label"><span class="dot">·</span>资源名称：</label>
						</div>
						<div class="col-sm-10 col-xs-9 row-lg-h in_input_num">
							<input name="name" type="text" class="form-control bg-grey" id="edit_resourceName" maxlength="12" placeholder="请输入资源名称">
							<!--<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>-->
							<!--<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>-->
							<span class="wordNum">12</span>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class="col-sm-5 col-xs-6 row-xs-h parentRoleError text-right">
								<!--您还未选择资源类型-->
							</div>
							<div class="col-sm-5 col-xs-6 row-xs-h relyRoleError text-right">
								<!--你还未选择父级资源资源-->
							</div>
						</div>
						<div class="col-md-5 col-sm-12 col-xs-12  row-lg-h fath_select ">
							<div class="col-md-5 col-sm-2 col-xs-3 l-pd r-pd">
								<label for="sourceType" class="control-label">
	                <span class="dot">·</span>资源类型：
	            </label>
							</div>
	
							<div class="col-xs-4 col-md-6 row-lg-h">
								<select name="yilai" data-toggle="select" class="form-control select_roleList" id="edit_resourceType">
								</select>
							</div>
						</div>
						<div class="col-md-5 col-sm-12 col-xs-12 row-lg-h fath_select ">
							<div class="col-md-5 col-sm-2 col-xs-3  l-pd col-md-offset-1 r-pd">
								<label for="parentRole" class="control-label">
	                <span class="dot">·</span>父级资源：
	            </label>
							</div>
							<div class="col-xs-4 col-md-6 row-lg-h">
								<select name="fath" data-toggle="select" class=" form-control select_resourceList" id="edit_resourcePName">
								</select>
							</div>
						</div>
	
					</div>
					<div class="form-group">
						<div class="col-xs-12 roleNameError text-right row-xs-h">
							<!--不要输入特殊符号-->
						</div>
						<div class="col-sm-2 col-xs-3 row-lg-h">
							<label class="control-label">
	                <span class="dot">·</span>相关操作:
	            </label>
						</div>
						<div class="col-sm-10 col-xs-9 row-lg-h">
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
</div>
<script>
	$('[data-toggle="select"]').select2();
	$(".relateCtl [type='checkbox']").iCheck({
		checkboxClass: 'icheckbox_flat-blue',
		increaseArea: '20%' // optional
	});
	
	$(".in_input_num span").html(12-$(".in_input_num input").val().length)
	$(".in_input_num input").on("keyup",function(){
		var val = $(this).val().length
		$(".in_input_num span").html(12-val)
	})
</script>