<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

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
        
        	
		<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
	</head>
	<body id="body">

		<!--  顶部导航 starts -->
		<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container" id="top-nav-bar">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-ex1-collapse">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand nav-link scroll-link" href="#top">编程乐园</a>
				</div>
				<!-- /.navbar-header -->
	
	
				<!-- 未登陆 -->
				<c:if test="${currentUser == null }">
					<div>
						<div class="collapse navbar-collapse navbar-ex1-collapse">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="#about" class="nav-link">关于</a></li>
								<li><a href="#sign-in" id="register-btn">登陆</a></li>
								<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
							</ul>
						</div>
					</div>
				</c:if>
				
				<!-- 已登陆 -->
				<c:if test="${currentUser != null }">
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a href="#about" class="nav-link">
									<span id="user-info">
										${currentUser.username}, 积分: ${currentUser.point}
									</span>
								</a>
							</li>
							<li>
 								<a href="<c:url value='/logout' />" class="nav-link">退出登陆</a>
							</li>
							<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
						</ul>
					</div>
				</c:if>
				<!-- /.navbar-collapse -->
			</div>
		</nav>
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
					<p>${ _c.courseDescription }</p>
				</div>
			</c:forEach>

		</div>
		<!-- /.row -->

		<div class="sect-border"></div>
		</div>
		
		<!--登陆对话框-->
		<c:if test="${currentUser == null }">
			<div>
				<div id="loginModal" class="modal fade">
					<div id="login-modal" class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								<h1 class="text-center">用户登陆</h1>
							</div>
							<div class="modal-body">
								<form action="<c:url value='/login' />" id="login-form" class="form col-md-12 center-block">
									<div class="form-group">
										<input type="text" name="username" id="form-username" placeholder="用户名" class="form-control input-lg" />
									</div>
									<div class="form-group">
										<input type="password" name="password" id="form-password" placeholder="密码" class="form-control input-lg" />
									</div>
									<div class="form-group">
										<input type="submit" value="登陆" class="btn btn-primary btn-lg btn-block" />	
										<span class="pull-right"><a href="#">注册</a></span><span><a href="#">帮助</a></span>
									</div>
									
									<div id="error-msg" class="hidden"></div>
								</form>
							</div>
							<div class="modal-footer">
								<div class="col-md-12">
									<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</c:if>
		
		

		<footer>
			<div class="container clearfix">
				<p class="pull-left">Copyright 飞鸿软件工作室 2014</p>
				<p class="pull-right">Email: brucewhf@gmail.com</p>
			</div>
		</footer>
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>


		<script src="<c:url value='/resources/js/login.js' />"></script>
		<script type="text/javascript">
		//<![CDATA[
			// 滚动效果
		    $(".scroll-link").click(function(e) {
				e.preventDefault();
				var link = $(this);
				var href = link.attr("href");
				$("html,body").animate({scrollTop: $(href).offset().top - 80}, 500);
				link.closest(".navbar").find(".navbar-toggle:not(.collapsed)").click();
			});

   			$("#register-btn").click(function(e) {
   				$('#loginModal').modal('toggle');
			});
   			
   		//]]>
	    </script>

	</body>

</html>