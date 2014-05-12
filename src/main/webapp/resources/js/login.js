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

	$.ajax({
		url : $("#login-form").attr("action"),
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		success : function(data) {
			// 验证成功，刷新页面
			if (data.result == true) {
				location.reload(true);
			} else { // 验证失败，显示错误信息
				var msg = $("#error-msg");
				msg.html(data.message);
				msg.removeClass("hidden").addClass("error-msg");
			}
		}
	});
});