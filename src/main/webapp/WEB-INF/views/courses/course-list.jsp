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
						<h3>课程名</h3>
						<p>说明</p>
					</div>
				</div>
				<div class="margin-elem"></div>
		
				<div class="row">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th class="centralize-text" colspan="2">章节名</th>
							</tr>
						</thead>
						
						<tbody>
							<!-- 遍历小节  -->
							<tr>									
								<td class="table-section">
									<a href="#">
										小节名	
									</a>
								</td>
								<td>
									<a href="#">
										小节内容	
									</a>
								</td>									
							</tr>
						</tbody>
					</table>
				</div>
			</div>	
		</div>
		
		
		

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

		<script type="text/javascript">
		    

   			$("#register-btn").click(function(e) {
   				$('#loginModal').modal('toggle');
			});

	    </script>

	</body>

</html>