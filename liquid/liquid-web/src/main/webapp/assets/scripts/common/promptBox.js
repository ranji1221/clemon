
$(function(){
	//确认信息框
	$.fn.bindDialogs = function(params){
		$(document).off("click.remove_click","**")
		$('#removeModal').off("click.success_del",".delBtn")
		$('#removeModal').off("click.cancel_clo",'.closeBtn')
		var _this = this;
		var lastClickElement = '';
		var defaults = {
			modalTypeImg: 'img/modal/trash.png',
			content:'您确定执行本操作吗？',
			prompt:'*此项操作不可逆！<br/>如果确认则点击“确定”，否则点“取消”',
			success:function(){},
			cancel:function(){}
		};
		var this_obj = $.extend(defaults,params);
		
		//去 后台 请求数据
		$(document).on("click.remove_click",_this.selector, function(e) {
			$(".remove_alert").detach()
			lastClickElement = this;
			e.stopPropagation();
			e.preventDefault();		
			$('#removeModal .modal').modal('show');
			$("#removeModal .modal-body").html(
				'<div class="row">'+
				   ' <div class="col-xs-4">'+
			       ' <div class="trashImg text-right">'+
			           ' <img src="'+this_obj.modalTypeImg+'" alt="">'+
			        '</div>'+
			   ' </div>'+
			    '<div class="col-xs-8 info">'+
			        '<h3>'+this_obj.content+'</h3>'+
			        '<p>'+this_obj.prompt+'</p>'+
			    '</div>'+
			'</div>'+
			'<div class="row">'+
			    '<div class="col-xs-8 col-xs-offset-4">'+
			    	'<button type="button" class="btn modalBtn delBtn" >确定</button>'+
			    	'<button type="button" class="btn modalBtn closeBtn" >取消</button>'+
			    '</div>'+
			'</div>'
			);
			
		});
		$('#removeModal').on("click.success_del",'.delBtn', function(e) {
			this_obj.success(lastClickElement);
			hiddenModal();
		});
		$('#removeModal').on("click.cancel_clo",'.closeBtn', function(e) {
			this_obj.cancel(lastClickElement);
			hiddenModal();
		});
		function hiddenModal(){
			$('#removeModal .modal').modal('hide');
		}
	}
	
	//创建公共的警告框	
	$.fn.showAlert = function(params){
		var _this = this;
		var lastClickElement = '';
		var defaults = {
			content:'',
			time:'5',
			type:'success', //有4中状态，1,success(绿色) 2,info(蓝色) 3,warning(黄色) 4,danger(红色)
		};
		var this_obj = $.extend(defaults,params);
		var uid = 'tem_alert_'+parseInt(Math.random()*9999);
		var div = '<div class="remove_alert '+uid+' alert alert-'+this_obj.type+' role="alert"><i class="glyphicon glyphicon-hand-right"></i>'+this_obj.content+'</div>';

		$(div).appendTo(_this.selector);
		setTimeout(function(){
			$(_this.selector+' .'+uid).fadeOut(2000,function(){
				$(_this.selector+' .'+uid).remove();
			})
		},this_obj.time*1000)
	}
});	


