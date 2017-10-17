$(function(){
	zishuxianzhi('#user-authorization .usernameinput','#user-authorization .usernamelimit',15);
	// 限制字数方法zl_input获取输入框元素zl_message获取提示信息元素zl_limit限制字数值
	function zishuxianzhi(zl_inputele,zl_messageele,zl_limitnum){
		var zl_input=$(zl_inputele);
		var zl_message=$(zl_messageele);
		var zl_limit=zl_limitnum;
		// console.log(zl_input)
		console.log(zl_limit,zl_input)
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
		// zishuxianzhi('#user-authorizationlg .usernameinput','#user-authorizationlg .usernamelimit',15);
		// 滑块
		var changenum;//修改限制字数用
		$(".user-slider").slider({
		    // orientation: "vertical",
		    range: "min",
		    min: 0,
		    max: 100,
		    value: 50,
		    slide: function (event, ui) {
		    	changenum=Math.floor((ui.value-50)/5);
				zishuxianzhi('#user-authorizationlg .usernameinput','#user-authorizationlg .usernamelimit',15+changenum);
		    	// console.log(changenum)
		        // console.log(ui.value-50)
		        $('#user-authorizationlg .inputwrappermax').css('width',50+ui.value/2+'%')
		    }
		});
		//设置初始宽度
		var widthpercent=$(".user-slider").slider('value');
		$('#user-authorizationlg .inputwrappermax').css('width',50+widthpercent/2+'%');
	// 复选框
	$('#user-authorization header input[type=checkbox]').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	 });
	$('#user-authorization .form-group >label.prompt input[type=checkbox]').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	 });
	$('.checkallaut').on('ifChecked', function(event){
	  	// $(".user-authorization-jstree").jstree(true).select_all()
	  	$(this).closest('.wrapper').find(".user-authorization-jstree").jstree(true).check_all ()
	});
	$('.checkallaut').on('ifUnchecked', function(event){
	  	$(".user-authorization-jstree").jstree(true).uncheck_all ()
	  	$(this).closest('.wrapper').find('.user-authorization-jstree .jstree-disabled').each(function(){
			$(this).closest('.wrapper').find(".user-authorization-jstree").jstree(true).check_node($(this))
		})
		// $(".user-authorization-jstree").jstree(true).check_node('.jstree-disabled')
	  	// $(".user-authorization-jstree").jstree(true).deselect_all()
	});
		$('.slidedownallaut').on('ifChecked', function(event){
	  	$(this).closest('.wrapper').find(".user-authorization-jstree").jstree(true).open_all()
	});
		$('.slidedownallaut').on('ifUnchecked', function(event){
	  	$(this).closest('.wrapper').find(".user-authorization-jstree").jstree(true).close_all()
	});
	// 树形图
	
	$(".user-authorization-jstree").jstree({
		'core' : {
			'themes':{'icons':false},
	        'data' : [
	        {"id":"1","parent":"#","text":"研发部","state":{"opened":true}},
	        {"id":"2","parent":"1","text":"UI设计师","state":{"selected":true}},
	        {"id":"3","parent":"1","text":"前端工程师","state":{"selected":true}},
	        {"id":"4","parent":"1","text":"PHP工程师","state":{"selected":true}},
	        {"id":"5","parent":"1","text":"JAVA工程师",},
	        {"id":"6","parent":"1","text":"PHP工程师",},
	        {"id":"7","parent":"1","text":"PHP工程师",},
	        {"id":"8","parent":"#","text":"研发部2","state":{"opened":true}},
	        {"id":"9","parent":"8","text":"UI设计师","state":{"selected":true}},
	        {"id":"10","parent":"8","text":"前端工程师","state":{"selected":true}},
	        {"id":"11","parent":"8","text":"PHP工程师","state":{"selected":true}},
	        {"id":"12","parent":"8","text":"JAVA工程师",},
	        {"id":"13","parent":"8","text":"PHP工程师",},
	        {"id":"14","parent":"8","text":"PHP工程师",},
	        {"id":"15","parent":"#","text":"研发部3","state":{"opened":true}},
	        {"id":"16","parent":"15","text":"UI设计师","state":{"selected":true}},
	        {"id":"17","parent":"15","text":"前端工程师","state":{"selected":true}},
	        {"id":"18","parent":"15","text":"PHP工程师","state":{"selected":true}},
	        {"id":"19","parent":"15","text":"JAVA工程师",},
	        {"id":"20","parent":"15","text":"PHP工程师",},
	        {"id":"21","parent":"15","text":"PHP工程师",},
	        {"id":"22","parent":"#","text":"研发部4","state":{"opened":true}},
	        {"id":"23","parent":"22","text":"UI设计师","state":{"selected":true}},
	        {"id":"24","parent":"22","text":"前端工程师","state":{"selected":true}},
	        {"id":"25","parent":"22","text":"PHP工程师","state":{"selected":true}},
	        {"id":"26","parent":"22","text":"JAVA工程师",},
	        {"id":"27","parent":"22","text":"PHP工程师",},
	        {"id":"28","parent":"22","text":"PHP工程师",},
      	]
	    },
		"checkbox": {
			"keep_selected_style": false,
			'cascade_to_disabled':false,
			// 'tie_selection':false,
		},
		"plugins": ["checkbox"]
	});
	
    // 大小切换按钮mintype,1是模态框2是页面
    $('.modal .maxuser').on('click',function(){
		if($(this).closest('.modal-contentbox').prop('id')!=='user-authorizationlg'){
	        $(this).closest('.modal').modal('hide')
	        $(this).closest('.modal-contentbox').prop('id','user-authorizationlg');
	        $(this).closest('.modal').find('.hidmission p').attr('mintype','2')
	        $(this).closest('.modal-contentbox').appendTo('.ajax_dom');
	        $(".ajax_dom").show(0);
	        $(".user-slider").slider({value: 50,});
	        $('.inputwrappermax').css('width',50+50/2+'%')
		}else{
	        $(this).closest('.modal-contentbox').appendTo('#user-authorization .modal-content');
	        if(!$('.ajax_dom').html()){
    			$('.ajax_dom').hide()
    		}
	        $(this).closest('.modal-contentbox').prop('id','');
			zishuxianzhi('#user-authorization .usernameinput','#user-authorization .usernamelimit',15);
			$('.inputwrappermax').css('width','100%');
	        $(this).closest('.modal').modal('show')
	        $(this).closest('.modal').find('.hidmission p').attr('mintype','1')
		}
	})
    // 关闭按钮
    $('.modal .zclose').on('click',function(){
    	if($(this).closest('.modal-contentbox').prop('id')=='user-authorizationlg'){
    		$(this).closest('.modal-contentbox').remove();
    		if(!$('.ajax_dom').html()){
    			$('.ajax_dom').hide()
    		}
    	}else{

    	}
    })
    // 最小化隐藏
	$('.modal .min').on('click',function(){
		if($(this).closest('.modal-contentbox').prop('id')=='user-authorizationlg'){
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