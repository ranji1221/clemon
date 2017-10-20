<%@ page language="java" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath}/js/database/recoverlist.js"></script>
	
<div class="rolelist recoverlist">
	<ol class="breadcrumb">
	    <li>
	    	<i class="glyphicon glyphicon-home"></i>
	    	<a href="#" data="2" url="home">首页</a>
	    </li>
	    <li>
	    	<a href="#">数据库管理</a>
	    </li>
	    <li class="active">数据库列表</li>
    	<div class="nav-search" id="nav-search">
			<form class="form-search">
				<div class="input-group">
			        <input type="text" class="form-control" placeholder="搜索你想找到的...">
			        <span class="input-group-btn">
			        <button class="btn btn-default" type="button">
						<img src="${pageContext.request.contextPath}/img/sys/iconsearch.png" alt="">
			        </button>
			        </span>
			    </div><!-- /input-group -->
			</form>
		</div>
	</ol>
	<div class="alert alert-danger">
		<i class="glyphicon glyphicon-hand-right"></i>

		温馨提示：本功能在恢复数据的同时，将全部覆盖原有数据！  单击右方x号，你可以关闭此条提示语！

		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	</div>
	<div class="tablewrap">
		<table class="table ">
			<thead>
				<tr>
					<th style="width:14%">
						文件名
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th style="width:30%">
						备份时间
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th style="width:11%">
						大小
						<span class="sort">
							<i class="glyphicon glyphicon-triangle-top"></i>
							<i class="glyphicon glyphicon-triangle-bottom"></i>
						</span>
					</th>
					<th>
						备注
					</th>
					<!-- <th style="width:0.6rem">查看</th> -->
					<th style="width:0.6rem">导入</th>
					<th>删除</th>
				</tr>
			</thead>
			<tbody>
				<tr listid='01'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='02'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<!-- <td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td> -->
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
					<!-- <td>
						<span class="icon-key iconact"></span>
					</td> -->
				</tr>
				<tr listid='03'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='04'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<!-- <td>
						<span class="icon-eye-open iconact lookRole"></span>
					</td> -->
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
					<!-- <td>
						<span class="icon-key iconact"></span>
					</td> -->
				</tr>
				<tr listid='05'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='06'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='07'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='08'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='09'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='10'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='11'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='12'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='13'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='14'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
				<tr listid='15'>
					<td title="xxx数据库">
						xxx数据库
					</td>
					<td title="2017/01/01">
						2017/01/01
					</td>
					<td title="823KB">
						823KB
					</td>
					<td title="查看备注" class='remarks'>
						查看备注
					</td>
					<td>
						<span class="glyphicon glyphicon-log-in iconact leading"></span>
					</td>
					<td>
						<span class="icon-trash iconact removeBtn redtrash"></span>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="tfoot2">
		</div>
	</div>