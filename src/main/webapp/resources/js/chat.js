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
			if (true == data.result) {
				$(".chat").append(createMessageElement("消息 " + $("#input-msg").val() + " 发送成功!"));
			}
		}
	});
});

// 接收消息
function receiveMsg() {
	$.ajax({
		url : "/codeschool/chat/recv/admin",
		type : "GET",
		dataType : 'json',
		contentType : 'application/json',
		success : function(data) {
			if (true == data.result) {
				$(".chat").append(createMessageElement(data.data[0].content));
			}
			console.log(data);
		}
	});
	setTimeout(receiveMsg, 5000);
}

function createMessageElement(content) {
	return $('<li class="right clearfix"><div class="chat-body clearfix"><div class="header"><small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago</small><strong class="pull-right primary-font">Bhaumik Patel</strong></div><p>' + content + '</p></div></li>');
}