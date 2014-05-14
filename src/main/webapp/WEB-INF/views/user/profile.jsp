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
	<%@ include file="/WEB-INF/views/fragment/nav.jsp" %>	
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
				<h1>${ member.username}</h1>
				<%-- 添加好友功能登陆可用 --%>
				<c:if test="${ !isFriend && currentUser != null }">
					<p><a href="/codeschool/user/${ member.username }/addFriend" >添加好友</a></p>
				</c:if>
				<c:if test="${ isFriend }">
					<p>TA是我的好友</p>
				</c:if>
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
					<li class="list-group-item text-muted">个人资料</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>注册时间</strong></span>
						2.13.2014</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>最后一次登陆
						</strong></span> Yesterday</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong>积分排名
						</strong></span> 第${ member.rank }名</li>

				</ul>

				<div class="panel panel-default">
					<div class="panel-heading">
						个人主页 <i class="fa fa-link fa-1x"></i>
					</div>
					<div class="panel-body">
						<a href="http://bootply.com">bootply.com</a>
					</div>
				</div>

				<ul class="list-group">
					<li class="list-group-item text-muted">最近活动 <i
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
					<li class="active"><a href="#home" data-toggle="tab">正在学习的课程</a></li>
					<li><a href="#messages" data-toggle="tab">已经完成的课程</a></li>
					<li><a href="#settings" data-toggle="tab">未学习的课程</a></li>
				</ul>
				
				

				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<div class="table-responsive" >
							<c:forEach items="${ wrapperList }" var="_w">
								<div class="col-md-3 col-sm-6 col-xs-6 text-center">
    	      			      		<input type="text" class="knob" readonly="readonly" value="${ _w.progress }" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
        	    			  	 	<div class="knob-label">${ _w.courseName }</div>
            	    			</div>
							</c:forEach>
						
							<!--
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          			      		<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
            			  	 	<div class="knob-label">HTML</div>
                			</div>
							jquery knob
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          			      		<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
            			  	 	<div class="knob-label">JavaScript</div>
                			</div>
							jquery knob
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          			      		<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
            			  	 	<div class="knob-label">C++</div>
                			</div> -->
                				
                				
                				
					 		<hr>
							<div class="row">
								<div class="col-md-4 col-md-offset-4 text-center">
								</div>
							</div>
						</div>
						<!--/table-resp-->

						<hr>

						<h4>Recent Activity</h4>

						<%-- 最近活动 --%>
						<div class="table-responsive">
							<table class="table table-hover">

								<tbody>
									<c:forEach items="${ member.recentActivity }" var="_r">
										<tr>
											<td>
												<i class="pull-right fa fa-edit"></i>
												${ _r.occurTime } - ${ _r.content }
											</td>
										</tr>
									</c:forEach>
									<!-- <tr>
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
									</tr> -->
								</tbody>
							</table>
						</div>

					</div>
					
					
					<!--/tab-pane-->
					<div class="tab-pane" id="messages">
						<div class="table-responsive" >
							<h2></h2>
							<!-- jquery knob -->
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          			     	 	<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
            				 	<div class="knob-label">C++</div>
              		  		</div>
                		</div>
					</div>
					
					
					<!--/tab-pane-->
					<div class="tab-pane" id="settings">
						<div class="table-responsive" >
							<h2></h2>
							<!-- jquery knob -->
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          				      	<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
          	  			 		<div class="knob-label">C++</div>
           		     		</div>
             		   			<!-- jquery knob -->
							<div class="col-md-3 col-sm-6 col-xs-6 text-center">
          				      	<input type="text" class="knob" readonly="readonly" value="30" data-width="180" data-height="180" data-fgColor="#3c8dbc"/>
            			 		<div class="knob-label">C++</div>
              		  		</div>
                		</div>
						
					</div>

				</div>
				<!--/tab-pane-->
			</div>
			<!--/tab-content-->

		</div>
	</div> <!-- container -->

	<%@ include file="/WEB-INF/views/fragment/login.jsp" %>	

	<%@ include file="/WEB-INF/views/fragment/footer.jsp" %>	



	<!-- <ui:insert name="javascript" />-->
	<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.knob.js' />"></script>
	<!-- AdminLTE App -->
	<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

	<script src="<c:url value='/resources/js/app.js' />"></script>
	<script src="<c:url value='/resources/js/login.js' />"></script>
	<script src="<c:url value='/resources/js/profile.js' />"></script>
	<script type="text/javascript">
		//<![CDATA[
		$("#register-btn").click(function(e) {
			$('#loginModal').modal('toggle');
		});
		
		$(document).ready(function() {
			$(".knob").knob();
		});

		//]]>
	</script>

</body>

</html>