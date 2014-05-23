<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<title>编程乐园</title>
	<meta name="viewport" content="width=device-width,initial-scale=1.0" />
	<link href='<c:url value="/resources/css/bootstrap.min.css" />'	rel="stylesheet" />
	<link href='<c:url value="/resources/css/strapped.css" />'	rel="stylesheet" />
	<!-- Theme style -->
	<link href='<c:url value="/resources/css/AdminLTE.css" />'	rel="stylesheet" />
	
	
	<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
	<link href='<c:url value="/resources/css/register.css" />' rel="stylesheet" />
	
	<style>
		.margin-elem {
			height: 60px;
		}
	</style>
</head>
<body id="body">

	<!--  顶部导航 starts -->
	<%@ include file="/WEB-INF/views/fragment/nav.jsp" %>
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
								<h4>登陆名</h4>
								<input type="text" name="username" id="first_name"
									class="form-control input-lg" placeholder="4 ~ 15个字符
									tabindex="1">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<h4>昵称</h4>
								<input type="text" name="nickname" id="last_name"
									class="form-control input-lg" placeholder="2 ~ 15个字符"
									tabindex="2">
							</div>
						</div>
					</div>
					<div class="form-group">
						<h4>邮箱</h4>
						<input type="email" name="email" id="email"
							class="form-control input-lg" placeholder="可做为用户名进行登陆"
							tabindex="4">
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
							<h4>登陆密码</h4>
								<input type="password" name="password" id="password"
									class="form-control input-lg" placeholder="8 ~ 20个字符"
									tabindex="5">
							</div>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-6">
							<div class="form-group">
								<h4>确认密码</h4>
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
					</div>

					<hr class="colorgraph">
					<div class="row">
						<div class="col-xs-12 col-md-6">
							<input type="submit" value="注册用户"
								class="btn btn-primary btn-block btn-lg" tabindex="7">
						</div>
						<div class="col-xs-12 col-md-6">
							<a href="#" class="btn btn-success btn-block btn-lg" id="register">已有账号，马上登陆</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	</div>



	<%-- 登陆 --%>
	<%@ include file="/WEB-INF/views/fragment/login.jsp" %>		
		
		

	<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>	



	<!-- <ui:insert name="javascript" />-->
	<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
	<!-- AdminLTE App -->
	<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>


	<script src="<c:url value='/resources/js/app.js' />"></script>
	<script src="<c:url value='/resources/js/login.js' />"></script>
	<script src="<c:url value='/resources/js/register.js' />"></script>
	<script type="text/javascript">
	</script>

</body>

</html>