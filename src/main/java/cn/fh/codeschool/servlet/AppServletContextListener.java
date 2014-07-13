package cn.fh.codeschool.servlet;

import java.util.Calendar;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.fh.codeschool.scope.Conversation;
import cn.fh.codeschool.scope.ConversationManager;

/**
 * Start timer while this application is deploying.
 * @author whf
 *
 */
public class AppServletContextListener implements ServletContextListener {
	private Timer timer;
	
	private static long TIMER_START_TIME = 1000 * 5; // in 5 seconds
	private static long TIMER_CHECK_INTERVAL = 1000 * 30; // every 30 seconds
	
	private static final Logger logger = LoggerFactory.getLogger(AppServletContextListener.class);

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		timer.cancel();
	}

	/**
	 * Check whether conversation is expired every 30 seconds.
	 */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		timer = new Timer();
		logger.info("Timer has been started!!!");

		timer.schedule(new TimerTask() {
			@Override
			public void run() {
				logger.debug(">>>>>>>>>> Timer executes!!, session数量：{}", LoggedInUserCollection.getSessionList().size());
				// No session created yet.
				if (true == LoggedInUserCollection.getSessionList().isEmpty()) {
					return;
				}

				
				// Traverse every session
				for (HttpSession session : LoggedInUserCollection.getSessionList()) {
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
				}


			}
			
		}, TIMER_START_TIME, TIMER_CHECK_INTERVAL); // 30 seconds
	}

}
