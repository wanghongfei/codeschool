/**
 * 
 */
function redirect() {
	window.location = "/codeschool/register"
}

// 登陆按钮
$("#register-btn, #register").click(function(e) {
	e.preventDefault();
	$('#loginModal').modal('toggle');
});