/**
 * Created by gu on 2017/9/15.
 */

$(function() {
	var editModal = $("#editModal");
	var editRoleUrl = "backend/authority/role/edit/modal";
	var editUserUrl = "backend/authority/user/edit/modal";
	var editSourceUrl = "backend/authority/resource/edit/modal";
	var lookRoleUrl = "backend/authority/role/view/modal";
	var lookUserUrl = "backend/authority/user/view/modal";
	var lookSourceUrl = "backend/authority/resource/view/modal";
	const maxLimitNum = 10;

	function editRole(this_nid,id) {
		$.ajax({
			url: editRoleUrl + "/" + id,
			async: true,
			success: function(data) {
				$("#editRoleModal").html(data);

				var input = $("#roleName");
				limitChangeLength(input, 12);
				$(".modal-content").attr("n_id", $(this_nid).attr("n_id"))
				$(".modal-content .editRole").attr("n_id", $(this_nid).attr("n_id"));
				var nId = $(".modal-content .editRole").attr("n_id");

				var uStr, maxNum;
				uStr = localStorage.getItem("this_role" + nId);
//				console.log("uStr:" + uStr);
				if(uStr) {

					maxNum = JSON.parse(uStr)[3].value;
				}

				//					console.log("第一个"+maxNum+"maxNum");
				//					console.log(maxNum==null);
				//					console.log(maxNum==0);
				//					console.log(maxNum==undefined);
				//加减按钮
				var limitNum;
				if(parseInt(maxNum) == 0) {
					limitNum = 0;
				} else if(parseInt(maxNum)) {
					limitNum = parseInt(maxNum);
				} else {
					limitNum = parseInt($("#limitNum").val()) || 0;
				}
//				console.log("第二个" + limitNum);

				function judge(limitNum) {

					if(maxLimitNum <= limitNum) {
						//                  	console.log("条件1："+maxLimitNum+"maxLimitNum;"+limitNum+"limitNum");
						$(add).css("background", grey);
						$(sub).css("background", blue);
					} else if(limitNum < 1) {
						//                  	console.log("条件2："+maxLimitNum+"maxLimitNum;"+limitNum+"limitNum");
						$(sub).css("background", grey);
						$(add).css("background", blue);
					} else {
						//                  	console.log("条件3："+maxLimitNum+"maxLimitNum;"+limitNum+"limitNum");
						$(add).css("background", blue);
						$(sub).css("background", blue);
					}
				}
				var add = $(".numCtr .icon-plus");
				var sub = $(".numCtr .icon-minus");
				var grey = '#bdc3c7';
				var blue = '#378ef8';
				//                  $("#limitNum").ready(function(){
				////                  	console.log($("#limitNum").val());
				//                  $("#limitNum").val(limitNum);
				//                  })

				//                  judge(limitNum);
				$(sub).click(function(e) {
					e.preventDefault();
					var numVal = parseInt($("#limitNum").val());
					if(numVal > 0) {
						numVal--;
						$("#limitNum").val(numVal);
					}
					var inputlimitNum = parseInt($(".numCtr input").val());
					judge(inputlimitNum);
					
					localStorage.removeItem("this_role" + nId);
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
					localStorage.removeItem("this_role" + nId);
				});
			},
			error: function(data) {
				console.log(data);
			}
		});
	
	}
	$(document).on("click", ".editRole", function(e) {
		e.preventDefault();
		var id = $(this).closest("tr").attr("role_id")
		$('#editRoleModal').modal('show');
		editRole($(this),id);

	});
	$("#editRoleModal").on("click","*:not('.pull-right *')",function(e){
		e.stopPropagation()
	})
	$("#editRoleModal").on("shown.bs.modal", function() {
		
		var max_role = $(this).find(".external-link")
		max_role.on("click", function(e) {
			console.log(111)
			e.preventDefault()
			e.stopPropagation()
			$(".modal-backdrop").hide()
			$("#editRoleModal").appendTo($(".ajax_dom"))
			$("#editRoleModal").addClass("bigmodule")
			$(".breadcrumb").addClass("display_block")
			$(".editRole_modal .role_hearder").addClass("display_block")
			$(".modalCon .modal-header").addClass("display_none")
			$(".role_content_error_xian").addClass("display_block")
			$(document).on("click.all_click","*:not('#editRoleModal')",function(){
				$("#editRoleModal").insertBefore($("body div:first"))
				$("#editRoleModal").removeClass("bigmodule")
				$(".breadcrumb").removeClass("display_block")
				$(".editRole_modal .role_hearder").removeClass("display_block")
				$(".modalCon .modal-header").removeClass("display_none")
				$(".role_content_error_xian").removeClass("display_block")
//				$(".modal-backdrop").show()
				$("#editRoleModal").modal('hide')
				$(document).off("click.all_click","**")
				
				
	})
		})
	});

	function editUser(this_nid) {

		$.ajax({
			url: editUserUrl,
			dataType: "html",
			async: true,
			success: function(data) {

				$("#editUserModal").html(data);
				$('#editUserModal').modal('show');
				var input = $("#userName");
				limitChangeLength(input, 15);
				$(".modal-content").attr("n_id", $(this_nid).attr("n_id"));
				$(".modal-content .editUser").attr("n_id", $(this_nid).attr("n_id"));
			},
			error: function(data) {
				console.log(data);
			}
		});
	}
	$(document).on("click", ".editUser", function(e) {
		e.preventDefault();
		
		editUser($(this));
	});

	function editSource(this_nid) {
		$.ajax({
			dataType: "html",
			url: editSourceUrl,
			async: true,
			success: function(data) {

				$("#editSourceModal").html(data);
				$(".modal-content").attr("n_id", $(this_nid).attr("n_id"))
				$('#editSourceModal').modal('show');
				$(".modal-content .editSource").attr("n_id", $(this_nid).attr("n_id"))
			},
			error: function(data) {
				console.log(data);
			}
		});
	}
	$(document).on("click", ".editSource", function(e) {
		e.preventDefault();
		
		editSource($(this));
	});

	function lookRoleModal(id) {
		$.ajax({
			dataType: "html",
			url: lookRoleUrl+'/'+ id,
			async: true,
			success: function(data) {
				$("#lookRoleModal").html(data);
				$('#lookRoleModal').modal('show');
			},
			error: function(data) {
				console.log(data);
			}
		});
	}

	$(document).on("click", ".lookRole", function(e) {
		e.preventDefault();
		 var id = $(this).closest("tr").attr("role_id")
		lookRoleModal(id);
	});

	function lookUserModal() {
		$.ajax({
			dataType: "html",
			url: lookUserUrl,
			async: true,
			success: function(data) {
				$("#lookUserModal").html(data);
				$('#lookUserModal').modal('show');
			},
			error: function(data) {
				if(data.status==404){
					//alert("you no auth!");
				}
				
				console.log(data);
			}
		});
	}

	$(document).on("click", ".lookUser", function(e) {
		e.preventDefault();
		
		lookUserModal();
	});

	function lookSourceModal() {
		$.ajax({
			dataType: "html",
			url: lookSourceUrl,
			async: true,
			success: function(data) {

				$("#lookSourceModal").html(data);
				$('#lookSourceModal').modal('show');
			},
			error: function(data) {
				console.log(data);
			}
		});
	}

	$(document).on("click", ".lookSource", function(e) {
		e.preventDefault();
		
		lookSourceModal();
	});
	// 用户授权模态框的调用
	$(document).on('click', '.user-aut', function() {
		$.ajaxSetup({
			cache: false
		});
		$('#user-authorization .modal-content').html('');
		$('#user-authorization .modal-content').load('backend/authority/user/auth/modal')
		$('#user-authorization').modal('show');
	})
	// 角色授权模态框的调用
	$(document).on('click', '.role-aut', function() {
		$.ajaxSetup({
			cache: false
		});
		$('#role-authorization .modal-content').html('');
		$('#role-authorization .modal-content').load('backend/authority/role/auth/modal')
		$('#role-authorization').modal('show');
	})
});
//限制输入字符
function limitChangeLength(elm, limitLength) {
	$(elm).attr("maxLength", limitLength);
	$(elm).keydown(function() {
		var length = $(elm).val().length;
		$(elm).siblings(".wordNum").html(limitLength - length);
	});
}