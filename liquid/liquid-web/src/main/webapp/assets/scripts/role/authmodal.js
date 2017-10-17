$(function(){
	zishuxianzhi('.rolenameinput','.rolenamelimit',15);
	// 限制字数方法zl_input获取输入框元素zl_message获取提示信息元素zl_limit限制字数值
	function zishuxianzhi(zl_inputele,zl_messageele,zl_limitnum){
		var zl_input=$(zl_inputele);
		var zl_message=$(zl_messageele);
		var zl_limit=zl_limitnum;

		if(zl_limit-zl_input.val().length<0){

			zl_message.html(0);
		}else{
			zl_message.html(zl_limit-zl_input.val().length);
		}
		// 配合滑块截取超出字符，单独限制字符不需要此片段
		var zl_con=zl_input.val()
		if(zl_input.val().length>zl_limit){
			zl_message.html(0);
			zl_input.val(zl_con.substr(0,zl_limit));
		}else{
			zl_message.html(zl_limit*1-zl_input.val().length*1)
		}
		zl_input.off().on('keyup',function(){
			var zl_con=$(this).val()
			if($(this).val().length>zl_limit){
				zl_message.html(0);
				zl_input.val(zl_con.substr(0,zl_limit));
			}else{
				zl_message.html(zl_limit*1-$(this).val().length*1)
			}
		})
	}
		// zishuxianzhi('#role-authorizationlg .rolenameinput','#role-authorizationlg .rolenamelimit',15);
		// 滑块
		var changenum;//修改限制字数用
		$(".role-slider").slider({
		    // orientation: "vertical",
		    range: "min",
		    min: 0,
		    max: 100,
		    value: 50,
		    slide: function (event, ui) {
		    	changenum=Math.floor((ui.value-50)/5);
				zishuxianzhi('#role-authorizationlg .rolenameinput','#role-authorizationlg .rolenamelimit',15+changenum);
		    	// console.log(changenum)
		        // console.log(ui.value-50)
		        $('#role-authorizationlg .inputwrappermax').css('width',50+ui.value/2+'%')
		    }
		});
		//设置初始宽度
		var widthpercent=$(".role-slider").slider('value');
		$('#role-authorizationlg .inputwrappermax').css('width',50+widthpercent/2+'%');
	// 复选框
	$('#role-authorization header input[type=checkbox]').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	});
	$('#role-authorization .form-group >label.prompt input[type=checkbox]').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	});
	$('#role-authorization .checkallaut').on('ifChecked', function(event){
	  	// $(".role-authorization-jstree").jstree(true).select_all()
	  	$(this).closest('.wrapper').find('.role-authorization-jstree').jstree(true).check_all ()
	  	
	});
		$('#role-authorization .checkallaut').on('ifUnchecked', function(event){
	  	$(this).closest('.wrapper').find(".role-authorization-jstree").jstree(true).uncheck_all ()
	  	$('.role-authorization-jstree .jstree-disabled').each(function(){
			$(this).closest('.wrapper').find(".role-authorization-jstree").jstree(true).check_node($(this))
		})
		// $(".role-authorization-jstree").jstree(true).check_node('.jstree-disabled')
	  	// $(".role-authorization-jstree").jstree(true).deselect_all()
	});
		$('#role-authorization .slidedownallaut').on('ifChecked', function(event){
	  	$(this).closest('.wrapper').find(".role-authorization-jstree").jstree(true).open_all()
	});
		$('#role-authorization .slidedownallaut').on('ifUnchecked', function(event){
	  	$(this).closest('.wrapper').find(".role-authorization-jstree").jstree(true).close_all()
	});
	// 树形图
	
	$(".role-authorization-jstree").jstree({
		// "state":{"key":"this_bulkadd"},
		'core' : {
				'themes':{'icons':false},
		        'data' : [
		            {
		            	'id':'1',
		                "text" : "插件管理",
		                "state" : {"opened" : true,"selected" : true,"disabled" : true },
		                
		                "children" : [
							{
							'id':'2',
							"text" : "查看",
							"state" : { "selected" : true,"disabled" : true },
							// "icon" : "glyphicon glyphicon-flash"
							},
							{ 'id':'3',"text" : "添加", "state" : { "selected" : true,"disabled" : true } },
							{ 'id':'4',"text" : "修改", "state" : { "selected" : true,"disabled" : true } },
							{ 'id':'5',"text" : "删除", "state" : { "selected" : true,"disabled" : true } },
							{ 'id':'6',"text" : "本地安装", "state" : { "selected" : true,"disabled" : true } },
							{ 'id':'7',"text" : "禁用", "state" : { "selected" : true,"disabled" : true } },
							{ 'id':'8',"text" : "本地安装", "state" : { "selected" : true,"disabled" : true } },
			            ]
		        	},
		        	{
		                'id':'9',"text" : "权限管理",
		                "state" : {"opened" : true },
		                "children" : [
		                    {
			                    'id':'10',"text" : "规则管理",
			                    // "state" : { "selected" : true },
			                    "children" : [
				                    {'id':'11',"text" : "规则管理1",},
				                    {'id':'12',"text" : "规则管理2",},
				                    {'id':'13',"text" : "规则管理3",},
				                    {'id':'14',"text" : "规则管理4",},
				              	]
			                },
		                  	{ 
		                  		'id':'15',"text" : "角色组", 
		                  		"state" : { "selected" : true } ,
		                  		"children" : [
				                    {'id':'16',"text" : "角色组1",},
				                    {'id':'17',"text" : "角色组2",},
				                    {'id':'18',"text" : "角色组3",},
				                    {'id':'19',"text" : "角色组4",},
				              	]
		                  	}
		              	]
		        	}
		      	]
		    },
		"checkbox": {
			"keep_selected_style": false,
			'cascade_to_disabled':false,
	        // "tie_selection" : false,
		},
		"plugins": ["checkbox"]
		// "plugins": ["checkbox","state"]
	});
	
	// 大小切换按钮,1是模态框2是页面
	
    // 关闭按钮
    $('.modal .zclose').on('click',function(){
    	if($(this).closest('.modal-contentbox').prop('id')=='role-authorizationlg'){
    		$(this).closest('.modal-contentbox').remove();
    		if(!$('.ajax_dom').html()){
    			$('.ajax_dom').hide()
    		}
    	}else{

    	}
    })
	// 最小化隐藏
	$('.modal .min').on('click',function(){
		if($(this).closest('.modal-contentbox').prop('id')=='role-authorizationlg'){
			$(this).closest(".modal-contentbox").prependTo($(".minbox"));
    		if(!$('.ajax_dom').html()){
    			$('.ajax_dom').hide()
    		}
    	}else{
    		$(this).closest('.modal').modal('hide');
			$(this).closest(".modal-contentbox").prependTo($(".minbox"));

    	}
    	
    })
})
