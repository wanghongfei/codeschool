$(document).ready(function() {
	$(".knob").knob();
	$(".date").datepicker({
		changeMonth : true,
		changeYear : true,
		yearRange: '1940:2014',
		dateFormat: 'yy-mm-dd'
	});
	
	$(".tip").tooltip();
});

// 点赞
$("#thumb-btn").click(function(e) {
	$.ajax({
		url : "/codeschool/user/" + username + "/thumbUp",
		type : "GET",
		dataType : 'json',
		contentType : 'application/json',
		// data: JSON.stringify(json),
		success : function(data) {
			$("#thumb-amount").html(data.thumbs);
		}
	});
});

$.city_select($(".select-city"), $("#select-city"));

// submit form via ajax
$("#form").submit(function(e) {
	e.preventDefault();
	
	// obtain location from select component
	var $loca = $(".city_select option:selected");
	var location = "";
	$loca.each(function(ix, city) {
		location += $(city).text() + ";";
	});
	
	var json = {
		nickName: $("#nickName").val(),
		email: $("#email").val(),
		birthday: $("#birthday").val(),
		qq: $("#qq").val(),
		'location': location
	};
	
	$msg = $("#error-msg");
	$.ajax({
		url : $("#form").attr("action"),
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		success : function(data) {
			$msg.removeClass("hidden").addClass("error-msg");
			if (true == data.result) {
				$msg.html("保存成功");
			} else {
				$msg.html("保存失败");
			}

		}
	})
});