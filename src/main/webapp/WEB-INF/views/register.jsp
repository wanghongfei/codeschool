<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8" />
<title>编程乐园</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link href='<c:url value="/resources/css/bootstrap.min.css" />'
	rel="stylesheet" />
<link href='<c:url value="/resources/css/strapped.css" />'
	rel="stylesheet" />
<!-- Theme style -->
<link href='<c:url value="/resources/css/AdminLTE.css" />'
	rel="stylesheet" />


<link href='<c:url value="/resources/css/register.css" />' rel="stylesheet" />

<style>
.margin-elem {
	height: 60px;
}
</style>
</head>
<body id="body">

	<!--  顶部导航 starts -->
	<nav class="navbar navbar-default navbar-inverse navbar-fixed-top"
		role="navigation">
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
						<li><a href="#about" class="nav-link"> <span
								id="user-info"> ${currentUser.username}, 积分:
									${currentUser.point} </span>
						</a></li>
						<li><a href="<c:url value='/logout' />" class="nav-link">退出登陆</a>
						</li>
						<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
					</ul>
				</div>
			</c:if>
			<!-- /.navbar-collapse -->
		</div>
	</nav>
	<!--  顶部导航 ends -->


	<%-- 主体 --%>
	<div class="container">
		<!-- 上下边界填充 -->
		<div class="margin-elem"></div>
		<div class="margin-elem"></div>
		<div class="row">
			<div
				class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
				<form role="form" action="<c:url value='/register' />" method="post">
					<h2>
						新用户注册 <small>轻松学编程~</small>
					</h2>
					<hr class="colorgraph">
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<input type="text" name="username" id="first_name"
									class="form-control input-lg" placeholder="用户名"
									tabindex="1">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<input type="text" name="nickname" id="last_name"
									class="form-control input-lg" placeholder="昵称"
									tabindex="2">
							</div>
						</div>
					</div>
					<!-- <div class="form-group">
						<input type="text" name="display_name" id="display_name"
							class="form-control input-lg" placeholder="Display Name"
							tabindex="3">
					</div> -->
					<div class="form-group">
						<input type="email" name="email" id="email"
							class="form-control input-lg" placeholder="邮箱"
							tabindex="4">
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<input type="password" name="password" id="password"
									class="form-control input-lg" placeholder="登陆密码"
									tabindex="5">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<input type="password" name="password_confirmation"
									id="password_confirmation" class="form-control input-lg"
									placeholder="确认密码" tabindex="6">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-4 col-sm-3 col-md-3">
							<span class="button-checkbox">
								<button type="button" class="btn" data-color="info" tabindex="7">I
									Agree</button> <input type="checkbox" name="t_and_c" id="t_and_c"
								class="hidden" value="1">
							</span>
						</div>
						<div class="col-xs-8 col-sm-9 col-md-9">
							By clicking <strong class="label label-primary">Register</strong>,
							you agree to the <a href="#" data-toggle="modal"
								data-target="#t_and_c_m">Terms and Conditions</a> set out by
							this site, including our Cookie Use.
						</div>
					</div>

					<hr class="colorgraph">
					<div class="row">
						<div class="col-xs-12 col-md-6">
							<input type="submit" value="注册"
								class="btn btn-primary btn-block btn-lg" tabindex="7">
						</div>
						<div class="col-xs-12 col-md-6">
							<a href="#" class="btn btn-success btn-block btn-lg">登陆</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	</div>


<%-- 	<div class="container" id="choose-course">
		<!-- 上下边界填充 -->
		<div class="margin-elem"></div>
		<div class="margin-elem"></div>

		<form id="form" action="<c:url value='/register' />" class="form" method="post">
				<div>
					<input type="text" name="username" placeholder="用户名" />
				</div>
				<div>
					<input type="password" name="password" placeholder="密码" />
				</div>
				<div>
					<input type="submit" value="提交" />
				</div>
			</form>

	</div> --%>

	<!--登陆对话框-->
	<c:if test="${currentUser == null }">
		<div>
			<div id="loginModal" class="modal fade">
				<div id="login-modal" class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">×</button>
							<h1 class="text-center">用户登陆</h1>
						</div>
						<div class="modal-body">
							<form action="<c:url value='/login' />" id="login-form"
								class="form col-md-12 center-block">
								<div class="form-group">
									<input type="text" name="username" id="form-username"
										placeholder="用户名" class="form-control input-lg" />
								</div>
								<div class="form-group">
									<input type="password" name="password" id="form-password"
										placeholder="密码" class="form-control input-lg" />
								</div>
								<div class="form-group">
									<input type="submit" value="登陆"
										class="btn btn-primary btn-lg btn-block" /> <span
										class="pull-right"><a href="#">注册</a></span><span><a
										href="#">帮助</a></span>
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
	<script src="<c:url value='/resources/js/register.js' />"></script>
	<script type="text/javascript">
		//<![CDATA[


		$("#register-btn").click(function(e) {
			$('#loginModal').modal('toggle');
		});

		//]]>
	</script>

</body>

</html>