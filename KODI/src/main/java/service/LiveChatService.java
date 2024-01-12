package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.LiveChatDAO;
import dto.ChatMsgDTO;

@Service("livechatservice")
public class LiveChatService {
	@Autowired
	@Qualifier("livechatdao")
	LiveChatDAO dao;
	
	/**
	 * 과거 채팅방 메시지 조회
	 * @param chatIdx
	 * @return 과거 채팅방 메시지 리스트
	 */
	public List<ChatMsgDTO> selectAllChatMsg(int chatIdx) {
		return dao.selectAllChatMsg(chatIdx);
	}
	
}
