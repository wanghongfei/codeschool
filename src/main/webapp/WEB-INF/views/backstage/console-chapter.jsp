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
	</head>
	<body id="body" class="skin-blue">
		<!-- header logo: style can be found in header.less -->
		<header class="header">
			<a href="index.html" class="logo">课程后台管理</a>
		</header>
		
		
		<div class="wrapper row-offcanvas row-offcanvas-left">
			<!-- 左侧主体 starts -->
			<%@ include file="/WEB-INF/views/fragment/console-left.jsp" %>	
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
				        <li><a href="#"><i class="fa fa-dashboard"></i> 添加章节</a></li>
				        <!-- <li class="active">Blank page</li> -->
				    </ol>
				</section>
				
				<!-- Main content -->
		        <section class="content">
		        	<h1>添加章节</h1>
		        	<form id="form" action="<c:url value='/backstage/chapter/save' />">
		        		<div>
		       		 		<select id="select-course">
		        				<c:forEach items="${ courseList }" var="_c">
		        					<option value="${ _c.id }"><c:out value="${ _c.courseName }"  /></option>	
		        				</c:forEach>
		       	 			</select>
		        		</div>
		        		
		        		<div>
			        		<label for="chapter-name">章节名称：</label>
			        		<input type="text" name="chapterName" id="chapter-name" />
			        	</div>
			        	
			        	<div>
			        		<input type="submit" value="保存" />
			        	</div>
			        	
			        	<div id="error-msg" class="hidden"></div>
		        	</form>
		        	
				
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

		<script type="text/javascript">
			$(document).ready(function() {
				$("#form").submit(function(e) {
					e.preventDefault();
					
					var json = {
						courseId: $("#select-course option:selected").val(),
						chapterName: $("#chapter-name").val()
					};
					
					var url = $(this).attr("action");
					console.log("url : " + url);
					
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
	   							$("#chapter-name").val("");
	   						}
	   					}
	   				});
				});
			});
	    </script>

	</body>

</html>

