
$(function(){
	//将编辑角色模态框加入到body中id为bodyModalArea的div中
	$('.right-container .modalToBody').appendTo('body #bodyModalArea');
})
/**
 * 编辑模态框
 * @returns
 */
//存放模态框需要调用的方法

/* 放大模态框样式  */
function setEditStyle(){
	$(".modal-backdrop").hide()
	$("#editRoleModal").appendTo($(".ajax_dom"))
	$("#editRoleModal").addClass("bigmodule")
	$(".breadcrumb").addClass("display_block")
	$(".modalCon .bg-grey#remark").addClass("active")
	$(".modalCon .roleNameBox").removeClass("width_active")
	$(".editRole_modal .role_hearder").addClass("display_block")
	$('#editRoleModal .maxNumView').addClass("width_block")
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
	$('#editRoleModal .maxNumView').removeClass("width_block")
	$(".editRole_modal .role_hearder").removeClass("display_block")
	$(".modalCon .modal-header").removeClass("display_none")
	$(".role_content_error_xian").removeClass("display_block")
	
}

/* 滑块 */
function limitChangeLength(elm, limitLength) {
	$(elm).attr("maxLength", limitLength);
	$(elm).keyup(function() {
		var length = $(elm).val().length;
		
		$(elm).siblings("span").html($(elm).attr("maxlength") - length);
	});
}
/* 放大样式 */
$(".edit_blue_border").on("click", function() {
	$(".modal-backdrop").show()
	$("#editRoleModal").modal('show')
	removeEditStyle()
	$('#editRoleModal').appendTo('body #bodyModalArea');
})


/*关闭处理 */
$('.edit_red_border').on("click", function(e) {
	e.preventDefault()
	$('#editRoleModal').appendTo('body #bodyModalArea');
	removeEditStyle()
	$("#editRoleModal").modal('hide')
})



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

/* 弹出编辑框 */
function showEditModal(data) {
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
	
	dealDataToModal(data); 
	
	$('#editRoleModal').modal('show');
}

/**
 * 查看模态框
 */
//放大
$(".view_external_link").on("click", function(e) {
	e.preventDefault()
	e.stopPropagation()
	$(this).closest('.modal').modal('hide')
	$(this).closest('.modal-contentbox').addClass('looklg')
	$(this).closest('.modal-contentbox').appendTo($(".ajax_dom"))
	$('.ajax_dom').show(0)
})
// 缩小
$(".view_blue_border").on("click", function() {
	$("#viewModal").empty()
	$(this).closest('.modal-contentbox').appendTo('#viewModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
    $(this).closest('.modal-contentbox').removeClass('looklg')
    $(this).closest('.modal').modal('show')
})
// 关闭按钮
$('.view_red_border').on('click',function(){
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

/* 弹出查看框 */
function viewRole(data) {
	console.log(data)
	//获取到本地的某条数据 示例代码
	$("#view_roleName").html(data.displayName);
	$("#view_roleMaxNum").html(data.roleMaxNum);
	$("#view_rolePName").html(data.rolePName);
	$("#view_roleRelyName").html(data.roleRelyName);
	$("#view_remarks").html(data.remarks);
	$('#viewModal').modal('show');
}
$("#viewModal").on("click","*:not('.pull-right *')",function(e){
	e.stopPropagation()
})
function viewUser(data) {
	$('#viewModal').modal('show');
}
$("#viewModal").on("click","*:not('.pull-right *')",function(e){
	e.stopPropagation()
})
/**
* 查看角色授权模态框
*/
function roleAuth(data) {
	$("#auth_role_name").val(data.displayName);
	$("#role-authorization").modal('show');
	// 大小切换按钮,1是模态框2是页面
	$('.modal .maxrole').on('click',function(){
		if($(this).closest('.modal-contentbox').prop('id')!=='role-authorizationlg'){
	        $(this).closest('.modal').modal('hide')
	        $(this).closest('.modal-contentbox').prop('id','role-authorizationlg');
	        $(this).closest('.modal').find('.hidmission p').attr('mintype','2')
	        $(this).closest('.modal-contentbox').appendTo('.ajax_dom');
	        $(".ajax_dom").show(0);
	        $(".role-slider").slider({value: 50,});
	        $('.inputwrappermax').css('width',50+50/2+'%')
		}else{
	        $(this).closest('.modal-contentbox').appendTo('#role-authorization .modal-content');
	        if(!$('.ajax_dom').html()){
				$('.ajax_dom').hide()
			}
	        $(this).closest('.modal-contentbox').prop('id','');
			$('.inputwrappermax').css('width','100%');
	        $(this).closest('.modal').modal('show')
	        $(this).closest('.modal').find('.hidmission p').attr('mintype','1')
		}
	})
}
//放大

