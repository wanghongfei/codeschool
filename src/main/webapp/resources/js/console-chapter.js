$(document).ready(function() {
	$("#form").submit(function(e) {
		e.preventDefault();

		var json = {
			courseId : $("#select-course option:selected").val(),
			chapterName : $("#chapter-name").val()
		};

		var $msg = $("#error-msg");

		// 显示动态图片
		//var gifUrl = '/codeschool/resources/img/ajax-loader.gif';
		var gifUrl = CONTEXT_ROOT + 'resources/img/ajax-loader.gif';
		$msg.empty();
		$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");

		$.ajax({
			url : $("#form").attr("action"),
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

				$msg.html(data.message);
				$msg.removeClass("hidden").addClass("error-msg");

				// 清空表单
				if (true == data.result) {
					$("#chapter-name").val("");
				}
			}
		});
	});
});