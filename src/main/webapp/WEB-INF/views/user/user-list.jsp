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

<link href='<c:url value="/resources/css/AdminLTE.css" />'
	rel="stylesheet" />
<link
	href='<c:url value="/resources/css/jquery-ui-1.10.4.custom.min.css" />'
	rel="stylesheet" />


<link href='<c:url value="/resources/css/register.css" />' rel="stylesheet" />
<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />

<style>
.margin-elem {
	height: 60px;
}

</style>

</head>
<body id="body">

	<!--  顶部导航 starts -->
	<%@ include file="/WEB-INF/views/fragment/nav.jsp"%>
	<!--  顶部导航 ends -->


	<%-- 主体 --%>
	<!-- 上下边界填充 -->
	
	<hr>
	<div class="container">
			<div class="row">
			<div class="margin-elem"></div>
			<div class="margin-elem"></div>
			<div class="col-sm-8 col-sm-offset-2">
				<table class="table">
					<c:forEach items="${ memberList }" var="_m">
						<tr>
							<td><a href="/codeschool/user/${ _m.username }/profile">${ _m.username }</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>	
	</div>
	<!-- container -->

	<%@ include file="/WEB-INF/views/fragment/login.jsp"%>

	<%@ include file="/WEB-INF/views/fragment/footer.jsp"%>



	<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
	<script src="<c:url value='/resources/js/jquery-ui-1.10.4.custom.min.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.knob.js' />"></script>
	<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

	<%@ include file="/WEB-INF/views/fragment/chat.jsp"%>

	<script src="<c:url value='/resources/js/app.js' />"></script>
	<script src="<c:url value='/resources/js/login.js' />"></script>
	<script src="<c:url value='/resources/js/area.js' />"></script>
	<script src="<c:url value='/resources/js/select-city.js' />"></script>
	<script type="text/javascript">
		var username = "${ member.username }";
	</script>
	<script src="<c:url value='/resources/js/profile.js' />"></script>
	<script src="<c:url value='/resources/js/chat.js' />"></script>

</body>

</html>