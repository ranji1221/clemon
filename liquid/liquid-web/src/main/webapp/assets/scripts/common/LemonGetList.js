$(function(){
	//给jquery添加表格插件
	$.fn.LemonGetList = function(params){
		var _this = this;
		var defaults = {
			useLocalStorage: false,
			
			data:{},
			pageSize:"10",
			requestListUrl:" ",
			
			pageClassName:false,
			searchClassName:false,
			
			//生成一个的方法
			generateItemFun : function(){
				return '';
			},
			//渲染页面之前的操作
			beforeFun : function(data){ 
				console.log('处理数据之前的操作 : beforeFun(data), 需要返回待处理数组');
				return data.rows;
				
			},
			//渲染页面之后的操作
			afterFun : function(){ 
				console.log('生成页面之后的操作 : afterFun()');
			},
			emptyDataFun : function(){
				return "<tr><td style='width:100%' colspan='8'><span class='center text-center' style='display:inline-block;width:100%;'>没有查找到数据!</span></td></tr>";
			}
		};
		var TableObj = $.extend(defaults,params);
		
		//扩展业务字段
		var saveStorageName = '';
		
		//去 后台 请求数据
		var getData = function(url,pages,page_first){
			//如果使用分页,执行下面添加page和rows代码
			if(TableObj.pageClassName){
				TableObj.data.page = pages;
				TableObj.data.rows = TableObj.pageSize;
			}
			//设置本地存储名称
			if(TableObj.useLocalStorage){
				saveStorageName = '';
				for (var Key in TableObj.data){
					saveStorageName += '_'+TableObj.data[Key];
				}
				saveStorageName = TableObj.requestListUrl+saveStorageName; 
				var data = getStorage(saveStorageName);
			}else{
				var data = '';
			}
			if(data){
	 			dealData(data,pages,page_first);
			}else{
				$.post(url,TableObj.data, function(data){  //get 请求数据 需要获取当前 总数 和 本次分页数据
					if(TableObj.useLocalStorage){ setStorage(saveStorageName,data); }
					dealData(data,pages,page_first);
				},"json");
			}
		};
		getData(TableObj.requestListUrl,1,true)
		
		//处理来自服务器端的数据
		function dealData(data,pages,page_first){
			var dataList = TableObj.beforeFun(data);
			if(!dataList){
				console.log('beforeFun : return data 为空');
				return ;
			}
			if(TableObj.searchClassName) { createSearch(); }
			if(dataList.length > 0){
				if(page_first && TableObj.pageClassName){ 
					//如果页面是第一次加载,进入本流程
					createPage(data.total);
				}
				initHtml(dataList);
				TableObj.afterFun();
			}else{
				_this.html(TableObj.emptyDataFun());
			}
		}
		function initHtml(data){
			var html = '';
			$.each(data,function(index,value,data){
				if(TableObj.useLocalStorage){ 
					var storage_name = ' storage_name="'+saveStorageName+'" ';
					var storage_id = ' storage_id="'+index+'" ';
					var extend = storage_name + storage_id;
				}else{
					var extend = '';
				}
				
				html += TableObj.generateItemFun(index,value,data,extend);
			})
			_this.html(html);
		}
		
		//分页相关---
		// 需要 当前分页 和 总数
		function createPage(all_num){
			var now_page = TableObj.data.page;
			var pageSize = TableObj.data.rows;
			// 计算总页数
			total_pages = all_num % pageSize == 0 ? (all_num / pageSize):(all_num / pageSize) +1 ;	
			total_pages = parseInt(total_pages);
			if(total_pages >= 2){
				pagePlug(total_pages);
			}
		}
		function pagePlug(total_pages){
			//生成分页
			$(TableObj.pageClassName).pagination({
				items: total_pages,
		        itemOnPage: TableObj.pageSize,
		        currentPage: 1,
		        cssStyle: '',
		        prevText: ' ',
		        nextText: ' ',
		        onInit: function () {
		            // fire first page loading
		        },
		        onPageClick: function (page, evt) {
		        	getData(TableObj.requestListUrl,page,false);
		        }
				
			})
		}
		function createSearch(){
			var img_path = 'img/sys/iconsearch.png';
			var search_str = 
				'<div class="input-group list_search">'+
			        '<input type="text" id="list_search_str" class="form-control" placeholder="搜索你想找到的..." name="list_search_str"  >'+
			        '<span class="input-group-btn">'+
			        '<button class="btn btn-default" type="button" id="list_search_btn">'+
						'<img src="'+img_path+'" alt="">'+
			        '</button>'+
			        '</span>'+
			    '</div>';
			$(TableObj.searchClassName).html(search_str);
			$(TableObj.searchClassName+" #list_search_btn").on('click',function(){
				console.log($(TableObj.searchClassName+" #list_search_str"));
			})
		}
	}
})

