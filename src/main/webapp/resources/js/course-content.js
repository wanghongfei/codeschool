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
	var gifUrl = CONTEXT_ROOT + 'resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");

	var json = {
		code : editors[0].getValue(),
		language: "html",
		sectionId : currentSectionId
	};

	$.ajax({
		url : CONTEXT_ROOT + "courses/start/submit-code",
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		statusCode: {
			500: function() {
				$msg.html("服务器内部错误");
			}
		},
		success : function(data) {
			// 清空信息并显示服务器返回数据
			$msg.empty();
			$msg.html(trim(data.message));

			// 更新页面用户信息
			$("#user-point").html(data.point);
		}
	});
});

// 将<,>换成转义符号
function trim(str) {
	var result = str.replace("<", "&lt;");
	result = result.replace(">", "&gt;");
	return result;
}

function updatePreview() {
	$("#result-preview").contents().find("html").html(editors[0].getValue());
	setTimeout(updatePreview, 1000);
}

// 切换小节
$(".change-section-link").click(function(e) {
	e.preventDefault();
	$("#msg").empty();

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
			
			// 高亮选中小节
			resetColor();
			highlight();
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
	var gifUrl = CONTEXT_ROOT + 'resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");
	
	// 向服务器发送请求
	var json = {
		language: "javascript",
		code: $elem.html(),
		sectionId : currentSectionId
	}
	$.ajax({
		url : CONTEXT_ROOT + "courses/start/submit-code",
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

// 提交评论
$("#form").submit(function(e) {
	e.preventDefault();
	
	var json = {
		content: $(".counted").val(),
		sectionId: currentSectionId
	};

	// 显示动态图片
	var $msg = $("#err-msg");
	var gifUrl = CONTEXT_ROOT + 'resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");
	
	// 发送AJAX请求
	$.ajax({
		url: CONTEXT_ROOT + "courses/start/comment/add",
		type: "POST",
		dataType: "json",
		contentType: "application/json",
		data: JSON.stringify(json),
		success : function(data) {
			// 显示服务器反馈信息
			$msg.html(data.message);

			// 操作成功
			if (data.result == true) {
				// 刷新页面
				location.reload(false);
			}
		}
	});
});


function resetColor() {
	$(".timeline-item").each(function() {
		$this = $(this);
		var $prev = $this.prev();
		$prev.removeClass("bg-yellow");
		$prev.addClass("bg-blue");
	});
}
function highlight() {
	$(".timeline-item").each(function() {
		$this = $(this);
		if (currentSectionId == $this.find("a").attr("data-id") ) {
			var $prev = $this.prev();
			$prev.removeClass("bg-blue");
			$prev.addClass("bg-yellow");
			
			return false;
		}
	});
}

// 得到下一小节的id号
// 如果没有下一小节，则返回null
function nextSection() {
	for (var ix = 0 ; ix < ids.length ; ++ix) {
		if (ids[ix] == currentSectionId) {
			if (ix < ids.length - 1) {
				return ids[ix + 1];
			} else {
				return null;
			}
		}
	}
}
// 得到上一小节的id号
// 如果没有, 返回null
function prevSection() {
	for (var ix = 1 ; ix < ids.length ; ++ix) {
		if (ids[ix] == currentSectionId) {
			return ids[ix - 1];
		}
	}	
	
	return null;
}

// 用户点击“下一节” button
$("#next-section").click(function(e) {
	e.preventDefault();
	
	var nextId = nextSection();
	if (null != nextId) {
		// 触发下一个链接的click事件
		$(".change-section-link[data-id='" + nextId + "']").trigger("click");
	} else {
		alert("最后一节了！");
	}
});
	

// 用户点击“上一节” button
$("#prev-section").click(function(e) {
	e.preventDefault();
	
	var prevId = prevSection();
	if (null != prevId) {
		// 触发下一个链接的click事件
		$(".change-section-link[data-id='" + prevId + "']").trigger("click");
	} else {
		alert("已经是第一节");
	}
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
	
	
	// 高亮当前小节
	highlight();
	
});

