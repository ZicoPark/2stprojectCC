package kr.co.cc.alarm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

// 웹소켓 설정 파일
@Configuration // 빈(일종의 객체) 생성
@EnableWebSocket
public class SocketConfig implements WebSocketConfigurer {
	
	// 포폴에 넣어야 댐 
	 @Autowired
    private WebSocketHandler myWebSocketHandler;
	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(myWebSocketHandler, "/alarm")
					.setAllowedOrigins("*"); // cors 설정(모두 허락)
	}
	
	/*
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new WebSocketHandler(), "/alarm")
					.setAllowedOrigins("*"); // cors 설정(모두 허락)
	}
	
	// @Autowired 추가 및 코드 변경 전 
	
	*/

}
