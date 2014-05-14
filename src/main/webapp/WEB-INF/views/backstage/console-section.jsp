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
		        	
		        	<form id="form" action="<c:url value='/backstage/section/save' />" >
		        		<div>
			        		<label for="select-course">选择课程:</label>
			        		<select id="select-course">
			        			<option value="-1">请选择</option>
		        				<c:forEach items="${ courseList }" var="_c">
		        					<option value="${ _c.id }"><c:out value="${ _c.courseName }"  /></option>	
		        				</c:forEach>
		       	 			</select>
		        		</div>
		        		
		        		<div>
			        		<label for="select-chapter">choose chapter:</label>
			        		<select id="select-chapter">
			        			<option value="-1" selected="selected">请选择</option>
			        		</select>
		        		</div>
		        		
		        		<!-- 小节名称 -->
			        	<div>
			        		<label for="section-name">section name：</label>
			        		<input type="text" name="sectionName" id="section-name" />
			        		
			        	</div>
			        	
			        	<!-- 小节内容 -->  	
			        	<div>
			        		<label for="section-content">小节内容：</label>
			        		<textarea name="sectionContent" id="section-content" ></textarea>
			        	</div>

			        	<!-- 初始代码 -->  	
			        	<div>
			        		<label for="section-code">初始代码：</label>
			        		<textarea name="sectionContent" id="section-code" ></textarea>
			        	</div>
			        	
			        	<!-- 创建验证规则 -->
			        	<div id="rule-type">
			        		<label for="select-type">选择规则类型</label>
			        		<select id="select-type">
			        			<option selected="selected">请选择</option>
			        			<c:forEach items="${ ruleTypeList }" var="_r">
			        				<option value="${ _r }">${ _r }</option>
			        			</c:forEach>
			        		</select>
			        	</div>
			        	
 			        	<div id="rule-contain" class="hidden">
			        		<label for="input-tag">要包含的标签</label>
			        		<input type="text" name="tagName" id="tag-name" />
			        	</div>

						<div id="rule-attr" class="hidden">
			        		<label for="attr-name">属性</label>
			        		<input type="text" name="attrName" id="attr-name" />
			        		<label for="attr-value">属性值</label>
			        		<input type="text" name="attrValue" id="attr-value" />
			        	</div>
					
						<div>
		        			<input type="submit" value="保存" />
		        		</div>
		        		<div id="error-msg" class="hidden"></div>
		        	</form>
		
					
				</section><!-- /.content -->
			</aside>
		</div>
		
		
		
		<!-- <ui:insert name="javascript" />-->
		<script src="<c:url value='/resources/js/jquery-1.9.1.js' />"></script>
		<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
		<!-- AdminLTE App -->
		<script src="<c:url value='/resources/js/AdminLTE/app.js' />"></script>

		<script type="text/javascript">
			// 为选择验证类型绑定事件
			// 根据不同的类型显示不同的元素
			$("#select-type").change(function() {
				var type = $("#select-type option:selected").val();
				// 只显示标签输入框
				if (type == "CONTAIN") {
					$("#rule-contain").removeClass("hidden");
					$("#rule-attr").addClass("hidden");
				
				// 显示标签输入框和属性输入框
				} else if (type == "ATTRIBUTE") {
					$("#rule-attr").removeClass("hidden");
					$("#rule-contain").removeClass("hidden");
				}
			});
		
			// 为 select 绑定事件
			$("#select-course").change(function() {
				var json = {
					courseId: $("#select-course option:selected").val()
				};
				
				$.ajax({
					url: "<c:url value='/backstage/section/fetchChapter' />",
					type: "POST",
					dataType: "json",
					contentType: "application/json",
					data: JSON.stringify(json),
					success: function(data) {
						console.log(data);
						
						// 清空章节下章列表原有内容
						$("#select-chapter").empty();
						
						// 添加新 option
						for (var ix = 0 ; ix < data.length ; ++ix) {
							var chapter = data[ix];
							var $newOption = $("<option value='" + chapter.id + "'>" + chapter.chapterName + "</option>");
							$("#select-chapter").append($newOption);
						}
					}
				});
			});
			
			$("#form").submit(function(e) {
				e.preventDefault();
				
				var json = {
					courseId: $("#select-course option:selected").val(),
					chapterId: $("#select-chapter option:selected").val(),
					sectionName: $("#section-name").val(),
					sectionContent: $("#section-content").val(),
					initialCode: $("#section-code").val(),
					
					// 验证规则内容
					ruleType: $("#select-type option:selected").val(),
					tagName: $("#tag-name").val(),
					attrName: $("#attr-name").val(),
					attrValue: $("#attr-value").val()
				};
				
				$.ajax({
					url: $("#form").attr("action"),
					type: "POST",
					dataType: "json",
					contentType: "application/json",
					data: JSON.stringify(json),
					success: function(data) {
						var msg = $("#error-msg");
   						
   						msg.html(data.message);
   						msg.removeClass("hidden").addClass("error-msg");
   						
   						// 清空表单
   						if (true == data.result) {
   							$("#section-name").val("");
   							$("#section-content").val("");
   						}
					}
				});
			});
	    </script>

	</body>

</html>

