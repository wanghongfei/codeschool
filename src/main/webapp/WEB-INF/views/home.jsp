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
        
        <style>
			.fix-align {
				margin-top: 16px;
			}
		</style>	
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
				<div>
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#about" class="nav-link">关于</a></li>
							<li><a href="#sign-in" id="register-btn">登陆</a></li>
							<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
						</ul>
					</div>
				</div>
				<%-- <h:panelGroup layout="block" rendered="#{!loginBean.loggedIn}">
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<ui:remove>
								<li><a href="#benefits" class="nav-link">Benefits</a></li>
								<li><a href="#tour" class="nav-link">Tour</a></li>
							</ui:remove>
							<li><a href="#about" class="nav-link">关于</a></li>
							<li><a href="#sign-in" id="register-btn">登陆</a></li>
							<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
						</ul>
					</div>
				</h:panelGroup>
				
				<!-- 已登陆 -->
				<h:panelGroup layout="block" rendered="#{loginBean.loggedIn}" styleClass="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#about" class="nav-link">
								<h:outputText id="user-info" value="#{loginBean.getCurrentUser().getUsername()}, 积分: #{loginBean.getCurrentUser().getPoint()}" />
							</a>
						</li>
						<li>
							<h:form styleClass="fix-align">
								<h:commandLink action="#{loginBean.logout()}" value="退出登陆" styleClass="nav-link" />
							</h:form>
							<!-- <h:link value="退出登陆" outcome="#{loginBean.logout()}" styleClass="nav-link" /> -->	
						</li>
						<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
						
						<!-- <li>
							<img src="user-avatar.avatar" alt="" />
						</li>
						<li>
							<h:form id="form" enctype="multipart/form-data" prependId="false">
								<h:inputFile value="#{loginBean.avatar}" />
								<h:commandButton value="upload" action="#{loginBean.uploadAvatar()}" />
							</h:form>
						</li> -->
					</ul>
				</h:panelGroup> --%>
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
			<div class="col-md-4 col-sm-6 benefit">
				<a href="#" >
					<div class="benefit-ball">
						<span class="glyphicon glyphicon-search"></span>
					</div>
				</a>
				
				<h3>C++</h3>
				<p>C++</p>

			</div>

		</div>
		<!-- /.row -->

		<div class="sect-border"></div>
		</div>
		
		<!--登陆对话框-->
<%-- 		<h:panelGroup layout="block" rendered="#{!loginBean.loggedIn}">
			<div id="loginModal" class="modal fade">
				<h:panelGroup layout="block" id="login-modal" styleClass="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h1 class="text-center">用户登陆</h1>
						</div>
						<div class="modal-body">
							<h:form id="login-form" styleClass="form col-md-12 center-block">
								<div class="form-group">
									<h:outputLabel value="用户名:" >
										<h:inputText value="#{loginBean.username}" id="form-username" styleClass="form-control input-lg" />
									</h:outputLabel>
								</div>
								<div class="form-group">
									
									<h:inputSecret value="#{loginBean.password}" styleClass="form-control input-lg" placeholder="密码" />
								</div>
								<div class="form-group">
									
									<h:commandButton id="submit-form" value="登陆" action="#{loginBean.login()}" styleClass="btn btn-primary btn-lg btn-block" >
										<f:ajax execute="@form" render="error-msg" />
									</h:commandButton>
									<span class="pull-right"><a href="#">注册</a></span><span><a href="#">帮助</a></span>
								</div>
								
								<h:message for="login-form" id="error-msg" />
							</h:form>
						</div>
						<div class="modal-footer">
							<div class="col-md-12">
								<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
							</div>
						</div>
						
					</div>
				</h:panelGroup>
			</div>
		</h:panelGroup> --%>
		
		

		<footer>
			<div class="container clearfix">
				<p class="pull-left">Copyright 飞鸿软件工作室 2014</p>
				<p class="pull-right">Email: brucewhf@gmail.com</p>
			</div>
		</footer>
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="/spring-mvc/resources/js/jquery-1.9.1.js"></script>
		<script src="/spring-mvc/resources/js/bootstrap.min.js"></script>
		<!-- AdminLTE App -->
        <script src="/spring-mvc/resources/js/AdminLTE/app.js" type="text/javascript"></script>

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