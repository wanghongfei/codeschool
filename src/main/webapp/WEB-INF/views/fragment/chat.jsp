<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>


<c:if test="${ currentUser != null }">
	<div class="panel panel-primary chat-dialog" style="margin-bottom: 0px;">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-comment"></span> 在线聊天: &nbsp;<span
				class="chat-user">未选择聊天对象</span>
			<div class="btn-group pull-right">
				<button type="button"
					class="btn btn-default btn-xs dropdown-toggle toggle-show">
					<span class="glyphicon glyphicon-chevron-down"></span>
				</button>
				<%--<ul class="dropdown-menu slidedown">
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
				</ul> --%>
			</div>
		</div>
		<div class="panel-body chat-body hidden">
			<ul class="chat">
				<%--  <li class="left clearfix"><span class="chat-img pull-left">
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
                        </li> --%>
			</ul>
		</div>

		<%-- 发送消息 --%>
		<div class="panel-footer chat-body hidden">
			<div class="input-group">
				<input id="input-msg" type="text" class="form-control input-sm"
					placeholder="消息"> <span class="input-group-btn">
					<button class="btn btn-warning btn-sm" id="btn-send">发送</button>
				</span>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			setTimeout(receiveMsg, 10000);
		});
	</script>
</c:if>

