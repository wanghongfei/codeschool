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
		<link href="<c:url value="/resources/css/app.css" />" rel="stylesheet" type="text/css" />

		
	
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
			<![endif]-->	
			
		<style>
			.error-msg {
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
				        <li><a href="#"><i class="fa fa-dashboard"></i> 修改小节</a></li>
				        <!-- <li class="active">Blank page</li> -->
				    </ol>
				</section>
				
				<!-- Main content -->
		        <section class="content">
				
				<div>
					注册用户: ${ memberAmount }
				</div>	
				<div>
					当前在线: ${ onlineMemberList.size() }
				</div>	
				<table class="table table-striped">
					<tr>
						<th>用户名</th>
						<th>积分</th>
					</tr>
					<c:forEach items="${ onlineMemberList }" var="_m">
						<tr>
							<td>
								<a href="${pageContext.request.contextPath}/user/${ _m.username }/profile" target="_blank">${ _m.username }</a>
							</td>
							<td>${ _m.point }</td>
						</tr>
					</c:forEach>
				</table>
					
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>
		<script src="<c:url value='/resources/js/app.js' />"></script>

		<script src='<c:url value="/resources/js/code-editor/ace.js" />'></script>
		<script type="text/javascript">
	    </script>
		<script src="<c:url value='/resources/js/console-update-section.js' />"></script>

	</body>

</html>

