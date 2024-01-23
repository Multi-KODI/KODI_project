package config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocketHandler extends TextWebSocketHandler {

	List<WebSocketSession> homeList = new ArrayList<WebSocketSession>(); // 한 채팅방에 모여 있는 클라이언트 리스트
	List<WebSocketSession> chatList = new ArrayList<WebSocketSession>(); // 한 채팅방에 모여 있는 클라이언트 리스트
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getRemoteAddress() + " 에서 접속했습니다."); // 클라이언트 IP
				
		if(session.getUri().getPath().equals("/home")) {
			homeList.add(session);
		} else {
			// 브라우저 여는 것마다 다 통신해서 일단 현재 사용자가 채팅방 하나만 열 수 있도록 제한
			if(chatList.size() < 1) {
				chatList.add(session);
			}	
		}
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// 웹소켓 연결되어있는 클라이언트(session)가 메시지(message)를 보낼 때 자동 실행
		// 나머지 클라이언트(list에 저장)에게 해당 메시지를 전송해주는 기능 구현
		String msg = (String) message.getPayload(); // 전송받은 메시지만 뽑아내는 함수
		
		if(session.getUri().getPath().equals("/home")) {
			for (WebSocketSession socket : homeList) {
				WebSocketMessage<String> sendmsg = new TextMessage(msg);
				socket.sendMessage(sendmsg);
			}
		} else {
			for (WebSocketSession socket : chatList) {
				WebSocketMessage<String> sendmsg = new TextMessage(msg);
				socket.sendMessage(sendmsg);
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(session.getRemoteAddress() + " 에서 해제했습니다.");
		if(session.getUri().getPath().equals("/home")) {
			homeList.remove(session);			
		} else {
			chatList.remove(session);
		}
	}

}
