$(document).ready(function() {
	$(".knob").knob();
	$(".date").datepicker({
		changeMonth : true,
		changeYear : true,
		yearRange: '1940:2014',
		dateFormat: 'yy-mm-dd'
	});
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