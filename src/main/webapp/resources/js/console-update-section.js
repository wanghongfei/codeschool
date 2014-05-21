/**
 * 
 */
// 为选择验证类型绑定事件
// 根据不同的类型显示不同的元素
$("#select-type").change(function() {
	var type = $("#select-type option:selected").val();
	// 只显示标签输入框
	if (type == "CONTAIN") {
		$("#rule-contain").removeClass("hidden");

		$("#rule-attr").addClass("hidden");
		$("#rule-result").addClass("hidden");

		// 显示标签输入框和属性输入框
	} else if (type == "ATTRIBUTE") {
		$("#rule-attr").removeClass("hidden");
		$("#rule-contain").removeClass("hidden");

		$("#rule-result").addClass("hidden");

		// 只显示结果输入框
	} else if (type == "OUTPUT") {
		$("#rule-result").removeClass("hidden");

		$("#rule-attr").addClass("hidden");
		$("#rule-contain").addClass("hidden");
	}
});

var sections = null; // 保存服务返回的章节的所有小节数据
$("#select-chapter").change(
		function() {
			var json = {
				chapterId : $("#select-chapter option:selected").val()
			};

			$.ajax({
				url : "/codeschool/backstage/section/fetchSection",
				type : "POST",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(json),
				success : function(data) {
					sections = data;
					console.log(data);

					// 清空小节列表原有内容
					$("#select-section").empty();

					// 添加新 option
					$("#select-section").append($('<option value="-1" selected="selected">请选择</option>"'));
					for (var ix = 0; ix < data.length; ++ix) {
						var section = data[ix];
						var $newOption = $("<option value='" + section.id
								+ "'>" + section.sectionName + "</option>");
						$("#select-section").append($newOption);
					}
				}
			});
		});

$("#select-section").change(function() {
	var selectedId = $("#select-section option:selected").val();
	var selectSection = null;
	$.each(sections, function(ix, obj) {
		if (obj.id == selectedId) {
			selectedSection = obj;
			return false;
		}
	});
	
	// 更新表单域
	$("#section-name").val(selectedSection.sectionName);
	$("#section-content").val(selectedSection.sectionContent);
	editor.setValue(selectedSection.initialCode);
});

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
					$("#select-chapter").append($('<option value="-1" selected="selected">请选择</option>"'));
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
		sectionId : $("#select-section option:selected").val(),
		sectionName : $("#section-name").val(),
		sectionContent : $("#section-content").val(),
		initialCode : editor.getValue(),

		// 验证规则内容
		ruleType : $("#select-type option:selected").val(),
		tagName : $("#tag-name").val(),
		attrName : $("#attr-name").val(),
		output : $("#input-result").val(),
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

var editor = null;
$(document).ready(function() {
	// initialize code editor
	editor = ace.edit("editor");
	editor.setTheme("ace/theme/chrome");
	editor.getSession().setMode("ace/mode/html");
});