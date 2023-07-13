package kr.co.cc.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration

//STOMP (Simple Text Oriented Messaging Protocol) 프로토콜을 기반으로 웹소켓 메시지 처리를 활성화
@EnableWebSocketMessageBroker
// WebSocketMessageBrokerConfigurer 인터페이스를 구현하여 WebSocket 메시징을 위한 구성 메서드를 제공
public class WebsocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// registerStompEndpoints 메서드는 클라이언트가 연결할 수 있는 STOMP 엔드포인트를 구성 
		// 이 경우, 엔드포인트 URL은 /ws-stomp이며 withSockJS()를 호출하여 SocketJS를 사용하여 대체 옵션을 활성화
		
		// stomp 접속 주소 url => /ws-stomp
        registry.addEndpoint("/ws-stomp") // 연결될 엔드포인트
                .withSockJS(); // SocketJS 를 연결한다는 설정
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		//configureMessageBroker 메서드는 메시지 브로커를 구성 
		//메시지 브로커는 발행자로부터 구독자에게 메시지를 라우팅하는 역할을 담당		
		
		// 메시지를 구독하는 요청 url => 즉 메시지 받을 때
		//  /sub로 시작하는 목적지에 구독한 클라이언트에게 메시지를 브로드캐스트하는 간단한 브로커가 활성화
        registry.enableSimpleBroker("/sub");

        // 메시지를 발행하는 요청 url => 즉 메시지 보낼 때
		// 클라이언트는 /pub로 시작하는 목적지에 메시지를 전송할 수 있
        registry.setApplicationDestinationPrefixes("/pub");
	}
	
}


