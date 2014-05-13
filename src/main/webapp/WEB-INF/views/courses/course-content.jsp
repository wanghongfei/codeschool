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
		
		
		<link href='<c:url value="/resources/css/login.css" />' rel="stylesheet" />
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
			}

			.text-white {
				color: white;
			}
			
			#editor {
				height: 600px;
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
		<nav class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
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
	
	
				<!-- 未登陆 -->
				<c:if test="${currentUser == null }">
					<div>
						<div class="collapse navbar-collapse navbar-ex1-collapse">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="#about" class="nav-link">关于</a></li>
								<li><a href="#sign-in" id="register-btn">登陆</a></li>
								<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
							</ul>
						</div>
					</div>
				</c:if>
				
				<!-- 已登陆 -->
				<c:if test="${currentUser != null }">
					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a href="#about" class="nav-link">
									<span id="user-info">
										${currentUser.username}, 积分: ${currentUser.point}
									</span>
								</a>
							</li>
							<li>
 								<a href="<c:url value='/logout' />" class="nav-link">退出登陆</a>
							</li>
							<li><button class="btn btn-warning btn-sm navbar-btn">注册</button></li>
						</ul>
					</div>
				</c:if>
			</div>
		</nav>
		<!--  顶部导航 ends -->


		<!-- 页面主体 -->
		<div class="container" id="choose-course">
			<div class="row">
				<!-- 上边界填充 -->
				<div class="margin-elem"></div>
				<div class="margin-elem"></div>
				
				
				
				<!-- 左侧教程 -->
				<div class="col-md-4">
					<div id="course-section" class="box box-primary">
		                <div class="box-header" data-toggle="tooltip" title="Header tooltip">
		                	<!-- 小节标题 -->
		                    <h3 class="box-title text-white">
		                    	${ section.sectionName }
		                    </h3>
		                </div>
		                <div class="box-body">
		                    <!-- 小节内容 -->
		                    <p>
		                    	${ section.courseContent }
		                    </p>
		                </div>
		            </div>
		            
		            <button class="btn btn-primary" style="float: left">上一节</button>
		            <button class="btn btn-primary" style="float: right">下一节</button>
		            
	        	</div><!-- /.col -->
					
				
				<!-- 右侧代码区 -->
				<div class="col-md-8">
					<pre id="editor">
	
					</pre>
					
					<!-- 隐藏的输入框用来保存用户代码，并与后台bean绑定 -->		
					<input type="text" class="html-code hidden" />	
					
					<!-- 用户登陆才能显示此按钮 -->		
					<!-- <input type="submit" class="btn btn-primary submit-btn float-left" /> -->	
	
						
						
					<button class="btn btn-primary" style="float: left" id="submit-code">提交</button>
					<button class="btn btn-primary" style="float: right">重置</button>
					
					<div id="msg" class="float-left error-msg">
					</div>
						
				</div>
			
			</div><!-- row ends -->
		</div>
		
		
		

		<footer>
			<div class="container clearfix">
				<p class="pull-left">Copyright 飞鸿软件工作室 2014</p>
				<p class="pull-right">Email: brucewhf@gmail.com</p>
			</div>
		</footer>
		
		
		<!-- 这里是绝对定位的元素 -->

		<!-- 代码预览窗口 -->
		<div class="result-container">
			<iframe id="result-preview"></iframe>
		</div>
		
		<!-- 时间轴 -->
		<div class="my-timeline">
			<ul class="timeline">

			    <!-- 章节名 -->
			    <li class="time-label">
			        <span class="bg-red">
			        	${ section.courseChapter.chapterName }
			        </span>
			    </li>
			
			    <!-- 小节 -->			    
			    <c:forEach items="${ section.courseChapter.courseSections }" var="_s">
			    	<li>
			    		<i class="fa fa-envelope bg-blue my-timeline-icon"></i>
				        <div class="timeline-item">
				            <div class="timeline-body">
			    	        	<!-- 点击小节点后用ajax更新教程区内容 -->
			    	        	${ _s.sectionName }
				            </div>
				        </div>
		    		</li>
			    </c:forEach>
			    			
			</ul>
		</div>


		<!--登陆对话框-->
		<c:if test="${currentUser == null }">
			<div>
				<div id="loginModal" class="modal fade">
					<div id="login-modal" class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								<h1 class="text-center">用户登陆</h1>
							</div>
							<div class="modal-body">
								<form action="<c:url value='/login' />" id="login-form" class="form col-md-12 center-block">
									<div class="form-group">
										<input type="text" name="username" id="form-username" placeholder="用户名" class="form-control input-lg" />
									</div>
									<div class="form-group">
										<input type="password" name="password" id="form-password" placeholder="密码" class="form-control input-lg" />
									</div>
									<div class="form-group">
										<input type="submit" value="登陆" class="btn btn-primary btn-lg btn-block" />	
										<span class="pull-right"><a href="#">注册</a></span><span><a href="#">帮助</a></span>
									</div>
									
									<div id="error-msg" class="hidden"></div>
								</form>
							</div>
							<div class="modal-footer">
								<div class="col-md-12">
									<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</c:if>
		
		
		
		<script src='<c:url value="/resources/js/jquery.js" />'></script>
		<script src='<c:url value="/resources/js/jquery-ui.js" />'></script>
		<script src='<c:url value="/resources/js/bootstrap.min.js" />'></script>
		<!-- AdminLTE App -->
		<script src='<c:url value="/resources/js/AdminLTE/app.js" />'></script>

		<!-- <script src="/spring-mvc/resources/js/jquery-ui.js"></script> -->
		<script src='<c:url value="/resources/js/code-editor/ace.js" />'></script>
		

		<script src="<c:url value='/resources/js/login.js' />"></script>
		<script type="text/javascript">
		//<![CDATA[
			var editor = null;
			    
			// 为注册按钮绑定事件
   			$("#register-btn, #login-btn").click(function(e) {
   				$('#loginModal').modal('toggle');
			});

		    // 预览窗口可拖动
		    $('.result-container').draggable(
				{
					cursor: 'move'
				}
			);
		    
		    // 提交代码发送ajax请求
		    $("#submit-code").click(function(e) {
		    	e.preventDefault();
		    	
   				var $msg = $("#msg");

		    	//显示动态图片
		    	var gifUrl = '<c:url value="/resources/img/ajax-loader.gif" />';
		    	$msg.empty();
				$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");	    	
		    	
		    	var json = {
		    		code: editor.getValue(),
		    		sectionId: "${section.id}"
		    	};
		    	
		    	$.ajax({
   					url: "<c:url value='/courses/start/submit-code' />",
   					type: "POST",
   					dataType: 'json',
   					contentType: 'application/json',
   					data: JSON.stringify(json),
   					success: function(data) {
   						// 清空信息并显示服务器返回数据	
   						$msg.empty();
   						$msg.html(data.message);
   						
   						console.log(data);
   					}
   				});
		    });


			function updatePreview() {
				$("#result-preview").contents().find("html").html(editor.getValue());
				setTimeout(updatePreview, 1000);
			}


			$(document).ready(function() {
				// 设置代码编辑区样式
			    editor = ace.edit("editor");
			    editor.setTheme("ace/theme/chrome");
			    editor.getSession().setMode("ace/mode/html");


			    editor.setValue("<body>\n\t<h1>hello, world!</h1>\n</body>");

			    // 每秒钟预览一下结果
			    setTimeout(updatePreview, 1000);
			});
			
		//]]>
	    </script>


	</body>

</html>