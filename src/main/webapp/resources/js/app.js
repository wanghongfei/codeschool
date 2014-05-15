/**
 * 
 */
function redirect() {
	window.location = "/codeschool/register"
}

// 登陆按钮
$("#register-btn").click(function(e) {
	$('#loginModal').modal('toggle');
});