/**
 * 
 */

var CONTEXT_ROOT = "/";

function redirect() {
	window.location = CONTEXT_ROOT + "register"
}

// 登陆按钮
$("#register-btn, #register").click(function(e) {
	e.preventDefault();
	$('#loginModal').modal('toggle');
});