<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${pageContext.request.contextPath}/js/common/common.js"></script>

<script type="text/javascript">
$(function(){
	//将编辑角色模态框加入到body中id为bodyModalArea的div中
	$('#editRoleModal').appendTo('body #bodyModalArea');
})
	/* 放大模态框样式  */
	function setEditStyle(){
		$(".modal-backdrop").hide()
		$("#editRoleModal").appendTo($(".ajax_dom"))
		$("#editRoleModal").addClass("bigmodule")
		$(".breadcrumb").addClass("display_block")
		$(".modalCon .bg-grey#remark").addClass("active")
		$(".modalCon .roleNameBox").removeClass("width_active")
		$(".editRole_modal .role_hearder").addClass("display_block")
		$(".modalCon .modal-header").addClass("display_none")
		$(".role_content_error_xian").addClass("display_block")
	}
	/* 删除模态框样式 */
	function removeEditStyle(){
		$(".modalCon .bg-grey#remark").removeClass("active")
		$("#editRoleModal").removeClass("bigmodule")
		$(".breadcrumb").removeClass("display_block")
		$(".modalCon .bg-grey#remark").removeClass("active")
		$(".modalCon .roleNameBox").addClass("width_active")
		$(".editRole_modal .role_hearder").removeClass("display_block")
		$(".modalCon .modal-header").removeClass("display_none")
		$(".role_content_error_xian").removeClass("display_block")
		
	}
	/* 弹出编辑框 */
	function editRole(data) {
		//获取到本地的某条数据 示例代码
		$("[name='roleName']").val(data.displayName);
		$("[name='roleMaxNum']").val(data.roleMaxNum);
		var maxNum = data.roleMaxNum;
		var maxLimitNum = 10;
		//加减按钮
		var limitNum;
		if(parseInt(maxNum) == 0) {
			limitNum = 0;
		} else if(parseInt(maxNum)) {
			limitNum = parseInt(maxNum);
		} else {
			limitNum = parseInt($("#limitNum").val()) || 0;
		}
		function judge(limitNum) {
			if(maxLimitNum <= limitNum) {
				$(add).css("background", grey);
				$(sub).css("background", blue);
			} else if(limitNum < 1) {
				$(sub).css("background", grey);
				$(add).css("background", blue);
			} else {
				$(add).css("background", blue);
				$(sub).css("background", blue);
			}
		}
		var add = $(".numCtr .icon-plus");
		var sub = $(".numCtr .icon-minus");
		var grey = '#bdc3c7';
		var blue = '#378ef8';
		$(sub).click(function(e) {
			e.preventDefault();
			var numVal = parseInt($("#limitNum").val());
			if(numVal > 0) {
				numVal--;
				$("#limitNum").val(numVal);
			}
			var inputlimitNum = parseInt($(".numCtr input").val());
			judge(inputlimitNum);
		});
		$(add).click(function(e) {
			e.preventDefault();
			var numVal = parseInt($("#limitNum").val());
			if(numVal < 10) {
				numVal++;
				$("#limitNum").val(numVal);
			}
			var inputlimitNum = parseInt($(".numCtr input").val());
			judge(inputlimitNum);
		});
		console.log(data)
		$("[name='remarks']").val(data.remarks);
		
		createRoleList(data.roleExtendPId);
		
		$('#editRoleModal').modal('show');
	}
	function createRoleList(thisRoleExtendPId){
		console.log(thisRoleExtendPId);
		$('#sourceType').LemonGetList({
			requestListUrl:'${pageContext.request.contextPath}/backend/authority/role/listAll',
			generateItemFun:function(index,value){
				var kongge_str = '';
				for(var i=0;i<value.level;i++){
					kongge_str += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
				}
				kongge_str += '|-';
				
				var itemHtml = '';
				var ex_str = '';
				if(thisRoleExtendPId == -1) ex_str = ' selected ';
				if(index == 0 ){ itemHtml += '<option value="0" '+ex_str+'>选择父级角色</option>';}
				itemHtml += '<option  name="'+value.id+'" ';
				if(value.id == thisRoleExtendPId) itemHtml += ' selected ';
				itemHtml += ' >'+kongge_str+value.roleName+'</option>';
				return itemHtml;
			},
			getListDataByResponseDataFun:function(data){
				data = getListByData(data)
				return data;
			}
		})
	}
	$("#editRoleModal").on("click","*:not('.pull-right *')",function(e){
		e.stopPropagation()
	})
	$("#editRoleModal").on("shown.bs.modal", function() {
		var max_role = $(this).find(".edit_external_link")
		max_role.on("click", function(e) {
			e.preventDefault()
			e.stopPropagation()
			setEditStyle()
			var minlimitNum = 5;
	$(".minlimitNum").html(minlimitNum);
	$(".error_box").slider({
		orientation: "horizontal",
		range: "min",
		max: 60,
		value: 60,
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
					window.location.reload()
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
			$(document).on("click.all_click",".left-menu li",function(e){
				e.stopPropagation()
				var url = $(this).attr("url")
				if(url){
					$(".ajax_dom").empty()	
				}else{
					
				}
				
				$(document).off("click.all_click","**")
			});
		});
	});
	/* 下拉框样式 */
	$('[data-toggle="select"]').select2();
	$(".edit_blue_border").on("click", function() {
		$(".modal-backdrop").show()
		//$("#editRoleModal").modal('show')
		removeEditStyle()
		$('#editRoleModal').appendTo('body #bodyModalArea');
	})
	/* 滑块 */
	function limitChangeLength(elm, limitLength) {
		$(elm).attr("maxLength", limitLength);
		$(elm).keyup(function() {
			var length = $(elm).val().length;
			
			$(elm).siblings("span").html($(elm).attr("maxlength") - length);
		});
	}

	/*关闭处理 */
	$('.edit_red_border').on("click", function(e) {
		e.preventDefault()
		$('#editRoleModal').appendTo('body #bodyModalArea');
		removeEditStyle()
		$("#editRoleModal").modal('hide')
	})
</script>
<div id="editRoleModal" class="modalCon modal fade bs-example-modal-lg editRole_modal" tabindex="-1" role="dialog">
	<!-- 放大后的导航 -->
	<ol class="breadcrumb breadcrumb_margin">
		<li>
			<i class="glyphicon glyphicon-home"></i>
			<a href="#" data="2" url="home">首页</a>
		</li>
		<li>
			<a href="#" url="./pages/role/rolelist">角色管理</a>
		</li>
		<li>
			<a href="" url="./pages/role/rolelist">角色列表</a>
		</li>
		<li class="active">角色编辑</li>
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
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" u_id="2">
		<!--  放大后的头部-->
		<div class="row role_hearder">
				<div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 role_hearde_font">
					<span>角色编辑</span>
				</div>
				<div class="pull-right col-lg-2 col-md-3 col-sm-4 col-xs-4 role_hearde_icon">
					<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1 role_hearde_this_icon edit_red_border" data-dismiss="modal">
	
						<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
						<!--<a href=""><span class="glyphicon glyphicon-remove red_back"></span></a>-->
					</div>
					<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-offset-1  role_hearde_this_icon  edit_blue_border">
						<!--<a href=""><span class="glyphicon glyphicon-resize-small blue_back"></span></a>-->
	
						<img src="${pageContext.request.contextPath}/img/sys/modal3.png" alt="" />
					</div>
					<div class="pull-right col-lg-1 col-md-1 col-sm-1 col-xs-1 role_hearde_this_icon green_border dom_minimize">
						<!--<a href=""><span class="small_icon glyphicon green_back">-</span></a>-->
						<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
						<!--<div class="hidmission">
						<span class="icon-pencil icon-slidenav"></span>
						<p url="./pages/role/edit" u_id="2">角色编辑</p>
						<span class="iconfont icon-chuyidong1 del"></span>
					</div>-->
					</div>
				</div>
			</div>
		
			<div class="modal-header">
				<div class="pull-right">
					<a href="javascript:;" data-dismiss="modal" class="minus module_minimize">
						<img src="${pageContext.request.contextPath}/img/sys/modal2.png" alt="" />
						<div class="hidmission">
							<span class="icon-pencil icon-slidenav"></span>
							<p u_id="2" class="editRole">编辑角色</p>
							<span class="iconfont icon-chuyidong1 del"></span>
						</div>
	
					</a>
					<a href="javascript:;" class="edit_external_link">
						<img src="${pageContext.request.contextPath}/img/sys/modal3.png" />
					</a>
					<a href="javascript:;" class="remove" data-dismiss="modal">
						<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="" />
					</a>
				</div>
				<h4 class="modal-title">
					<span>|</span><b>编辑角色</b>
				</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal flatUi" id="editRole" action="${pageContext.request.contextPath}/backend/authority/role/edit" method="post">
					<div class="form-group has-feedback">
						<div class="col-xs-12 roleNameError text-right row-xs-h">
							<!--不要输入特殊符号-->
						</div>
						<div class="col-xs-3 col-sm-2 row-lg-h">
							<label for="roleName" class=" control-label"><span class="dot">·</span>角色名称：</label>
						</div>
						<div class="col-xs-9 col-sm-10 row-lg-h roleNameBox sliderInput">
							<input type="hidden" name="id" id="roleId">
							<input type="text" class="form-control bg-grey2  form_input" name="roleName" id="roleName" placeholder="请输入角色名称">
							<span class="minlimitNum">15</span>
							<!--<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>-->
							<!--<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="false"></span>-->
						</div>
					</div>
					<!--滑块-->
					<div class="row role_content_error_xian">
					<div class="error_xian col-lg-8 col-md-8 col-sm-8 col-xs-8 ">
						<div class="col-lg-2 col-md-3 col-xs-4"></div>
						<div class="error_box col-lg-5 col-md-7 col-sm-6 col-xs-6"></div>
					</div>
				</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class="col-sm-5 col-xs-6 row-xs-h parentRoleError text-right">
								<!--您还未选择父级角色-->
							</div>
							<div class="col-sm-5 col-xs-6 row-xs-h relyRoleError text-right">
								<!--你还未选择依赖角色-->
							</div>
						</div>
						<div class="col-md-5 col-sm-12 col-xs-12  row-lg-h fath_select">
							<div class="col-md-5 col-sm-2 col-xs-3 l-pd r-pd">
								<label for="sourceType" class="control-label">
	                <span class="dot">·</span>父级角色：
	            </label>
							</div>
	
							<div class="col-xs-4 col-md-6 row-lg-h select-l-pd">
								<select name="fath" data-toggle="select" class=" form-control" id="sourceType">
								</select>
							</div>
						</div>
						<div class="col-md-5 col-sm-12 col-xs-12 row-lg-h fath_select">
							<div class="col-md-5 col-sm-2 col-xs-3  l-pd col-md-offset-1 r-pd">
								<label for="parentRole" class="control-label">
	                <span class="dot">·</span>依赖角色：
	            </label>
							</div>
							<div class="col-xs-4 col-md-6 row-lg-h select-l-pd">
								<select name="yilai" data-toggle="select" class="form-control" id="parentRole">
									<option value="0" disabled="disabled">选择依赖角色</option>
									<c:forEach items="${roleList}" var = "roleList">
										<option value="${roleList.id }" name="roleRelyId" <c:if test="${roleList.id == role.roleRelyId}">selected</c:if>>${roleList.roleName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
	
					</div>
					<div class="form-group">
						<div class="col-sm-3 col-xs-4 row-lg-h maxNumView">
							<label class="control-label" for="limitNum">
	                <span class="dot">·</span>最大限制用户数
	            </label>
						</div>
						<div class="col-xs-2 row-lg-h numCtr">
							<a href="" class=" icon-minus text-center reduce"></a>
							<input readonly class="form-control" id="limitNum" name="roleMaxNum" type="text"/>
							<a href="" class="icon-plus text-center add active"></a>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-3 col-sm-2 remarkBox">
							<label class="control-label" for="remark">
	                <span class="dot">·</span>备注：</label>
						</div>
						<div class="col-xs-9 col-sm-10 textarea-h">
							<textarea name="remarks" class="form-control bg-grey" id="remark" cols="30" rows="5" placeholder="请输入备注"></textarea>
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
