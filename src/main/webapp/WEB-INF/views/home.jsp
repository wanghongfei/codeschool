<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="utf-8" />
		<title>编程乐园</title>
		<meta name="viewport" content="width=device-width,initial-scale=1.0" />
		<link href='<c:url value="/resources/css/bootstrap.min.css" />'  rel="stylesheet" />
		<link href='<c:url value="/resources/css/strapped.css" />' rel="stylesheet" />
		<!-- Theme style -->
		<link href='<c:url value="/resources/css/AdminLTE.css" />' rel="stylesheet" />
        
        	
		<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
		<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
	</head>
	<body id="body">

		<!--  顶部导航 starts -->
		<%@ include file="/WEB-INF/views/fragment/nav.jsp" %>		
		<!--  顶部导航 ends -->


		<!-- 顶部大图 -->
		<div id="top" class="jumbotron">
			<div class="container">
				<h1>交互式编程学习,</h1>
				<h2>彻底摆脱枯燥、乏味的学习方式！</h2>
				<p>
					<a class="btn btn-warning btn-lg scroll-link" href="#choose-course">马上开始coding<span class="glyphicon glyphicon-circle-arrow-right"></span></a>
				</p>
			</div>
		</div>
		<!-- /.jumbotron -->

		<div class="container" id="choose-course">
			<h3 id="benefits" class="subhead">选择一门课程</h3>
		<div class="row">
			<c:forEach items="${ courseList }" var="_c">
				<div class="col-md-4 col-sm-6 benefit">
					<a href="<c:url value='/courses/list'><c:param name='courseId' value='${ _c.id }' /></c:url>" >
						<div class="benefit-ball">
							<span class="glyphicon glyphicon-search"></span>
						</div>
					</a>
				
					<h3>${ _c.courseName }</h3>
					<p>2小时快速掌握HTML网页设计</p>
				</div>
			</c:forEach>
				<div class="col-md-4 col-sm-6 benefit">
						<div class="benefit-ball" style="background-color: gray;">
							<span class="glyphicon glyphicon-search"></span>
						</div>
				
					<h3>JavaScript</h3>
					<p>即将推出</p>
				</div>
				
				<div class="col-md-4 col-sm-6 benefit">
						<div class="benefit-ball" style="background-color: gray;">
							<span class="glyphicon glyphicon-search"></span>
						</div>
				
					<h3>C语言</h3>
					<p>即将推出</p>
				</div>

		</div>
		<!-- /.row -->

		<div class="sect-border"></div>
		</div>
		
		<%-- 登陆 --%>
		<%@ include file="/WEB-INF/views/fragment/login.jsp" %>		
		
		

		<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>		
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

		<%@ include file="/WEB-INF/views/fragment/chat.jsp" %>		

		<script src="<c:url value='/resources/js/app.js' />"></script>
		<script src="<c:url value='/resources/js/login.js' />"></script>
		<script src="<c:url value='/resources/js/home.js' />"></script>
		<script src="<c:url value='/resources/js/chat.js' />"></script>


	</body>

</html>