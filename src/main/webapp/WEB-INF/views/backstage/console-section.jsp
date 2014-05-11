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

		
	
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
			  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
			<![endif]-->	
	</head>
	<body id="body" class="skin-blue">
		<!-- header logo: style can be found in header.less -->
		<header class="header">
			<a href="index.html" class="logo">课程后台管理</a>
		</header>
		
		
		<div class="wrapper row-offcanvas row-offcanvas-left">
			<!-- 左侧主体 starts -->
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
			            <li>
			                <a href="#">
			                    <i class="fa fa-dashboard"></i> <span>添加课程</span>
			                </a>
			            </li>
			            <li>
			                <a href="#">
			                    <i class="fa fa-th"></i> <span>添加章节</span> <small class="badge pull-right bg-green">new</small>
			                </a>
			            </li>
			            <li>
			                <a href="#">
			                    <i class="fa fa-th"></i> <span>添加小节</span> <small class="badge pull-right bg-green">new</small>
			                </a>
			            </li>
			            <li class="treeview">
			                <a href="#">
			                    <i class="fa fa-bar-chart-o"></i>
			                    <span>添加小节</span>
			                    <i class="fa fa-angle-left pull-right"></i>
			                </a>
			                <ul class="treeview-menu">
			                    <li><a href="pages/charts/morris.html"><i class="fa fa-angle-double-right"></i> Morris</a></li>
			                    <li><a href="pages/charts/flot.html"><i class="fa fa-angle-double-right"></i> Flot</a></li>
			                    <li><a href="pages/charts/inline.html"><i class="fa fa-angle-double-right"></i> Inline charts</a></li>
			                </ul>
			            </li>
			            
			        </ul>
			    </section>
			</aside>
			<!-- 左侧主体 ends -->
			
			<!-- 右侧主体 -->
			<aside class="right-side">
				<!-- Content Header (Page header) -->
				<section class="content-header">
				    <h1>
				        Blank page
				        <small>Control panel</small>
				    </h1>
				    <ol class="breadcrumb">
				        <li><a href="#"><i class="fa fa-dashboard"></i> 添加小节</a></li>
				        <!-- <li class="active">Blank page</li> -->
				    </ol>
				</section>
				
				<!-- Main content -->
		        <section class="content">
		        	<h1>添加小节</h1>
		
		
		        	<%-- <h:form id="form">
			       		<!-- 选择课程 -->
			       		<div>        		
			        		<label for="select-course">选择课程:</label>
			        		<h:selectOneMenu id="select-course" value="#{courseBean.selectedCourseId}">
			        			<f:selectItem itemLabel="请选择" noSelectionOption="true"/>
			        			<!-- fetch all courses -->
			        			<f:selectItems value="#{courseBean.getCourses(true)}"
									var="_course"
									itemLabel="#{_course.courseName}"
									itemValue="#{_course.id}" />
			        			
			        			<f:ajax event="change" render="select-chapter" execute="@this" />
			        			
			        		</h:selectOneMenu>
			        	</div>
		
		         		<!-- 选择章节 -->
		         		
			        	<div>
			        		<label for="select-chapter">choose chapter:</label>
			        		<h:selectOneMenu id="select-chapter" value="#{courseBean.selectedChapterId}">
			        			<f:selectItem itemLabel="请选择" noSelectionOption="true"/>
			        			<f:selectItems value="#{courseBean.getChapters(true)}" var="_chapter" itemLabel="#{_chapter.chapterName}" itemValue="#{_chapter.id}" />
			        		</h:selectOneMenu>
			        	</div>
		
			        	
			        	
			        	<!-- 小节名称 -->
			        	<div>
			        		<label for="section-name">section name：</label>
			        		<h:inputText id="section-name" value="#{courseBean.newCourseSection.sectionName}" />
			        		
			        	</div>
			        	
			        	<!-- 小节内容 -->  	
			        	<div>
			        		<label for="section-content">小节内容：</label>
			        		<h:inputTextarea id="section-content" value="#{courseBean.newCourseSection.courseContent}" rows="10" cols="30" />		
			        	</div>
			        	
			        	<!-- 创建验证规则 -->
			        	<!-- 选择规则类型 -->
			        	<div>
			        		<label for="rule-type">规则类型：</label>
			        		<h:selectOneMenu id="rule-type" value="#{courseBean.newRule.ruleType}" >
			        			<f:selectItem itemLabel="请选择验证类型" noSelectionOption="true"/>
			        			<f:selectItems value="#{ruleTypeBean.getRuleItems()}" />
			        			
			        			<f:ajax event="change" execute="this" render="rule-content" />
			        		</h:selectOneMenu>
			        	</div>
			        	
			        	<!-- 规则内容，根据上面选择的不同而不同 -->
			        	<h:panelGroup id="rule-content" layout="block">
			        		<!-- 如果是包含规则 -->
			 				<ui:fragment rendered="#{courseBean.newRule.ruleType == 'CONTAIN'}">
			 					<label for="tag-name1">标签名</label>
			 					<h:inputText id="tag-name1" value="#{courseBean.newRule.tagName}" />
			 				</ui:fragment>
			 				
			 				<!-- 即要包含标签，又要指定属性 -->
			 				<ui:fragment rendered="#{courseBean.newRule.ruleType == 'ATTRIBUTE'}">
			 					<label for="tag-name">标签名</label>
			 					<h:inputText id="tag-name" value="#{courseBean.newRule.tagName}" />
			 					
			 					<label for="attr-name">属性名</label>
			 					<h:inputText id="attr-name" value="#{courseBean.newRule.attrName}" />
			 					
			 					<label for="attr-value">属性值</label>
			 					<h:inputText id="attr-value" value="#{courseBean.newRule.attrValue}" />
			 				</ui:fragment>
			        		
			        	</h:panelGroup>
			        	
			        	<div>
			        		<!-- persist the CourseSection entity -->
			        		<h:commandButton action="#{courseBean.saveSection()}" value="save" >
			        			<f:ajax execute="form" render="form" />
			        		</h:commandButton>
			        	</div>
						
						
						<!-- <s:div id="cid">
							<input type="hidden"  name="cid" value="#{conversation.id}"/>
						</s:div> -->
			        	
			        	<h:message for="form" id="persist-msg" />
		        	</h:form> --%>
					
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

		<script type="text/javascript">

	    </script>

	</body>

</html>

