$(function(){
	// 复选框
	$('.tablewrap input').iCheck({
	    checkboxClass: 'icheckbox_flat-blue',
	    radioClass: 'iradio_flat-blue',
	    labelHover : true, 
	  	cursor : false,
	 });
	$('#checkall').on('ifChecked', function(event){
	  	$('.tablewrap input').iCheck('check')
	});
		$('#checkall').on('ifUnchecked', function(event){
	  	$('.tablewrap input').iCheck('uncheck')
	});
	// 排序
	$('div.tablewrap table tr th span.sort').on('click',function(){
		var zlsortup=$(this).find('.glyphicon-triangle-top');
		var zlsortdown=$(this).find('.glyphicon-triangle-bottom');
		var zlsort=zlsortup.css('opacity');

		$(this).closest('th').siblings('th').find('span i').css('opacity','1');
		if(zlsort=='1'){
			zlsortup.css('opacity','0');
			zlsortdown.css('opacity','1');
		}else{
			zlsortup.css('opacity','1');
			zlsortdown.css('opacity','0');
		}		
	})
	
})