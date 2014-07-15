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
			<%@ include file="/WEB-INF/views/fragment/console-left.jsp" %>	
			<!-- 左侧主体 ends -->
			
			<!-- 右侧主体 -->
			<aside class="right-side">
				<!-- Content Header (Page header) -->
				<section class="content-header">
				    <h1>
					    <a href="/">回到主页</a>
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
			        		<label for="course-language">编程语言：</label>
			        		<input type="text" name="courseLanguage" id="course-language" />
			        	</div>
			        	
			        	<div>
			        		<input type="submit" value="保存" />
			        	</div>

			        	
			        	<div id="error-msg"></div>
		        	</form>
		        	
		        	
		        	<form id="form-del" action="<c:url value='/backstage/course/delete' />">
		        		<div>
		       		 		<select id="select-course">
		        				<c:forEach items="${ courseList }" var="_c">
		        					<option value="${ _c.id }"><c:out value="${ _c.courseName }"  /></option>	
		        				</c:forEach>
		       	 			</select>
		        		</div>
		        	
			        	<div>
			        		<button id="btn-del" class="btn" >删除课程</button>
			        	</div>
			        	
			        	<div class="error-msg"></div>
		        	</form>
					
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>
		<script src="<c:url value='/resources/js/app.js' />"></script>

		<script type="text/javascript">
	    </script>
		<script src="<c:url value='/resources/js/console-course.js' />"></script>

	</body>

</html>

