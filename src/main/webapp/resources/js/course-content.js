/**
 * 
 */

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

	var json = {
		code : editors[0].getValue(),
		language: "html",
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
		}
	});
});

function updatePreview() {
	$("#result-preview").contents().find("html").html(editors[0].getValue());
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
			editors[0].setValue(data.initialCode.replace(/\\n/g, "\n"));
		}
	});
});

/**
 * JS 验证
 */
$(".code-javascript").click(function(e) {
	e.preventDefault();
	
	
	// 清空预览窗口原有输出
	var $elem = $("#result-preview").contents().find("body");
	$elem.html("");
	
	// 执行用户JS代码
	var $msg = $("#msg");
	var code = editors[0].getValue();
	try {
		eval(code);
	} catch (error) {
		$msg.html("语法错误:" + error);
		return;
	}

	// 显示动态图片
	var gifUrl = '/codeschool/resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");
	
	// 向服务器发送请求
	var json = {
		language: "javascript",
		code: $elem.html(),
		sectionId : currentSectionId
	}
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
		}
	});
	
});

var editors = []; // 维护 editor 引用
var lastLog = null;

$(document).ready(function() {
	var tabTitles = $("#myTab").children();
	var firstTitle = tabTitles.first();
	var firstTab = $(".tab-content").children().first();
	firstTitle.addClass("active");
	firstTab.addClass("active");
	
	// 初始化所有 editor
	$.each(tabTitles, function(ix ,elem) {
		var title = $(elem).find("a");
		var id = title.attr("data-id");
		var lan = title.attr("data-lan");

		var editor = ace.edit(id);
		editor.setTheme("ace/theme/chrome");
		editor.getSession().setMode("ace/mode/" + lan);
		editor.setValue(initialCode);

		editors.push(editor);
	});
	
	// 每秒钟预览一下结果
	if ($("#submit-code").length)
		setTimeout(updatePreview, 1000);
	
	// 替换console.log
	console.oldLog = console.log;
	console.log = function(str) {
		//console.oldLog(str);
		
		var $elem = $("#result-preview").contents().find("body");
		var previousValue = $elem.html();
		
		if ("" == previousValue) {
			$elem.html(str);
		} else {
			$elem.html(previousValue + "<br />" + str);
		}
	}
	
});

