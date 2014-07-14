<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>

<aside class="left-side sidebar-offcanvas">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="img/avatar3.png" class="img-circle" alt="User Image" />
			</div>
			<div class="pull-left info">
				<p>Hello, Jane</p>

				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>


		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<!-- <li class="active"> -->
			<li><a href="<c:url value='/backstage/course' />"> <i
					class="fa fa-dashboard"></i> <span>添加课程</span>
			</a></li>
			<li><a href="<c:url value='/backstage/chapter' />"> <i
					class="fa fa-th"></i> <span>添加章节</span> <small
					class="badge pull-right bg-green">new</small>
			</a></li>
			
			<li>
				<a href="<c:url value='/backstage/updateChapter' />">
					<i class="fa fa-th"></i>
					<span>修改章节</span>
					<small class="badge pull-right bg-green">new</small>
				</a>
			</li>
			
			<li><a href="<c:url value='/backstage/section' />"> <i
					class="fa fa-th"></i> <span>添加小节</span> <small
					class="badge pull-right bg-green">new</small>
			</a></li>
			<li class="treeview"><a href="#"> <i
					class="fa fa-bar-chart-o"></i> <span>test</span> <i
					class="fa fa-angle-left pull-right"></i>
			</a>
				<ul class="treeview-menu">
					<li><a href="pages/charts/morris.html"><i
							class="fa fa-angle-double-right"></i> Morris</a></li>
					<li><a href="pages/charts/flot.html"><i
							class="fa fa-angle-double-right"></i> Flot</a></li>
					<li><a href="pages/charts/inline.html"><i
							class="fa fa-angle-double-right"></i> Inline charts</a></li>
				</ul></li>
			<li><a href="<c:url value='/backstage/updateSection' />"> <i
					class="fa fa-th"></i> <span>修改小节</span> <small
					class="badge pull-right bg-green">new</small>
			</a></li>
			<li><a href="<c:url value='/backstage/statistics' />"> <i
					class="fa fa-th"></i> <span>统计信息</span> <small
					class="badge pull-right bg-green">new</small>
			</a></li>

		</ul>
	</section>
</aside>