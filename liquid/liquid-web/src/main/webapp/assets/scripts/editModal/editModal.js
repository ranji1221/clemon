/**
 * Created by gu on 2017/9/15.
 */

$(function() {
	var editModal = $("#editModal");
	var editUserUrl = "backend/authority/user/edit/modal";
	var editSourceUrl = "backend/authority/resource/edit/modal";
	//var lookRoleUrl = "backend/authority/role/view/modal";
	var lookUserUrl = "backend/authority/user/view/modal";
	var lookSourceUrl = "backend/authority/resource/view/modal";
	const maxLimitNum = 10;

	function editUser(this_nid) {

		$.ajax({
			url: editUserUrl,
			dataType: "html",
			async: true,
			success: function(data) {
				$("#editUserModal").html(data);
				// 添加id
				$('#editUserModal .hidmission p').html('用户编辑'+this_nid);
			},
			error: function(data) {
				console.log(data);
			}
		});
	}
	$(document).on("click", ".editUser", function(e) {
		e.preventDefault();
		$('#editUserModal').modal('show');
		if($(this).attr('mintype')==1){
			return
		}else{
			var editUser_id=$(this).closest('tr').attr('listid');
			editUser(editUser_id);
		}
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

	/*function lookRoleModal(id) {
		$.ajax({
			dataType: "html",
			url: lookRoleUrl+'/'+ id,	
			async: true,
			success: function(data) {

				$("#lookRoleModal").html(data);
				$('#lookRoleModal .hidmission p').html('查看角色'+id);
			},
			error: function(data) {
				console.log(data);
			}
		});
	}

	$(document).on("click", ".lookRole", function(e) {
		e.preventDefault();
		$('#lookRoleModal').modal('show');
		if($(this).attr('mintype')==1){
			return
		}else{
			var lookRole_id=$(this).closest('tr').attr('listid');
			lookRoleModal(lookRole_id);
		}
	});*/

	function lookUserModal(id) {
		$.ajax({
			dataType: "html",
			url: lookUserUrl,
			async: true,
			success: function(data) {

				$("#lookUserModal").html(data);
				$('#lookUserModal .hidmission p').html('查看用户'+id);
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
		$('#lookUserModal').modal('show');
		if($(this).attr('mintype')==1){
			return
		}else{
			var lookUser_id=$(this).closest('tr').attr('listid');
			lookUserModal(lookUser_id);
		}
	});

	function lookSourceModal(id) {
		$.ajax({
			dataType: "html",
			url: lookSourceUrl,
			async: true,
			success: function(data) {


				$("#lookSourceModal").html(data);
				$('#lookSourceModal .hidmission p').html('查看资源'+id);
			},
			error: function(data) {
				console.log(data);
			}
		});
	}

	$(document).on("click", ".lookSource", function(e) {
		e.preventDefault();
		$('#lookSourceModal').modal('show');
		if($(this).attr('mintype')==1){
			return
		}else{
			var lookSource_id=$(this).closest('tr').attr('listid');
			lookSourceModal(lookSource_id);
		}
	});
	// 用户授权模态框的调用
//	$(document).on('click', '.user-aut', function() {
//		$.ajaxSetup({
//			cache: false
//		});
//		$('#user-authorization .modal-content').html('');
//		$('#user-authorization .modal-content').load('backend/authority/user/auth/modal')
//		$('#user-authorization').modal('show');
//	})
//	// 角色授权模态框的调用
//	$(document).on('click', '.role-aut', function() {
//		$.ajaxSetup({
//			cache: false
//		});
//		$('#role-authorization .modal-content').html('');
//		$('#role-authorization .modal-content').load('backend/authority/role/auth/modal')
//		$('#role-authorization').modal('show');
//	})
});
//限制输入字符
function limitChangeLength(elm, limitLength) {
	$(elm).attr("maxLength", limitLength);
	$(elm).keydown(function() {
		var length = $(elm).val().length;
		$(elm).siblings(".wordNum").html(limitLength - length);
	});
}