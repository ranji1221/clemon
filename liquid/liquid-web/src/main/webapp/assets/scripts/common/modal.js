
$(function(){
	//将编辑角色模态框加入到body中id为bodyModalArea的div中
	$('.right-container .modalToBody').appendTo('body #bodyModalArea');
})
/**
 * 编辑模态框
 * @returns
 */

//滑块 
function limitChangeLength(elm, limitLength) {
	$(elm).attr("maxLength", limitLength);
	$(elm).siblings("span").html($(elm).attr("maxlength") - $(elm).val().length);
	$(elm).keyup(function() {
		var length = $(elm).val().length;
		
		$(elm).siblings("span").html($(elm).attr("maxlength") - length);
	});
}
//放大样式
$(document).on("click",".edit_blue_border", function() {
	$(".roleNameBox").addClass("width_active")
<<<<<<< HEAD
	$("#remark").addClass("active")
	$('#editRoleModal .maxNumView').removeClass("width_block")
	$(".select-l-pd").removeClass('active')
=======
>>>>>>> branch 'master' of https://github.com/ranji1221/clemon.git
	$(this).closest('.modal-contentbox').appendTo('#editModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
    $(this).closest('.modal-contentbox').removeClass('editrolelg modalCon')
    $(this).closest('.modal').modal('show')
})


//关闭处理 
$(document).on("click",'.edit_red_border', function(e) {
	$(this).closest('.modal-contentbox').remove();
	$(this).closest('.modal-contentbox').appendTo('#editModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
//最小化隐藏
	$('#editModal .dom_minimize').on('click',function(){
		$(this).closest(".modal-contentbox").prependTo($(".minbox"));
		if(!$('.ajax_dom').html()){
			$('.ajax_dom').hide()
		}
    })
    $('#editModal .module_minimize').on('click',function(){
		$(this).closest('.modal').modal('hide');
		$(this).closest(".modal-contentbox").prependTo($(".minbox"));
    })

	$("#editModal").on("shown.bs.modal", function() {
		var max_role = $(this).find(".edit_external_link")
		max_role.on("click", function(e) {
			e.preventDefault()
			e.stopPropagation()
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
		
		$(this).closest('.modal').modal('hide')
			$(this).closest('.modal-contentbox').addClass('editrolelg modalCon')
				$(".roleNameBox").removeClass("width_active")
				$("#remark").removeClass("active")
				$(".select-l-pd").addClass('active')
				$('#editRoleModal .maxNumView').addClass("width_block")
			$(this).closest('.modal-contentbox').appendTo($(".ajax_dom"))
			$('.ajax_dom').show(0)
			
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
	
	});
});

//弹出编辑框 
function showEditModal(data) {
	limitChangeLength($(".sliderInput input[type='text']"),12)
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
	$("[name='remarks']").val(data.remarks);
	
	dealDataToModal(data); 
<<<<<<< HEAD
	$('#editModal').modal('show');
	limitChangeLength($(".sliderInput input[type='text']"),12)
=======
	console.log("111")
	
	$('#editModal').modal('show');
>>>>>>> branch 'master' of https://github.com/ranji1221/clemon.git
}

/**
 * 查看模态框
 */
//放大
$(document).on("click",".view_external_link",function(e) {
	e.preventDefault()
	e.stopPropagation()
	$(this).closest('.modal').modal('hide')
	$(this).closest('.modal-contentbox').addClass('looklg')
	$(this).closest('.modal-contentbox').appendTo($(".ajax_dom"))
	$('.ajax_dom').show(0)
})
// 缩小
$(document).on("click",".view_blue_border", function() {
	$("#viewModal").empty()
	$(this).closest('.modal-contentbox').appendTo('#viewModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
    $(this).closest('.modal-contentbox').removeClass('looklg')
    $(this).closest('.modal').modal('show')
})
// 关闭按钮
$(document).on('click','.view_red_border',function(){
	$(this).closest('.modal-contentbox').remove();
	$(this).closest('.modal-contentbox').appendTo('#viewModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
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

function viewUser(data) {
	console.log(data)
	$("#view_userName").html(data.userName);
	$("#view_roleName").html(data.roleName);
	$("#view_phone").html(data.phone);
	$("#view_email").html(data.email);
	$('#viewModal').modal('show');
}

/**
 * 授权模态框
 */
function roleAuth(data) {
	$("#auth_role_name").val(data.displayName);
	$("#role-authorization").modal('show');
}
/**
* 查看用户授权模态框
*/
function userAuth(data) {
	$("#auth_userName").val(data.userName);
	$("#user-authorization").modal('show');    
}
//放大
$(document).on('click','.auth_external_link',function(e){
	e.preventDefault()
	e.stopPropagation()
	$(this).closest('.modal').modal('hide')
	$(this).closest('.modal-contentbox').prop('id','user-authorizationlg');
	$(this).closest('.modal-contentbox').appendTo('.ajax_dom');
	$(".ajax_dom").show(0);
})
// 关闭按钮
$('.modal .zclose').on('click',function(){
	$(this).closest('.modal-contentbox').remove();
	$(this).closest('.modal-contentbox').appendTo('#user-authorization');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
/**
 * 最小化模态框
 */
//模态框最小化按钮
$(document).on("click", ".module_minimize", function() {
	getdom_module($(this))
	$(this).closest('.modal').modal('hide');
	$(this).closest(".modal-contentbox").prependTo($(".minbox"));
})
//最小化按钮本地存储
$(document).on("click", ".dom_minimize", function() {
	getdom_module($(this))
	$(this).closest(".modal-contentbox").prependTo($(".minbox"));
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
function getdom_module(this_dom) {
	//$(".ajax_dom").empty().hide()
	var dom_modul = this_dom.find(".hidmission").html()
	var url = this_dom.find(".hidmission p").attr("class")
	$("<li class="+url+">" + dom_modul + "</li>").prependTo($(".mission ol"))

}
$(".mission ol").on("click", "li", function(e) {
	var minindex = $(this).index('.mission ol li')
	$(this).detach()
	var minboxitem = $('.minbox').find('.modal-contentbox').eq(minindex) //点击的li对应的隐藏盒子
	var mintype = $(this).find("p").attr("mintype") //mintype,1是模态框2是可放大页面,3纯页面
	var modaltype = $(this).find("p").prop("class") //modaltype,确定调用哪个模态框
	console.log(minboxitem,mintype,modaltype)
	if(mintype == '3') {
		minboxitem.appendTo($(".ajax_dom"))
		$(".ajax_dom").show(0);
	} else if(mintype == '2') {
		minboxitem.appendTo($(".ajax_dom"))
		$(".ajax_dom").show(0);
	} else {
		switch(modaltype) {
		case "role-aut":
			$('#role-authorization .modal-content').html('');
			minboxitem.appendTo($('#role-authorization .modal-content'))
			$('#role-authorization').modal('show');
			break;
		case "user-aut":
			$('#user-authorization .modal-content').html('');
			minboxitem.appendTo($('#user-authorization .modal-content'))
			$('#user-authorization').modal('show');
			break;
		case "editUser":
			$('#editModal').html('');
			minboxitem.appendTo($('#editModal'))
			$('#editModal').modal('show');
			break;
		case "editRole":
			$('#editModal').html('');
			minboxitem.appendTo($('#editModal'))
			$('#editModal').modal('show');
			break;
		case "editSource":
			$('#editModal').html('');
			minboxitem.appendTo($('#editModal'))
			$('#editModal').modal('show');
			break;
		case "lookUser":
			$('#viewModal').html('');
			minboxitem.appendTo($('#viewModal'))
			$('#viewrModal').modal('show');
			break;
		case "lookRole":
			$('#viewModal').html('');
			minboxitem.appendTo($('#viewModal'))
			$('#viewModal').modal('show');
			break;
		case "lookSource":
			$('#viewModal').html('');
			minboxitem.appendTo($('#viewModal'))
			$('#viewModal').modal('show');
			break;
		case "lookLog":
			$('#lookLogModal').html('');
			minboxitem.appendTo($('#lookLogModal'))
			$('#lookLogModal').modal('show');
			break;

		}
	}
})
$(document).on("click", function() {
	$(".mission").hide()
})
