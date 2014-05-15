$("#form").submit(function(e) {
	e.preventDefault();

	var json = {
		courseName : $("input[name='courseName']").val(),
		courseDescription : $("textarea[name='courseDescription']").val()
	};

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
				$("input[name='courseName']").val("");
				$("textarea[name='courseDescription']").val("");
			}
		}
	});
});

// 删除课程
$("#form-del").submit(function(e) {
	e.preventDefault();

	var id = $("#select-course option:selected").val();
	var json = {
		courseId : id
	};

	$.ajax({
		url : $("#form-del").attr("action"),
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		success : function(data) {
			var msg = $("#error-msg");

			msg.html(data.message);
			msg.removeClass("hidden").addClass("error-msg");

			// 删除下拉表单中的对应option
			if (true == data.result) {
				$("#select-course option[value='" + id + "']").remove();
			}
		}
	});
});