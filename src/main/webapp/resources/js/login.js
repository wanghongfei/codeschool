/**
 * 
 */

// ajax提交表单
$("#login-form").submit(function(e) {
	e.preventDefault();

	var json = {
		username : $("#form-username").val(),
		password : $("#form-password").val()
	};
	
	var $msg = $("#error-msg");

	// 显示动态图片
	var gifUrl = CONTEXT_ROOT + 'resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");

	$.ajax({
		url : $("#login-form").attr("action"),
		type : "POST",
		headers: { 
	        'Accept': 'application/json; charset=utf-8',
	        'Content-Type': 'application/json' 
	    },
		//contentType: 'application/json; charset=utf-8',
		dataType : 'json',
		data : JSON.stringify(json),
		statusCode: {
			500: function() {
				$msg.html("服务器内部错误");
			}
		},
		success : function(data) {
			// 验证成功，刷新页面
			if (data.result == true) {
				location.reload(true);
			} else { // 验证失败，显示错误信息
				$msg.html(data.message);
				$msg.removeClass("hidden").addClass("error-msg");
			}
		}
	});
});