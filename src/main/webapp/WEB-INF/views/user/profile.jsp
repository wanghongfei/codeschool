<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page session="false"%>

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
<link href='<c:url value="/resources/css/font-awesome.min.css" />'
	rel="stylesheet" />
<link
	href='<c:url value="/resources/css/jquery-ui-1.10.4.custom.min.css" />'
	rel="stylesheet" />


<link href='<c:url value="/resources/css/register.css" />'
	rel="stylesheet" />
<link href='<c:url value="/resources/css/app.css" />' rel="stylesheet" />
<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
<style>
.margin-elem {
	height: 60px;
}

.float-to-left {
	float: left;
}

.center {
	margin-left: auto;
	margin-right: auto;
	width: 25%;
}
</style>
</head>
<body id="body">

	<!--  顶部导航 starts -->
	<%@ include file="/WEB-INF/views/fragment/nav.jsp"%>
	<!--  顶部导航 ends -->


	<%-- 主体 --%>
	<!-- 上下边界填充 -->
	<div class="margin-elem"></div>
	<div class="margin-elem"></div>
	<hr>
	<div class="container">
		<div class="row">
			<div class="col-sm-10">
				<%-- 显示用户名 --%>
				<span class="profile-header">${ member.username}</span>
				<%-- 添加好友功能登陆可用 --%>
				<c:choose>
					<c:when test="${ !isFriend && currentUser != null }">
						<a href="${pageContext.request.contextPath}/user/${ member.username }/addFriend" class="tip" title="添加好友"><i class="fa fa-fw fa-users"></i></a>
					</c:when>
					<c:when test="${ isFriend && false == currentUser.username.equals(member.username) }">
						<p>TA是我的好友</p>
					</c:when>
				</c:choose>
				<p>
					<button class="btn" id="thumb-btn">
						赞一个 (<span id="thumb-amount">${ member.thumbAmount }</span>)
					</button>
				</p>
			</div>
			<div class="col-sm-2">
				<div class="float-to-left">
					<a href="/users" class="pull-right"> <img title="profile image"
						class="img-circle img-responsive"
						src="${pageContext.request.contextPath}/image.avatar?username=${ member.username }">
					</a>
				</div>
				<c:if test="${ currentUser != null && currentUser.username == member.username }">
					<form action="${pageContext.request.contextPath}/user/${ member.username }/uploadAvatar"
						enctype="multipart/form-data" method="post" class="float-to-left">
						<input type="file" name="avatarFile" /> <input type="submit"
							value="上传新头像" class="btn btn-sm" />
					</form>
				</c:if>

			</div>
		</div>
		<div class="row">
			<div class="col-sm-3">
				<!--left col-->

				<ul class="list-group profile-list">
					<li class="list-group-item text-muted">个人资料</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>注册时间</strong></span>
						${ member.registerTime }
					</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>生日</strong></span>
						${ member.birthday }
					</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>邮箱</strong></span>
						${ member.emailAddress }
					</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>QQ</strong></span>
						${ member.qqNumber }
					</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>所在地</strong></span>
						${ member.location }
					</li>
					<li class="list-group-item text-right">
						<span class="pull-left"><strong>积分排名</strong></span>
						第${ member.rank }名
					</li>

				</ul>

				<div class="panel panel-default">
					<div class="panel-heading">
						他的好友 <i class="fa fa-link fa-1x"></i>
					</div>
					<div class="panel-body">
						<c:forEach items="${ member.friendList }" var="_f">
							<a href="${pageContext.request.contextPath}/user/${ _f.username }/profile">${ _f.username }
							</a>
							<a class="chat-link tip" data-user="${ _f.username }"
								href="${pageContext.request.contextPath}/chat/send/${ _f.username }" title="跟TA聊天"><i class="fa fa-fw fa-comments-o"></i></a>
						</c:forEach>
					</div>
				</div>

				<%-- 积分榜 --%>
				<ul class="list-group">
					<li class="list-group-item text-muted">积分英雄榜 <i
						class="fa fa-dashboard fa-1x"></i>
					</li>

					<c:forEach items="${ rankList }" var="_r">
						<li class="list-group-item text-right">
							<span class="pull-left"> <strong><a	href="${pageContext.request.contextPath}/user/${ _r.username }/profile">${ _r.username }</a></strong>
							<c:if test="${ !currentUser.hasFriend(_r.username) }">
								<a href="${pageContext.request.contextPath}/user/${ _r.username }/addFriend" class="tip" title="添加好友"><i class="fa fa-fw fa-users"></i></a>
							</c:if>
							<c:if test="${ currentUser.hasFriend(_r.username) }">
								<a class="chat-link tip" data-user="${ _r.username }" href="${pageContext.request.contextPath}/chat/send/${ _r.username }" title="跟TA聊天"><i class="fa fa-fw fa-comments-o"></i></a>
							</c:if>
						</span> ${ _r.point }</li>
					</c:forEach>

				</ul>

				<%--
				<div class="panel panel-default">
					<div class="panel-heading">Social Media</div>
					<div class="panel-body">
						<i class="fa fa-facebook fa-2x"></i> <i class="fa fa-github fa-2x"></i>
						<i class="fa fa-twitter fa-2x"></i> <i
							class="fa fa-pinterest fa-2x"></i> <i
							class="fa fa-google-plus fa-2x"></i>
					</div>
				</div>
				 --%>

			</div>
			<!--/col-3-->
			<div class="col-sm-9">

				<ul class="nav nav-tabs" id="myTab">
					<li class="active"><a href="#home" data-toggle="tab">正在学习的课程</a></li>
					<li><a href="#settings" data-toggle="tab">未学习的课程</a></li>
					<li><a href="#profile" data-toggle="tab">个人资料</a></li>
				</ul>


				<%-- 正在学习的课程 --%>
				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<div class="table-responsive">
							<c:choose>
								<c:when test="${ false == startedWrapperList.isEmpty() }">
									<c:forEach items="${ startedWrapperList }" var="_w">
										<a href="${pageContext.request.contextPath}/courses/list?courseId=${ _w.courseId }">
											<div class="col-md-3 col-sm-6 col-xs-6 text-center">
												<input type="text" class="knob" readonly="readonly"
													value="${ _w.progress }" data-width="180" data-height="180"
													data-fgColor="#3c8dbc" />
												<div class="knob-label">${ _w.courseName }</div>
											</div>
										</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<h3>还没有正在学习的课程</h3>
								</c:otherwise>
							</c:choose>

							<hr />
							<div class="row">
								<div class="col-md-4 col-md-offset-4 text-center"></div>
							</div>
						</div>
						<!--/table-resp-->

					</div>



					<%-- 还未学习的课程 --%>
					<div class="tab-pane" id="settings">
						<div class="table-responsive">
							<c:choose>
								<c:when test="${ false == unstartedWrapperList.isEmpty() }">
									<c:forEach items="${ unstartedWrapperList }" var="_w">
										<a href="${pageContext.request.contextPath}/courses/list?courseId=${ _w.courseId }">
											<div class="col-md-3 col-sm-6 col-xs-6 text-center">
												<input type="text" class="knob" readonly="readonly"
													value="${ _w.progress }" data-width="180" data-height="180"
													data-fgColor="#3c8dbc" />
												<div class="knob-label">${ _w.courseName }</div>
											</div>
										</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<h3>恭喜,你已经学遍了本站课程!</h3>
								</c:otherwise>
							</c:choose>

							<hr />
							<div class="row">
								<div class="col-md-4 col-md-offset-4 text-center"></div>
							</div>
						</div>

					</div>

					<%-- 个人资料 --%>
					<div class="tab-pane" id="profile">
						<form role="form"
							action="${pageContext.request.contextPath}/user/${ member.username }/update"
							method="post" accept-charset="UTF-8"
							id="form">
							<hr class="colorgraph">
							<div class="row">
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>用户名</h4>
										<input readonly="readonly" type="text" name="username"
											id="first_name" class="form-control"
											value="${ member.username }" placeholder="用户名" tabindex="1">
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>昵称</h4>
										<c:if test="${ currentUser != null && currentUser.username == member.username }">
											<input type="text" name="nickName" id="nickName"
												class="form-control" value="${ member.nickName }"
												placeholder="昵称" tabindex="2">
										</c:if>
										<c:if test="${ currentUser == null || currentUser.username != member.username }">
											<input type="text" name="nickName" id="nickName"
												class="form-control" readonly="readonly"
												value="${ member.nickName }" placeholder="昵称" tabindex="2">
										</c:if>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>邮箱</h4>
										<c:if test="${ currentUser != null && currentUser.username == member.username }">
											<input type="email" name="email" id="email"
												class="form-control" value="${ member.emailAddress }"
												placeholder="邮箱" tabindex="4">
										</c:if>
										<c:if test="${ currentUser == null || currentUser.username != member.username }">
											<input type="email" name="email" id="email"
												class="form-control" readonly="readonly"
												value="${ member.emailAddress }" placeholder="邮箱"
												tabindex="4">
										</c:if>

									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>生日</h4>
										<c:if test="${ currentUser != null && currentUser.username == member.username }">
											<input type="text" name="birthday" id="birthday"
												class="form-control date" value="${ member.birthday }"
												placeholder="生日" tabindex="4">
										</c:if>
										<c:if test="${ currentUser == null || currentUser.username != member.username }">
											<input type="text" name="birthday" id="birthday"
												class="form-control" readonly="readonly"
												value="${ member.birthday }" placeholder="生日" tabindex="4">
										</c:if>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>QQ</h4>
										<c:if test="${ currentUser != null && currentUser.username == member.username }">
											<input type="text" name="qq" id="qq" class="form-control"
												value="${ member.qqNumber }" placeholder="QQ" tabindex="5">
										</c:if>
										<c:if test="${ currentUser == null || currentUser.username != member.username }">
											<input type="text" name="qq" id="qq" class="form-control"
												value="${ member.qqNumber }" readonly="readonly"
												placeholder="QQ" tabindex="5">
										</c:if>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="form-group">
										<h4>地区</h4>
										<div class="select-city">
											<input type="text" id="select-city" />
										</div>
									</div>
								</div>
							</div>

							<hr class="colorgraph">
							<c:if test="${ currentUser != null }">
								<div class="row">
									<div class="col-xs-12 col-md-1">
										<input type="submit" value="保存"
											class="btn btn-primary btn-block btn-sm" tabindex="7">
									</div>
									<span id="error-msg"></span>
								</div>
							</c:if>
						</form>
					</div>

				</div>
				<!--/tab-content-->

			</div>


			<%-- 好友动态 --%>
			<div class="col-sm-9">
				<%-- 选项卡标题 --%>
				<ul class="nav nav-tabs margin-top-20" id="activities-tab">
					<li class="active"><a href="#friends-activities"
						data-toggle="tab">好友动态</a></li>
					<li><a href="#my-activities" data-toggle="tab">${ member.username }的动态</a></li>
				</ul>

				<%-- 选项卡内容 --%>
				<div class="tab-content">
					<%-- 好友活动 --%>
					<div class="tab-pane active" id="friends-activities">
						<div class="table-responsive">
							<table class="table table-hover">
								<tbody>
									<c:forEach items="${ activityList }" var="_a">
										<tr>
											<td><i class="pull-right fa fa-edit"></i> 用户<a
												href="${pageContext.request.contextPath}/user/${ _a.member.username }/profile">${ _a.member.username }</a>
												${ _a.time } - ${ _a.content }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

						</div>
					</div>

					<%-- 我的活动 --%>
					<div class="tab-pane" id="my-activities">
						<div class="table-responsive">
							<div class="table-responsive">
								<table class="table table-hover">
									<tbody>
										<c:forEach items="${ myActivityList }" var="_r">
											<tr>
												<td><i class="pull-right fa fa-edit"></i> ${ _r.time }
													- ${ _r.content }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- container -->

	<%@ include file="/WEB-INF/views/fragment/login.jsp"%>

	<%@ include file="/WEB-INF/views/fragment/footer.jsp"%>



	<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
	<script
		src="<c:url value='/resources/js/jquery-ui-1.10.4.custom.min.js' />"></script>
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