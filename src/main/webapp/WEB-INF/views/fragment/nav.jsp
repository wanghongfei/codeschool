<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

<nav class="navbar navbar-default navbar-inverse navbar-fixed-top"
	role="navigation">
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


		<%-- 未登陆 --%>
		<c:if test="${currentUser == null }">
			<div>
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav navbar-right">
						<li>
							<form action="/codeschool/user/search" class="search-form">
								<input type="text" name="username" class="form-control search-username" placeholder="用户搜索" />
								<input type="submit" value="搜索" class="btn btn-sm search-btn" />
							</form>
						</li>
						<li><a href="#about" class="nav-link">关于</a></li>
						<li><a href="#sign-in" id="register-btn">登陆</a></li>
 						<li><button class="btn btn-warning btn-sm navbar-btn" onclick="redirect();">注册</button></li>
					</ul>
				</div>
			</div>
		</c:if>

		<%-- 已登陆 --%>
		<c:if test="${currentUser != null }">
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li>
						<a href="<c:url value='/user/${ currentUser.username }/profile' />" class="nav-link"> <span id="user-info"> ${currentUser.username}, 积分:<span id="user-point">${currentUser.point}</span> </span></a>
					</li>
					<li>
						<a href="<c:url value='/logout' />" class="nav-link">退出登陆</a>
					</li>
					<c:if test="${ currentUser.hasRole('admin') }">
						<li><a href="<c:url value='/backstage/course' />" class="nav-link">后台页面</a></li>
					</c:if>
					<li>
 						<button class="btn btn-warning btn-sm navbar-btn" onclick="redirect();">注册</button>
					</li>
				</ul>
			</div>
		</c:if>
		<!-- /.navbar-collapse -->
	</div>
</nav>
