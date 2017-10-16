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
	
	createRoleList(data); 
	
	$('#editRoleModal').modal('show');
}