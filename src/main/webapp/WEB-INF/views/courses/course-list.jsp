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
		
		
		<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
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
		<%@ include file="/WEB-INF/views/fragment/nav.jsp" %>	
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
											<a href="<c:url value='/courses/start'><c:param name='sectionId' value='${ _s.id }' /><c:param name='courseId' value='${ param.courseId }' /></c:url>">
												${ _s.sectionName }
											</a>
										</td>
										<td>
											<a href="<c:url value='/courses/start'><c:param name='sectionId' value='${ _s.id }' /><c:param name='courseId' value='${ param.courseId }' /></c:url>">
												${ _s.sectionDescription }
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
		
		
		<%-- 登陆 --%>
		<%@ include file="/WEB-INF/views/fragment/login.jsp" %>	
		
		
		
		<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>

		
		
		<script src='<c:url value="/resources/js/jquery.js" />'></script>
		<script src='<c:url value="/resources/js/bootstrap.min.js" />'></script>
		<!-- AdminLTE App -->
		<script src='<c:url value="/resources/js/AdminLTE/app.js" />'></script>

		<%@ include file="/WEB-INF/views/fragment/chat.jsp" %>

		<script src="<c:url value='/resources/js/app.js' />"></script>
		<script src="<c:url value='/resources/js/login.js' />"></script>
		<script src="<c:url value='/resources/js/chat.js' />"></script>
		<script type="text/javascript">
		    
	    </script>

	</body>

</html>