package kr.co.cc.alarm.config;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 실질적으로 알람 보내주는 클래스 
@Component
public class WebSocketHandler extends TextWebSocketHandler {

	//세션 리스트
    protected ArrayList<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    //세션과 유저 매핑
    private HashMap<String, Object> userMap = new HashMap<String, Object>();

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private boolean isPostCreated = false;

    //클라이언트가  WebSocket에 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception { // 개인에 대한 웹소켓 session id 부여해줌 (로그인 세션이랑 다른 개념)
        sessionList.add(session);
        logger.info("{} 연결됨", session.getId());
        
        for(WebSocketSession sess : sessionList) {
			logger.info("현재 연결된 세션 : " + sess.getId());
        }
        
        logger.info("size () : " + sessionList.size());
    }

    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        
        if (isPostCreated) {
            // 글 작성 시에만 알림을 전송
            for (WebSocketSession sess : sessionList) {
                logger.info("보내야 될사람 : " + sess.getId());
                logger.info("session.getId() : " + session.getId());
                sess.sendMessage(new TextMessage(message.getPayload()));
            }
        }
        
        
        
        //모든 유저에게 메세지 출력
    	for(WebSocketSession sess : sessionList) {
			logger.info("보내야 될사람 : " + sess.getId());
			logger.info("session.getId() : " + session.getId());
			sess.sendMessage(new TextMessage(message.getPayload()));
        }
        
    }
        
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }

	public void setPostCreated(boolean isPostCreated) {
		this.isPostCreated = isPostCreated;
	}
	
	public void sendAlarm(String msg) {
		
		logger.info("msg :" + msg);
		logger.info("size () : " + sessionList.size());
		
		for (WebSocketSession sess : sessionList) {
            logger.info("보내야 될사람 : " + sess.getId());
            try {
				sess.sendMessage(new TextMessage(msg));
			} catch (IOException e) {
				
				e.printStackTrace();
			}
        }
	}
	
	public void connect() {
		
	}
	
	
}
