/**
 * 
 */
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

$("#select-chapter").change(function(e) {
	$("#chapter-name").val($("#select-chapter option:selected").html());
});


$("#form").submit(function(e) {
	e.preventDefault();

	var json = {
		chapterId : $("#select-chapter option:selected").val(),
		chapterName : $("#chapter-name").val()
	};
	
	var $msg = $("#error-msg");

	// 显示动态图片
	var gifUrl = '/codeschool/resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");

	$.ajax({
		url : $("#form").attr("action"),
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(json),
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

//delete chapter
$('.del-btn').click(function(e) {
	e.preventDefault();
	
	var json = {
		chapterId : $('#select-chapter option:selected').val()
	};
	
	if ('-1' == json.chapterId) {
		alert("未选中任何小节");
		return false;
	}
	
	var $msg = $("#error-msg");

	// display loading GIF image
	var gifUrl = '/codeschool/resources/img/ajax-loader.gif';
	$msg.empty();
	$msg.append("<img src='" + gifUrl + "' width='30px' height='30px' />");
	
	// send ajax request
	$.ajax({
		url : "/codeschool/backstage/updateChapter/delete",
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(json),
		success : function(data) {
			// display feedback message
			$msg.html(data.message);
			$msg.removeClass("hidden").addClass("error-msg");

			// refresh this page if deletion succeeded
			// in 1 second
			if (true == data.result) {
				setTimeout("location.reload()", 1000);
			}
		}
	});
	
});