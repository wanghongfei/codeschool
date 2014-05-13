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
        <style>
			.margin-elem {
				height: 60px;
			}
			
			.centralize-text {
				text-align: center;
			}
			
			.table-section {
				width: 80px;
			}
			
			.centralize {
				margin-left: auto;
				margin-right: auto;
			}
			
			.magnify-em {
				margin: 2em 0;
			}
			
			/* 修复在li中嵌入form而错位的问题 */
 			.fix-align {
 				margin-top: 15px;
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
					<a class="navbar-brand nav-link scroll-link" href="<c:url value='/' />">编程乐园</a>
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
			</div>
		</nav>
		<!--  顶部导航 ends -->


		<!-- 页面主体 -->
		<div class="container" id="choose-course">
			<div class="row">
				<!-- 上下边界填充 -->
				<div class="margin-elem"></div>
				<div class="margin-elem"></div>
				
				<!-- 课程大图 -->
				<div class="col-md-offset-5">
					<div class="col-md-4 col-sm-6 benefit magnify-em ">
						<div class="benefit-ball">
							<!-- <span class="glyphicon glyphicon-home"></span> -->
							<span class="glyphicon glyphicon-search"></span>
						</div>
						<h3>${ course.courseName }</h3>
						<p>${ course.courseDescription }</p>
					</div>
				</div>
				<div class="margin-elem"></div>
		
				<div class="row">
					<c:forEach items="${ chapterList }" var="_c">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th class="centralize-text" colspan="2">${ _c.chapterName }</th>
								</tr>
							</thead>
						
							<tbody>
								<!-- 遍历小节  -->
								<c:forEach items="${ _c.courseSections }" var="_s">
									<tr>									
										<td class="table-section">
											<a href="<c:url value='/courses/start'><c:param name='sectionId' value='${ _s.id }' /></c:url>">
												${ _s.sectionName }
											</a>
										</td>
										<td>
											<a href="<c:url value='/courses/start'><c:param name='sectionId' value='${ _s.id }' /></c:url>">
												${ _s.courseContent }
											</a>
											<p>已有 ${ _s.finishedMemberAmount } 人完成了该小节</p>
										</td>									
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:forEach>
					
					
				</div>
			</div>	
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
		
		
		
		<script src='<c:url value="/resources/js/jquery.js" />'></script>
		<script src='<c:url value="/resources/js/bootstrap.min.js" />'></script>
		<!-- AdminLTE App -->
		<script src='<c:url value="/resources/js/AdminLTE/app.js" />'></script>

		<script src="<c:url value='/resources/js/login.js' />"></script>
		<script type="text/javascript">
		    

   			$("#register-btn").click(function(e) {
   				$('#loginModal').modal('toggle');
			});

	    </script>

	</body>

</html>