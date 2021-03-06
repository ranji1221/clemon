<%@ page language="java" pageEncoding="UTF-8" %>
<script>
	//滑块限制字符
	$(".sliderInput").css("width","0");
	var minlimitNum=5;
	$(".minlimitNum").html(minlimitNum);
	var docu_w = parseInt($(".sliderInput").css("width"));
	$(".error_box").slider({
		orientation: "horizontal",
		range: "min",
		max:67,
		value: 67,
		slide: function(event, ui) {
			var ui_value = ui.value
			$(".sliderInput").css("width",ui_value+"%");
			$(".minlimitNum").html(minlimitNum+parseInt(ui_value/10)-$(".sliderInput").find("input[type='text']").val().length);
			$(".sliderInput").find("input").val($(".sliderInput").find("input").val().slice(0,minlimitNum+parseInt(ui_value/10)))
			var max_length = minlimitNum+parseInt(ui_value/10)
			$(".sliderInput").find("input[type='text']").attr("maxlength",max_length)
			limitChangeLength($(".sliderInput").find("input[type='text']"), max_length);
		}
	})
	$(".sliderInput").css("width", $(".error_box").slider("value")+"%");
$(".minlimitNum").html(minlimitNum + parseInt($(".error_box").slider("value") / 10))	
	
	function limitChangeLength(elm, limitLength) {
		$(elm).attr("maxLength", limitLength);
		$(elm).keyup(function() {
			var length = $(elm).val().length;
			$(elm).siblings("span").html(limitLength - length);
		});
	}
	limitChangeLength($(".form_input .role"), parseInt($(".minlimitNum").html()));
	limitChangeLength($(".form_input .phone"), 11)
	limitChangeLength($(".form_input .emlia"), 15)

$(document).on("click","#submit_addUser",function(){
	$.post("${pageContext.request.contextPath}/backend/authority/user/save",
		{
			userName:$("#add_userName").val(),
			phone:$("#add_phone").val(),
			email:$("#add_email").val()
		},function(data){
			if(data.success){
				removeStorage();
				$(".ajax_dom").empty()
				$.ajax({
					url:"${pageContext.request.contextPath}/backend/authority/user/list"
				}).done(function(data){
					$(data).appendTo($(".ajax_dom"))
					$('.alertArea').showAlert({content:'添加成功'});
				})
			
			}
			else{
				alert("失败啦")
			}
		}
	,"json")
}) 
</script>
<ol class="breadcrumb breadcrumb_margin">
	<li>
		<i class="glyphicon glyphicon-home"></i>
		<a href="" url="home" data="2">首页</a>
	</li>
	<li>
		<a href="" url="${pageContext.request.contextPath}/backend/authority/user/list">用户管理</a>
	</li>
	<li class="active">添加用户</li>
	<div class="nav-search" id="nav-search">
		<form class="form-search">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="搜索你想找到的...">
				<span class="input-group-btn">
			        <button class="btn btn-default" type="button">
						<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
			        </button>
			        </span>
			</div>
			<!-- /input-group -->
		</form>
	</div>
</ol>
<div class="maxcontainer editpage modal-contentbox" >
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">用户管理</a>
	    </li>
	    <li>
	    	<a href="#" url="./pages/role/rolelist">用户列表</a>
	    </li>
	    <li class="active">编辑用户</li>
    	<div class="nav-search" id="nav-search">
			<form class="form-search">
				<div class="input-group">
			        <input type="text" class="form-control" placeholder="搜索你想找到的...">
			        <span class="input-group-btn">
			        <button class="btn btn-default" type="button">
						<img src="./assets/images/sys/iconsearch.png" alt="">
			        </button>
			        </span>
			    </div><!-- /input-group -->
			</form>
		</div>
	</ol>
	
	<div class="title">
		<p>添加用户</p>
		<div class="btns">
			<!-- <a href="javascript:;" class="min dom_minimize">
				<img src="./assets/images/sys/modal2.png" alt="">
				<div class="hidmission">
					<span class="icon-key icon-slidenav"></span>
					<p url='./pages/role/role-authorizationlg'>编辑角色</p>
					<span class="iconfont icon-chuyidong1 del"></span>
				</div>
			</a>
			<a href="javascript:;" class="maxrole" data-dismiss="modal" u_id="4">
				<img src="./assets/images/sys/modal3.png" alt="">
			</a>
			<a href="javascript:;" class="zclose" data-dismiss="modal">
				<img src="${pageContext.request.contextPath}/img/sys/modal1.png" alt="">
			</a> -->
		</div>
	</div>
	<div class="form_content">
		<form class="form-user-editlg newform">
			<div class="formhead">青柠云后台管理系统</div>
		  	<div class="form-group input">
		    	<label for="" >用户名称：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入用户名称" name='username'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-name">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group select">
		    	<label for="" >分配用户：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<select class="form-control select select-primary select-block mbl" data-toggle="select" name="fath">

							<option value="0" disabled="disabled">选择分配用户</option>
							<option value="1">用户列表</option>
							<option value="2">首页</option>
							<option value="3">用户列表</option>
							<option value="4">用户列表</option>

						</select>
				    	<span class="errormessage errormessage-role-edit-fath">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group phone">
		    	<label for="" >联系电话：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入联系电话" name='phone'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-phone">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="form-group email">
		    	<label for="" >邮箱：</label>
		    	<div class="inputwrapper">
		    		<div class="inputwrappermax">
				    	<input type="text" class="form-control rolenameinput" placeholder="请输入邮箱" name='email'>
				    	<span class="limitlength">15</span>
				    	<span class="errormessage errormessage-user-edit-email">
			    		<!-- 您输入了特殊符号！ -->
			    		</span>
		    		</div>
		    	</div>
		  	</div>
		  	<div class="btnbox">
				<button type="button" class="btn btn-default submitbtn-role-edit" disabled>确定</button>
				<button type="button" class="btn btn-default">取消</button>
		  	</div>
		</form>
	</div>
	
</div>
