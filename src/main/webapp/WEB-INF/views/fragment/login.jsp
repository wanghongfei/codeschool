<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" %>

<c:if test="${currentUser == null }">
	<div>
		<div id="loginModal" class="modal fade">
			<div id="login-modal" class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h1 class="text-center">用户登陆</h1>
					</div>
					<div class="modal-body">
						<form action="<c:url value='/login' />" id="login-form"
							class="form col-md-12 center-block">
							<div class="form-group">
								<input type="text" name="username" id="form-username"
									placeholder="用户名" class="form-control input-lg" />
							</div>
							<div class="form-group">
								<input type="password" name="password" id="form-password"
									placeholder="密码" class="form-control input-lg" />
							</div>
							<div class="form-group">
								<input type="submit" value="登陆" class="btn btn-primary btn-lg btn-block" />
								<%-- <span class="pull-right"><a href="#">注册</a></span> --%>
								<%-- <span><a href="#">帮助</a></span> --%>
							</div>

							<div id="error-msg" class="hidden"></div>
						</form>
					</div>
					<div class="modal-footer">
						<div class="col-md-12">
							<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</c:if>