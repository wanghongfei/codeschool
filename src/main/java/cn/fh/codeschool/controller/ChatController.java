package cn.fh.codeschool.controller;

import java.util.Date;
import java.util.Map;
import java.util.Queue;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.fh.codeschool.model.Member;
import cn.fh.codeschool.model.Message;
import cn.fh.codeschool.servlet.LoggedInUserCollection;
import cn.fh.codeschool.util.Security;

@Controller
public class ChatController {
	private static Logger logger = LoggerFactory.getLogger(ChatController.class);

	/**
	 * 向指定用户发送消息
	 * @return
	 */
	@RequestMapping(value = "/chat/send/{username}", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String chat(@PathVariable String username, @RequestBody Map<String, Object> reqMap,
			HttpServletRequest req) {
		// obtain request parameter
		String message = (String)reqMap.get("message");

		if (logger.isDebugEnabled()) {
			logger.debug("## Message received:{}", message);
		}

		// 得到已经登陆用户的session
		Map<String, HttpSession> sessionMap = LoggedInUserCollection.getSessionMap();
		
		// 取出目标用户session
		HttpSession targetSession = sessionMap.get(username);
		// 目标用户不存在, 返回错误信息
		if (null == targetSession) {
			return Json.createObjectBuilder()
					.add("result", false)
					.add("message", "not logged in")
					.build()
					.toString();
		}
		
		// 得到当前用户和目标用户
		Member targetMember = (Member)targetSession.getAttribute("currentUser");
		
		// 当前用户未登陆，一定是用非正常方式发送的请求！
		if (false == Security.isLoggedIn(req)) {
			return Json.createObjectBuilder()
				.add("result", false)
				.add("message", "not logged in")
				.build()
				.toString();
		}
		Member sourceMember = Security.getLoggedInUser(req);

		// 封装信息
		Message msg = new Message();
		msg.setTime(new Date());
		msg.setContent(message);
		msg.setFromUser(sourceMember.getUsername());
		msg.setToUser(targetMember.getUsername());
		msg.setPosted(false);
		
		// 放入目标用户的接收消息队列
		targetMember.getReceivedMessageQueue().add(msg);
		
		return Json.createObjectBuilder()
				.add("result", true)
				.add("message", "success")
				.build()
				.toString();
	}
	
	/**
	 * 检查当前用户是否有未读消息
	 * @return
	 */
	@RequestMapping(value = "/chat/recv/{username}", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public @ResponseBody String checkMessage(HttpServletRequest req) {
		//Member m = (Member)req.getSession().getAttribute("currentUser");
		Member m = Security.getLoggedInUser(req);

		// 没有消息
		Queue<Message> msgQueue = m.getReceivedMessageQueue();
		if (true == msgQueue.isEmpty()) {
			return Json.createObjectBuilder()
					.add("result", false)
					.build()
					.toString();
		}
		
		// 有消息
		// {
		// 		result: true/false,
		//		data: [object, object... ...]
		// }
		JsonObjectBuilder json = Json.createObjectBuilder()
				.add("result", true);

		JsonArrayBuilder jArray = Json.createArrayBuilder();
		while (false == msgQueue.isEmpty()) {
			Message msg = msgQueue.poll();
			
			if (logger.isDebugEnabled()) {
				logger.debug("## Get message:{}", msg);
			}
			
			jArray.add(Json.createObjectBuilder()
					.add("from", msg.getFromUser())
					.add("to", msg.getToUser())
					.add("time", msg.getTime().toString())
					.add("content", msg.getContent())
					);
		}
		
		JsonObject obj = json.add("data", jArray).build();
		String jsonString = obj.toString();
		
		if (logger.isDebugEnabled()) {
			logger.debug("Return JSON:{}", jsonString);
		}
		
		return jsonString;
	}
}
