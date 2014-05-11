<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8" />
		<title>后台管理</title>
		<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
		<link href='<c:url value="/resources/css/bootstrap.min.css" />'  rel="stylesheet" />
		<!-- Theme style -->
		<link href='<c:url value="/resources/css/AdminLTE.css" />' rel="stylesheet" />

		<!-- font Awesome -->
		<link href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet" type="text/css" />
		<!-- Ionicons -->
		<link href="<c:url value="/resources/css/ionicons.min.css" />" rel="stylesheet" type="text/css" />

		
	
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
			<![endif]-->	
			
		<style>
			.error-msg{
				color: red;
			}
		</style>
			
	</head>
	<body id="body" class="skin-blue">
		<!-- header logo: style can be found in header.less -->
		<header class="header">
			<a href="index.html" class="logo">课程后台管理</a>
		</header>
		
		
		<div class="wrapper row-offcanvas row-offcanvas-left">
			<!-- 左侧主体 starts -->
			<aside class="left-side sidebar-offcanvas">
				<!-- sidebar: style can be found in sidebar.less -->
			    <section class="sidebar">
			        <!-- Sidebar user panel -->
			        <div class="user-panel">
			            <div class="pull-left image">
			                <img src="img/avatar3.png" class="img-circle" alt="User Image" />
			            </div>
			            <div class="pull-left info">
			                <p>Hello, Jane</p>
			
			                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			            </div>
			        </div>
			        
			
			        <!-- sidebar menu: : style can be found in sidebar.less -->
			        <ul class="sidebar-menu">
			            <!-- <li class="active"> -->
			            <li>
			                <a href="#">
			                    <i class="fa fa-dashboard"></i> <span>添加课程</span>
			                </a>
			            </li>
			            <li>
			                <a href="">
			                    <i class="fa fa-th"></i> <span>添加章节</span> <small class="badge pull-right bg-green">new</small>
			                </a>
			            </li>
			            <li>
			                <a href="#">
			                    <i class="fa fa-th"></i> <span>添加小节</span> <small class="badge pull-right bg-green">new</small>
			                </a>
			            </li>
			            <li class="treeview">
			                <a href="#">
			                    <i class="fa fa-bar-chart-o"></i>
			                    <span>添加小节</span>
			                    <i class="fa fa-angle-left pull-right"></i>
			                </a>
			                <ul class="treeview-menu">
			                    <li><a href="pages/charts/morris.html"><i class="fa fa-angle-double-right"></i> Morris</a></li>
			                    <li><a href="pages/charts/flot.html"><i class="fa fa-angle-double-right"></i> Flot</a></li>
			                    <li><a href="pages/charts/inline.html"><i class="fa fa-angle-double-right"></i> Inline charts</a></li>
			                </ul>
			            </li>
			            
			        </ul>
			    </section>
			</aside>
			<!-- 左侧主体 ends -->
			
			<!-- 右侧主体 -->
			<aside class="right-side">
				<!-- Content Header (Page header) -->
				<section class="content-header">
				    <h1>
				        Blank page
				        <small>Control panel</small>
				    </h1>
				    <ol class="breadcrumb">
				        <li><a href="#"><i class="fa fa-dashboard"></i> 添加课程</a></li>
				        <!-- <li class="active">Blank page</li> -->
				    </ol>
				</section>
				
				<!-- Main content -->
		        <section class="content">
		        	<h1>添加课程</h1>
		        	
		        	<form id="form" action="<c:url value='/backstage/course/save' />">
		        		<div>
			        		<label for="course-name">课程名称:</label>
			        		<input type="text" name="courseName" id="course-name" />
			        	</div>
			        	
			        	<div>
			        		<label for="course-description">课程介绍：</label>
			        		<textarea name="courseDescription" id="course-description" rows="10" cols="30" ></textarea>
			        	</div>
			        	
			        	<div>
			        		<input type="submit" value="保存" />
			        	</div>
			        	
			        	<div id="error-msg"></div>
		        	</form>
		        	
					
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

		<script type="text/javascript">
			$("#form").submit(function(e) {
				e.preventDefault();
				
				var json = {
					courseName: $("input[name='courseName']").val(),
					courseDescription: $("textarea[name='courseDescription']").val()
				};
				
				$.ajax({
   					url: $("#form").attr("action"),
   					type: "POST",
   					dataType: 'json',
   					contentType: 'application/json',
   					data: JSON.stringify(json),
   					success: function(data) {
   						var msg = $("#error-msg");
   						
   						msg.html(data.message);
   						msg.removeClass("hidden").addClass("error-msg");
   						
   						// 清空表单
   						if (true == data.result) {
   							$("input[name='courseName']").val("");
   							$("textarea[name='courseDescription']").val("");
   						}
   					}
   				});
			});
	    </script>

	</body>

</html>

