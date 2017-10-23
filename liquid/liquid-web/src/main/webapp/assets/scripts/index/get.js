(function($){
	$(function(){
					var arr = [
						"common/icheck/skins/all.css",
						"common/icheck/icheck.js",
						"js/index/getDom.js",
						"css/editModal/editModal.css",
						"common/vakata-jstree/dist/themes/default/style.min.css",
						"common/vakata-jstree/dist/jstree.min.js",
						"js/pagination/simplePagination.css",
						"css/role/listREM.css",
						"css/role/authmodal.css",
						"css/user/auth.css",
						"css/role/addsREM.css",
						"css/role/role.css",
						"https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css",
						"css/user/edit.css",
						"css/resources/add.css",
						"js/icheck/custom.min.js",
						"css/role/view.css",
						"css/database/progress.css",
						"js/database/progress.js",
						"css/database/backup.css",
						"css/role/editnew.css",
						"common/bootstrapvalidator/js/bootstrapValidator.js",
						"common/bootstrapvalidator/css/bootstrapValidator.css"
						]
		$.each(arr,function(i,v){
			if(v.substring(v.length-3) == "css"){
				$("<link>").attr({rel:"stylesheet",href:v}).appendTo("head")
			}else{
				$("<script>").attr({src:v}).appendTo("head")
			}
		})
	})
})(jQuery)
