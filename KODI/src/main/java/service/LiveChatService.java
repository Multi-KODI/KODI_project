package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.LiveChatDAO;
import dto.AllChatDTO;
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
	public List<AllChatDTO> selectAllChatMsg(int chatIdx) {		
		List<ChatMsgDTO> chatMsgDTO = dao.selectAllChatMsg(chatIdx);
		
		List<AllChatDTO> allChatDTO = new ArrayList<>();
		
		for (ChatMsgDTO dto : chatMsgDTO) {
			String memberName = dao.selectMemberName(dto.getMemberIdx());
			
			allChatDTO.add(new AllChatDTO(dto, memberName));
		}

		return allChatDTO;
	}
	
}
