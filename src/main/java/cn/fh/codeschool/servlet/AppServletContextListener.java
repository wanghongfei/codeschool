package cn.fh.codeschool.servlet;

import java.util.Date;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Start timer while this application is deploying.
 * @author whf
 *
 */
public class AppServletContextListener implements ServletContextListener {
	private Timer timer;
	private Timer sessionRecall;
	
	private static long TIMER_START_TIME = 1000 * 5; // in 5 seconds
	private static long TIMER_CHECK_INTERVAL = 1000 * 30; // every 30 seconds
	
	private static final Logger logger = LoggerFactory.getLogger(AppServletContextListener.class);

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		//timer.cancel();
		sessionRecall.cancel();
	}

	/**
	 * Check whether conversation is expired every 30 seconds.
	 */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//timer = new Timer();
		// 回收没有用户登陆的session
		sessionRecall = new Timer();

		logger.info("Timer has been started!!!");

		//timer.schedule(new TimerTask() {
		sessionRecall.schedule(new TimerTask() {
			@Override
			public void run() {
				logger.debug(">>>>>>>>>> Timer executes!!, session数量：{}", LoggedInUserCollection.getSessionList().size());

				
				// 遍历每一个session
				/*Iterator<HttpSession> sessionIt = LoggedInUserCollection.getSessionList().iterator();
				HttpSession session = null;
				while (sessionIt.hasNext()) {
					session = sessionIt.next();

					
					// 回收僵尸session
					if (null == session.getAttribute("currentUser")) {
						if (logger.isDebugEnabled()) {
							logger.debug("回收僵尸session:{}", session.getId());
						}

						sessionIt.remove();
						session.invalidate();
						continue;
					}
					
					if (logger.isDebugEnabled()) {
						Object[] parms = new Object[] {session.getAttribute("currentUser"), Long.valueOf( new Date().getTime() - session.getLastAccessedTime()), Integer.valueOf(session.getMaxInactiveInterval()) };
						logger.debug("## 用户：{}, 上次访问至现在时间间隔(ms):{}, inactive(m):{}", parms);
					}
				}*/

				/*for (HttpSession session : LoggedInUserCollection.getSessionList()) {
					// 回收僵尸session
					if (null == session.getAttribute("currentUser")) {
						if (logger.isDebugEnabled()) {
							logger.debug("回收僵尸session:{}", session.getId());
						}

						session.invalidate();
						continue;
					}
					
					if (logger.isDebugEnabled()) {
						logger.debug("## 用户：{}", session.getAttribute("currentUser"));
					}
					
					// Traverse conversations inside this session
					ConversationManager cm = (ConversationManager)session.getAttribute("cm");
					
					if (true == cm.getConversationList().isEmpty()) {
						continue;
					}

					Iterator<Conversation> it = cm.getConversationList().iterator();
					while (it.hasNext()) {
						Conversation c = it.next();
						long interval = Calendar.getInstance().getTimeInMillis() - c.getLastUpdateTime().getTime();
						if (interval >= ConversationManager.expireTime) {
							logger.info(">>>>>>> destroy Conversation:" + c.getCid());
							it.remove();
						}
					}
				}*/


			}
			
		}, TIMER_START_TIME, TIMER_CHECK_INTERVAL); // 30 seconds
	}

}
