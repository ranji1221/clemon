
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
//关闭处理 
$(document).on("click",'.edit_red_border', function(e) {
	$(this).closest('.modal-contentbox').remove();
	$(this).closest('.modal-contentbox').appendTo('#editModal');
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
//最小化隐藏
	

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
//				$(".roleNameBox").removeClass("width_active")
//				$("#remark").removeClass("active")
//				$('.maxNumView').addClass("width_block")
			$(".editrolelg").addClass("active")
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

//角色编辑框 
function editRoleModal(data) {

	limitChangeLength($(".sliderInput input[type='text']"),12)
	var maxNum = data.roleMaxNum;
	var maxLimitNum = 10;
	var add = $(".numCtr .icon-plus");
	var sub = $(".numCtr .icon-minus");
	var grey = '#bdc3c7';
	var blue = '#378ef8';
	judge(maxNum)
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
	
	$(sub).off("click")
	$(add).off("click")
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
	
	dealDataToModal(data); 
	limitChangeLength($(".sliderInput input[type='text']"),12)
	$('#editModal').modal('show');
}
function editSource(data) {
	console.log(data)
	$("#edit_resourceName").val(data.resourceName);
	$("#edit_resourceType").html(data.resourceType);
	//$("#edit_resourcePName").html(data.resourcePName);
	//$("#view_operationName").html(data.operationName);
	$("#editModal").modal('show');
}
//用户编辑框
function editUserModal(data) {
	$("#edit_userName").val(data.userName);
	$("#edit_phone").val(data.phone);
	$("#edit_email").val(data.email);
	$("#editModal").modal('show');
	
}
/* 弹出查看框 */
function viewRole(data) {
	//获取到本地的某条数据 示例代码
	$("#view_roleName").html(data.displayName);
	$("#view_roleMaxNum").html(data.roleMaxNum);
	$("#view_rolePName").html(data.rolePName);
	$("#view_roleRelyName").html(data.roleRelyName);
	$("#view_remarks").html(data.remarks);
	$('#viewModal').modal('show');
}

function viewUser(data) {
	$("#view_userName").html(data.userName);
	$("#view_roleName").html(data.roleName);
	$("#view_phone").html(data.phone);
	$("#view_email").html(data.email);
	$('#viewModal').modal('show');
}

function viewSource(data) {
	$("#view_resourceName").html(data.resourceName);
	$("#view_resourceType").html(data.resourceType);
	$("#view_resourceURL").html(data.resourceURL);
	//$("#view_operationName").html(data.operationName);
	$("#viewModal").modal('show');
}
function roleAuth(data) {
	$("#auth_roleName").val(data.roleName);
	$("#role-authorization").modal('show');
}
/**
* 查看用户授权模态框
*/
function userAuth(data) {
	$("#auth_userName").val(data.userName);
	$("#user-authorization").modal('show');    
}

//模态框最小化按钮
$('.module_minimize').on("click", function() {
	getdom_module($(this))
	$(this).closest('.modal').modal('hide');
	$(this).closest(".modal-contentbox").prependTo($(".minbox"));
})
//最小化按钮本地存储
$(".dom_minimize").on("click", function() {
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
//放大
$(document).on('click','.enlargeAction',function(e){
	e.preventDefault()
	e.stopPropagation()
	//字符串转成方法
	methodName = $(this).closest('.modal-contentbox').attr('beforeMaxFunName'); 
	if(methodName){
		var Fun = eval(methodName);
		Fun();
	}
	$(this).closest('.modal').modal('hide')
	var class_name = $(this).closest('.modal-contentbox').attr('maxClassName')
	if(!class_name) {
		console.log('最近的 div.modal-contentbox 的 maxClassName属性 没有 值')
	}else{
		$(this).closest('.modal-contentbox').addClass(class_name);
		$(this).closest('.modal-contentbox').appendTo('.ajax_dom');
		$(".ajax_dom").show(0);
		
	}
})
//缩小
$(document).on('click','.narrowAction',function(){
	var class_name = $(this).closest('.modal-contentbox').attr('narrowClassName')
	var maxClassName = $(this).closest('.modal-contentbox').attr('maxClassName')
	$(this).closest('.modal-contentbox').appendTo(class_name);
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
	$(this).closest('.modal-contentbox').removeClass(maxClassName)
    $(this).closest('.modal').modal('show')
})
//关闭
$(document).on("click",'.closeAction', function(e) {
	$(this).closest('.modal-contentbox').remove();
	var class_name = $(this).closest('.modal-contentbox').attr('narrowClassName')
	$(this).closest('.modal-contentbox').appendTo(class_name);
	var maxClassName = $(this).closest('.modal-contentbox').attr('maxClassName')
	if(maxClassName){
		$(this).closest('.modal-contentbox').removeClass(maxClassName)
	}
	if(!$('.ajax_dom').html()){
		$('.ajax_dom').hide()
	}
})
