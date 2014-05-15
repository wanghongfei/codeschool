/**
 * 
 */

var editor = null;
var editor2 = null;

// 预览窗口可拖动
$('.result-container').draggable({
	cursor : 'move'
});

// 提交代码发送ajax请求
$("#submit-code").click(function(e) {
	e.preventDefault();

	var $msg = $("#msg");

	// 显示动态图片
	var gifUrl = '/codeschool/resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");

	console.log("当前section id : " + currentSectionId);
	var json = {
		code : editor.getValue(),
		sectionId : currentSectionId
	};

	$.ajax({
		url : "/codeschool/courses/start/submit-code",
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		success : function(data) {
			// 清空信息并显示服务器返回数据
			$msg.empty();
			$msg.html(data.message);

			// 更新页面用户信息
			$("#user-point").html(data.point);

			console.log(data);
		}
	});
});

function updatePreview() {
	$("#result-preview").contents().find("html").html(editor.getValue());
	setTimeout(updatePreview, 1000);
}

// 切换小节
$(".change-section-link").click(function(e) {
	e.preventDefault();

	currentSectionId = $(this).attr("data-id");

	$.ajax({
		url : $(this).attr("href"),
		type : "GET",
		dataType : 'json',
		success : function(data) {
			$("#section-name").html(data.name);
			$("#section-content").html(data.content);
			// currentSectionId = data.id;
			editor.setValue(data.initialCode.replace(/\\n/g, "\n"));
		}
	});
});

$(document).ready(function() {
	// 设置代码编辑区样式
	editor = ace.edit("editor1");
	editor.setTheme("ace/theme/chrome");
	editor.getSession().setMode("ace/mode/html");

	editor2 = ace.edit("editor2");
	editor2.setTheme("ace/theme/chrome");
	editor2.getSession().setMode("ace/mode/html");

	//editor.setValue("${ section.initialCode }");
	editor.setValue(initialCode);
	// editor.setValue("<body>\n\t<h1>hello, world!</h1>\n</body>");

	// 每秒钟预览一下结果
	setTimeout(updatePreview, 1000);
});