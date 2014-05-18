/**
 * 
 */

// 发送消息
$("#btn-send").click(function(e) {
	e.preventDefault();
	
	var json = {
		message: $("#input-msg").val()
	};
	
	$.ajax({
		url : "/codeschool/chat/send/admin",
		type : "POST",
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(json),
		success : function(data) {
			console.log(data);
		}
	});
});

// 接收消息
$("#btn-check").click(function(e) {
	e.preventDefault();
	
	$.ajax({
		url : "/codeschool/chat/recv/admin",
		type : "GET",
		dataType : 'json',
		contentType : 'application/json',
		//data : JSON.stringify(json),
		success : function(data) {
			console.log(data);
		}
	});
});

$(document).ready(function() {
	
});