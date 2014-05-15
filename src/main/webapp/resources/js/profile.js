$(document).ready(function() {
	$(".knob").knob();
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