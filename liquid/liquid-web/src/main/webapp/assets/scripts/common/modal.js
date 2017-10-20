
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
		var numVal = parseInt($("#edit_roleMaxNum").val());
		if(numVal > 0) {
			numVal--;
			$("#edit_roleMaxNum").val(numVal);
		}
		var inputlimitNum = parseInt($(".numCtr input").val());
		judge(inputlimitNum);
	});
	$(add).click(function(e) {
		e.preventDefault();
		var numVal = parseInt($("#edit_roleMaxNum").val());
		if(numVal < 10) {
			numVal++;
			$("#edit_roleMaxNum").val(numVal);
		}
		var inputlimitNum = parseInt($(".numCtr input").val());
		judge(inputlimitNum);
	});
	
	dealDataToModal(data); 
	limitChangeLength($(".sliderInput input[type='text']"),12)
}
function editSource(data) {
	dealDataToModal(data);
}
//用户编辑框
function editUserModal(data) {
	$("#edit_userId").val(data.id);
	$("#edit_userName").val(data.userName);
	$("#edit_phone").val(data.phone);
	$("#edit_email").val(data.email);

}
/* 弹出查看框 */
function viewRole(data) {
	//获取到本地的某条数据 示例代码
	$("#view_roleName").html(data.displayName);
	$("#view_roleMaxNum").html(data.roleMaxNum);
	$("#view_rolePName").html(data.rolePName);
	$("#view_roleRelyName").html(data.roleRelyName);
	$("#view_remarks").html(data.remarks);

}

function viewUser(data) {
	$("#view_userName").html(data.userName);
	$("#view_roleName").html(data.roleName);
	$("#view_phone").html(data.phone);
	$("#view_email").html(data.email);

}

function viewSource(data) {
	$("#view_resourceName").html(data.resourceName);
	$("#view_resourceType").html(data.resourceType);
	$("#view_resourceURL").html(data.resourceURL);
	//$("#view_operationName").html(data.operationName);

}
/**
* 查看用户授权模态框
*/
function userAuth(data) {
	$("#auth_userName").val(data.userName);
 
}

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
//限制输入字符
function limitChangeLength(elm, limitLength) {
	$(elm).attr("maxLength", limitLength);
	$(elm).keydown(function() {
		var length = $(elm).val().length;
		$(elm).siblings(".wordNum").html(limitLength - length);
	});
}
