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
$("#select-course").change(
		function() {
			var json = {
				courseId : $("#select-course option:selected").val()
			};

			$.ajax({
				url : "/codeschool/backstage/section/fetchChapter",
				type : "POST",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(json),
				success : function(data) {
					console.log(data);

					// 清空章节下章列表原有内容
					$("#select-chapter").empty();

					// 添加新 option
					for (var ix = 0; ix < data.length; ++ix) {
						var chapter = data[ix];
						var $newOption = $("<option value='" + chapter.id
								+ "'>" + chapter.chapterName + "</option>");
						$("#select-chapter").append($newOption);
					}
				}
			});
		});

$("#form").submit(function(e) {
	e.preventDefault();

	var json = {
		courseId : $("#select-course option:selected").val(),
		chapterId : $("#select-chapter option:selected").val(),
		sectionName : $("#section-name").val(),
		sectionContent : $("#section-content").val(),
		initialCode : $("#section-code").val(),

		// 验证规则内容
		ruleType : $("#select-type option:selected").val(),
		tagName : $("#tag-name").val(),
		attrName : $("#attr-name").val(),
		attrValue : $("#attr-value").val()
	};

	$.ajax({
		url : $("#form").attr("action"),
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(json),
		success : function(data) {
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