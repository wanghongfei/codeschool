$(document).ready(function() {
	$("#form").submit(function(e) {
		e.preventDefault();

		var json = {
			courseId : $("#select-course option:selected").val(),
			chapterName : $("#chapter-name").val()
		};

		var url = $(this).attr("action");
		console.log("url : " + url);

		$.ajax({
			url : $("#form").attr("action"),
			type : "POST",
			dataType : 'json',
			contentType : 'application/json',
			data : JSON.stringify(json),
			success : function(data) {
				var msg = $("#error-msg");

				msg.html(data.message);
				msg.removeClass("hidden").addClass("error-msg");

				// 清空表单
				if (true == data.result) {
					$("#chapter-name").val("");
				}
			}
		});
	});
});