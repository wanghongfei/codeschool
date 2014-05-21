<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>


<c:if test="${ currentUser != null }">
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-comment"></span> Chat
						<div class="btn-group pull-right">
							<button type="button"
								class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								<span class="glyphicon glyphicon-chevron-down"></span>
							</button>
							<ul class="dropdown-menu slidedown">
								<li><a href="http://www.jquery2dotnet.com"><span
										class="glyphicon glyphicon-refresh"> </span>Refresh</a></li>
								<li><a href="http://www.jquery2dotnet.com"><span
										class="glyphicon glyphicon-ok-sign"> </span>Available</a></li>
								<li><a href="http://www.jquery2dotnet.com"><span
										class="glyphicon glyphicon-remove"> </span>Busy</a></li>
								<li><a href="http://www.jquery2dotnet.com"><span
										class="glyphicon glyphicon-time"></span> Away</a></li>
								<li class="divider"></li>
								<li><a href="http://www.jquery2dotnet.com"><span
										class="glyphicon glyphicon-off"></span> Sign Out</a></li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<ul class="chat">
							<!-- <li class="left clearfix"><span class="chat-img pull-left">
                            <img src="http://placehold.it/50/55C1E7/fff&amp;text=U" alt="User Avatar" class="img-circle">
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font">Jack Sparrow</strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span>12 mins ago</small>
                                </div>
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare
                                    dolor, quis ullamcorper ligula sodales.
                                </p>
                            </div>
                        </li> -->
						</ul>
					</div>

					<%-- 发送消息 --%>
					<div class="panel-footer">
						<div class="input-group">
							<input id="input-msg" type="text" class="form-control input-sm"
								placeholder="Type your message here..."> <span
								class="input-group-btn">
								<button class="btn btn-warning btn-sm" id="btn-send">Send</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			setTimeout(receiveMsg, 3000);
		});
	</script>
</c:if>

