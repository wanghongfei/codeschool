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


<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
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
	<!-- 上下边界填充 -->
	<div class="margin-elem"></div>
	<div class="margin-elem"></div>
	<hr>
	<div class="container">
		<div class="row">
			<div class="col-sm-10">
				<h1>Joeuser</h1>
			</div>
			<div class="col-sm-2">
				<a href="/users" class="pull-right"><img title="profile image"
					class="img-circle img-responsive"
					src="http://www.gravatar.com/avatar/28fd20ccec6865e2d5f0e1f4446eb7bf?s=100"></a>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<!--left col-->

				<ul class="list-group">
					<li class="list-group-item text-muted">Profile</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Joined</strong></span>
						2.13.2014</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Last
								seen</strong></span> Yesterday</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Real
								name</strong></span> Joseph Doe</li>

				</ul>

				<div class="panel panel-default">
					<div class="panel-heading">
						Website <i class="fa fa-link fa-1x"></i>
					</div>
					<div class="panel-body">
						<a href="http://bootply.com">bootply.com</a>
					</div>
				</div>


				<ul class="list-group">
					<li class="list-group-item text-muted">Activity <i
						class="fa fa-dashboard fa-1x"></i></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Shares</strong></span>
						125</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Likes</strong></span>
						13</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Posts</strong></span>
						37</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>Followers</strong></span>
						78</li>
				</ul>

				<div class="panel panel-default">
					<div class="panel-heading">Social Media</div>
					<div class="panel-body">
						<i class="fa fa-facebook fa-2x"></i> <i class="fa fa-github fa-2x"></i>
						<i class="fa fa-twitter fa-2x"></i> <i
							class="fa fa-pinterest fa-2x"></i> <i
							class="fa fa-google-plus fa-2x"></i>
					</div>
				</div>

			</div>
			<!--/col-3-->
			<div class="col-sm-9">

				<ul class="nav nav-tabs" id="myTab">
					<li class="active"><a href="#home" data-toggle="tab">Home</a></li>
					<li><a href="#messages" data-toggle="tab">Messages</a></li>
					<li><a href="#settings" data-toggle="tab">Settings</a></li>
				</ul>

				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>#</th>
										<th>Label 1</th>
										<th>Label 2</th>
										<th>Label 3</th>
										<th>Label</th>
										<th>Label</th>
										<th>Label</th>
									</tr>
								</thead>
								<tbody id="items">
									<tr>
										<td>1</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>2</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>3</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>4</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>5</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>6</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>7</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>8</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>9</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
									<tr>
										<td>10</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
										<td>Table cell</td>
									</tr>
								</tbody>
							</table>
							<hr>
							<div class="row">
								<div class="col-md-4 col-md-offset-4 text-center">
									<ul class="pagination" id="myPager"></ul>
								</div>
							</div>
						</div>
						<!--/table-resp-->

						<hr>

						<h4>Recent Activity</h4>

						<div class="table-responsive">
							<table class="table table-hover">

								<tbody>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> Today, 1:00 -
											Jeff Manzi liked your post.</td>
									</tr>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> Today, 12:23 -
											Mark Friendo liked and shared your post.</td>
									</tr>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> Today, 12:20 -
											You posted a new blog entry title "Why social media is".</td>
									</tr>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> Yesterday -
											Karen P. liked your post.</td>
									</tr>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> 2 Days Ago -
											Philip W. liked your post.</td>
									</tr>
									<tr>
										<td><i class="pull-right fa fa-edit"></i> 2 Days Ago -
											Jeff Manzi liked your post.</td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
					<!--/tab-pane-->
					<div class="tab-pane" id="messages">

						<h2></h2>

						<ul class="list-group">
							<li class="list-group-item text-muted">Inbox</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Here is your a link to the latest summary
									report from the..</a> 2.13.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Hi Joe, There has been a request on your
									account since that was..</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Nullam sapien massaortor. A lobortis
									vitae, condimentum justo...</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Thllam sapien massaortor. A lobortis
									vitae, condimentum justo...</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Wesm sapien massaortor. A lobortis vitae,
									condimentum justo...</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">For therepien massaortor. A lobortis
									vitae, condimentum justo...</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Also we, havesapien massaortor. A lobortis
									vitae, condimentum justo...</a> 2.11.2014</li>
							<li class="list-group-item text-right"><a href="#"
								class="pull-left">Swedish chef is assaortor. A lobortis
									vitae, condimentum justo...</a> 2.11.2014</li>

						</ul>

					</div>
					<!--/tab-pane-->
					<div class="tab-pane" id="settings">


						<hr>
						<form class="form" action="##" method="post" id="registrationForm">
							<div class="form-group">

								<div class="col-xs-6">
									<label for="first_name"><h4>First name</h4></label> <input
										type="text" class="form-control" name="first_name"
										id="first_name" placeholder="first name"
										title="enter your first name if any.">
								</div>
							</div>
							<div class="form-group">

								<div class="col-xs-6">
									<label for="last_name"><h4>Last name</h4></label> <input
										type="text" class="form-control" name="last_name"
										id="last_name" placeholder="last name"
										title="enter your last name if any.">
								</div>
							</div>

							<div class="form-group">

								<div class="col-xs-6">
									<label for="phone"><h4>Phone</h4></label> <input type="text"
										class="form-control" name="phone" id="phone"
										placeholder="enter phone"
										title="enter your phone number if any.">
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-6">
									<label for="mobile"><h4>Mobile</h4></label> <input type="text"
										class="form-control" name="mobile" id="mobile"
										placeholder="enter mobile number"
										title="enter your mobile number if any.">
								</div>
							</div>
							<div class="form-group">

								<div class="col-xs-6">
									<label for="email"><h4>Email</h4></label> <input type="email"
										class="form-control" name="email" id="email"
										placeholder="you@email.com" title="enter your email.">
								</div>
							</div>
							<div class="form-group">

								<div class="col-xs-6">
									<label for="email"><h4>Location</h4></label> <input
										type="email" class="form-control" id="location"
										placeholder="somewhere" title="enter a location">
								</div>
							</div>
							<div class="form-group">

								<div class="col-xs-6">
									<label for="password"><h4>Password</h4></label> <input
										type="password" class="form-control" name="password"
										id="password" placeholder="password"
										title="enter your password.">
								</div>
							</div>
							<div class="form-group">

								<div class="col-xs-6">
									<label for="password2"><h4>Verify</h4></label> <input
										type="password" class="form-control" name="password2"
										id="password2" placeholder="password2"
										title="enter your password2.">
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-12">
									<br>
									<button class="btn btn-lg btn-success" type="submit">
										<i class="glyphicon glyphicon-ok-sign"></i> Save
									</button>
									<button class="btn btn-lg" type="reset">
										<i class="glyphicon glyphicon-repeat"></i> Reset
									</button>
								</div>
							</div>
						</form>
					</div>

				</div>
				<!--/tab-pane-->
			</div>
			<!--/tab-content-->

		</div>
		<!--/col-9-->
	</div>
	<!--/row-->



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


	<script src="<c:url value='/resources/js/profile.js' />"></script>
	<script type="text/javascript">
		//<![CDATA[
		// 滚动效果
		$(".scroll-link").click(
				function(e) {
					e.preventDefault();
					var link = $(this);
					var href = link.attr("href");
					$("html,body").animate({
						scrollTop : $(href).offset().top - 80
					}, 500);
					link.closest(".navbar").find(
							".navbar-toggle:not(.collapsed)").click();
				});

		$("#register-btn").click(function(e) {
			$('#loginModal').modal('toggle');
		});

		//]]>
	</script>

</body>

</html>