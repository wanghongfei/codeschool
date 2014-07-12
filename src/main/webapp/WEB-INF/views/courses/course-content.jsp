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
	
	
	<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
	<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
	<link href='<c:url value="/resources/css/message-board.css" />' rel="stylesheet" />
	<style>
		.margin-elem {
			height: 59px;
		}
		
		.scroll {
			overflow-y: scroll;
		}
		
		.box-header {
			color: #fff;
			background: #3c8dbc;
			background-color: #3c8dbc;
		}
		
		.result-container {
			position: absolute;
			top: 130px;
			right: 210px;
			width: 300px;
			height: 300px;
			border-radius: 6px;
			background-color: #232c31;
			z-index: 10;
		}
		
		#result-preview {
			width: 90%;
			height: 80%;
			border-radius: 6px;
			background-color: #FFFFCC;
			margin-left: 5%;
			margin-top: 10px;
		}
		
		.hidden {
			display: none;
		}
		
		/* 左侧教程区 */
		#course-section {
			height: 600px;
			overflow:scroll;
		}
		
		.text-white {
			color: white;
		}
		
		
		.float-left {
			float: left;
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
		
		.my-timeline {
			position: absolute;
			left: 10px;
			top: 120px;
		}
		
		.my-timeline-icon {
			left: 32px;
		}
		
		/* 为了适应时间轴的添加，需微调主体元素 */
		#my-container {
			margin-left: 15%;
		}
		
		.error-msg {
			padding-top: 5px;
			padding-left: 10px;
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
			<!-- 上边界填充 -->
			<div class="margin-elem"></div>
			<div class="margin-elem"></div>



			<!-- 左侧教程 -->
			<div class="col-md-3">
				<div id="course-section" class="box box-primary">
					<div class="box-header" data-toggle="tooltip"
						title="Header tooltip">
						<!-- 小节标题 -->
						<h3 id="section-name" class="box-title text-white">${ section.sectionName }
						</h3>
					</div>
					<div class="box-body">
						<!-- 小节内容 -->
						<p id="section-content">${ section.courseContent }</p>
					</div>
				</div>

				<button class="btn btn-primary" style="float: left">上一节</button>
				<button class="btn btn-primary" style="float: right">下一节</button>

			</div>
			<!-- /.col -->


			<!-- 右侧代码区 -->
			<div class="col-md-8">
					
				<%-- 代码编辑区 tabs --%>
				<ul class="nav nav-tabs" id="myTab">
					<c:forEach items="${ languageList }" var="_l">
						<li><a href="#tab-${ _l }" data-id="editor-${ _l }" data-lan="${ _l }" data-toggle="tab">${ _l }</a></li>
					</c:forEach>
				</ul>
				
				
				
				<div class="tab-content">
					<c:forEach items="${ languageList }" var="_l">
						<div class="tab-pane" id="tab-${ _l }">
							<div class="table-responsive" >
 								<pre id="editor-${ _l }" class="code-editor"></pre>
    	    	        	</div>
						</div>
					</c:forEach>

				</div>


				<!-- 用户登陆才能显示此按钮 -->
				<c:if test="${ currentUser != null }">
					<c:if test="${ languageList[0] == 'javascript' }">
						<button class="btn btn-primary code-javascript" style="float: left" >提交</button>
					</c:if>
					<c:if test="${ languageList[0] == 'html' }">
						<button class="btn btn-primary" style="float: left"	id="submit-code">提交</button>
					</c:if>
				</c:if>


				<button class="btn btn-primary" style="float: right">重置</button>

				<div id="msg" class="float-left error-msg"></div>

			</div>

		</div>
		<!-- row ends -->
		
		<%-- message board --%>
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="msg-board">
					<!-- header starts -->
					<div class="msg-board-header">
						<div class="msg-board-header-left float-to-left">
							<span>我要留言(152)</span>
						</div>
						<div class="msg-board-header-right float-to-right">
							<span style="margin-right: 15px;">第${ param.commentPage }页</span>
							<c:if test="${ null != previousPage }">
								<span><a href="/codeschool/courses/start?sectionId=${ param.sectionId }&courseId=${ param.courseId }&commentPage=${ previousPage }">上一页</a></span>
							</c:if>
							
							<c:if test="${ null != nextPage }">
								<span><a href="/codeschool/courses/start?sectionId=${ param.sectionId }&courseId=${ param.courseId }&commentPage=${ nextPage }">下一页</a></span>
							</c:if>
						</div>
						<div style="clear:both"></div>
					</div>
					<!-- header ends -->
						
						<c:forEach items="${ commentList }" var="_c">
							<div class="msg-board-content">
								<hr />
								<div class="msg-board-left-main float-to-left">
									<img src="/codeschool/image.avatar?username=${ _c.member.username }" />
									<div>${ _c.member.username }</div>
									<div>第1楼</div>
								</div>
							
								<div class="msg-board-right-main float-to-left ">
									<div class="msg-board-text">
										${ _c.msgContent }
									</div>
									<div class="msg-board-action">
										<span>${ _c.msgTime }</span>
										<span><a href="/codeschool/courses/start/comment/reply">回复</a></span>
										<span><a href="#">编辑</a></span>
									</div>
									
									<!-- reply starts -->
									<%-- 判断有没有回复 --%>
									<%-- <c:if test="${ 1 == _c.getHasReply() }"> --%>
										<%-- <c:forEach items="${ _c.getReplyList() }" var="_r"> --%>
											<div class="msg-reply">
												<hr />
												
												<div class="msg-board-left-main float-to-left">
													<img src="/codeschool/image.avatar?username=admin" />
													<div>用户名</div>
												</div>
												
												<div class="msg-board-right-main float-to-left ">
												<div class="msg-board-text">
													<%-- ${ _r.msgContent } --%>
													hello
												</div>
												<div class="msg-board-action">
													<span>2014-3-12<%-- ${ _r.msgTime } --%></span>
													<span><a href="#">编辑</a></span>
												</div>
												
												<!-- reply form -->
												<form id="reply-form" action="">
													<div class="input-group" style="width:400px; margin-top:5px">
														<input name="reply-msg" type="text" class="form-control input-sm" placeholder="在此回复" />
														<span class="input-group-btn">
															<button class="btn btn-warning btn-sm" id="btn-send">回复</button>
														</span>
													</div>
												</form>
												</div>
											</div>
										<%-- </c:forEach> --%>
									<%-- </c:if> --%>
									<!-- reply ends -->
								</div>
									
								<div style="clear:both"></div>
							</div> <!-- content ends -->	
						</c:forEach>
						
					</div>
				</div> <!-- msg-borad ends -->
			</div> <!-- col ends -->
			
			<!-- msg form starts -->
    		<div class="row">
				<div class="col-sm-7 col-md-7 col-md-offset-2 msg-form">
     		       <div class="panel panel-default">
      		          <div class="panel-body">                
     		               <form id="form" accept-charset="UTF-8" action="<c:url value='/courses/start/comment' />" method="POST">
      		                  <textarea class="form-control counted" name="message" placeholder="输入评论" rows="5" style="margin-bottom:10px;"></textarea>
      		                  <h6 class="pull-right" id="counter">320 characters remaining</h6>
      		                  <button class="btn btn-info" type="submit">发表</button>
      		              </form>
      		          </div>
      		          <div id="err-msg"></div>
      		      </div>
      		  	</div>
			</div>
			<!-- msg form ends -->
			
		</div>
	</div>




	<!-- 这里是绝对定位的元素 -->

	<!-- 代码预览窗口 -->
	<div class="result-container">
		<iframe id="result-preview"></iframe>
	</div>

	<!-- 时间轴 -->
	<div class="my-timeline">
		<ul class="timeline">

			<!-- 章节名 -->
			<li class="time-label"><span class="bg-red"> ${ section.courseChapter.chapterName }
			</span></li>

			<!-- 小节 -->
			<c:forEach items="${ section.courseChapter.courseSections }" var="_s">
				<li><i class="fa fa-envelope bg-blue my-timeline-icon"></i>
					<div class="timeline-item">
						<div class="timeline-body">
							<%-- 点击小节点后用ajax更新教程区内容 --%>
							<%-- 使用 html5 的 data-* 保存小节id --%>
							<a class="change-section-link" data-id="${ _s.id }"
								href="<c:url value='/courses/start/changeSection'><c:param name='sectionId' value='${ _s.id }' /></c:url>">
								${ _s.sectionName } </a>
						</div>
					</div></li>
			</c:forEach>

		</ul>
	</div>


	<%-- 登陆 --%>
	<%@ include file="/WEB-INF/views/fragment/login.jsp" %>	
		
		
		
	<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>	


	<script src='<c:url value="/resources/js/jquery.js" />'></script>
	<script src='<c:url value="/resources/js/jquery-ui-1.10.4.custom.min.js" />'></script>
	<script src='<c:url value="/resources/js/bootstrap.min.js" />'></script>
	<script src='<c:url value="/resources/js/AdminLTE/app.js" />'></script>
	<script src='<c:url value="/resources/js/char-counter.js" />'></script>

	<%@ include file="/WEB-INF/views/fragment/chat.jsp" %>	

	<script src='<c:url value="/resources/js/code-editor/ace.js" />'></script>

	<script src="<c:url value='/resources/js/app.js' />"></script>
	<script src="<c:url value='/resources/js/login.js' />"></script>
	<script type="text/javascript">
		var currentSectionId = "${section.id}";
		var initialCode = "${ section.initialCode }";
	</script>
	<script src="<c:url value='/resources/js/course-content.js' />"></script>
	<script src="<c:url value='/resources/js/chat.js' />"></script>


</body>

</html>