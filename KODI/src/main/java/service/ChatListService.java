package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ChatListDAO;
import dto.ChatListDTO;
import dto.ChatListFriendDTO;
import dto.ChatListRoomDTO;

@Service("chatlistservice")
public class ChatListService {
	@Autowired
	@Qualifier("chatlistdao")
	ChatListDAO dao;
	
	/**
	 * 채팅 리스트 정보 조회
	 * @param memberIdx
	 * @return 전체 친구 리스트, 채팅방 리스트
	 */
	public ChatListDTO getChatListInfo(int memberIdx) {
		
		// 전체 친구 리스트
		List<Integer> allFriendMemberIdx = dao.selectFriendMemberIdx(memberIdx);
		List<ChatListFriendDTO> chatListFriendDTO = new ArrayList<>();
				
		for (Integer friendIdx : allFriendMemberIdx) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();

			map.put("friendIdx", friendIdx);
			map.put("memberIdx", memberIdx);
			
			// 서로이웃 여부 확인
			int isFriendByMe = dao.selectIsFriendByMe(map);
			int isFriendByOther = dao.selectIsFriendByOther(map);
			
			System.out.println("isFriendByMe: " + isFriendByMe);
			System.out.println("isFriendByOther: " + isFriendByOther);
			
			if(isFriendByMe == 1 && isFriendByOther == 1) {
				String friendMemberName = dao.selectFriendMemberName(friendIdx);
				
				ChatListFriendDTO friendInfo = new ChatListFriendDTO(friendIdx, friendMemberName);
				chatListFriendDTO.add(friendInfo);
			}
		}
		
		System.out.println(chatListFriendDTO);

		for (ChatListFriendDTO one : chatListFriendDTO) {
			System.out.println(one.getFriendMemberIdx());
			System.out.println(one.getFriendMemberName());
		}

		// 채팅방 리스트
		List<Integer> allChatIdx = dao.selectChatIdx(memberIdx);
		List<ChatListRoomDTO> chatListRoomDTO = new ArrayList<>();
		
		for (Integer chatIdx : allChatIdx) {
			int chatFriendIdx = dao.selectChatFriendIdx(chatIdx);
			String friendMemberName = dao.selectFriendMemberName(chatFriendIdx);
			String content = dao.selectContent(chatIdx);
			
			ChatListRoomDTO chatInfo = new ChatListRoomDTO(chatIdx, chatFriendIdx, friendMemberName, content);
			chatListRoomDTO.add(chatInfo);
		}
		
		System.out.println("====chatListRoomDTO====");
		for (ChatListRoomDTO dto : chatListRoomDTO) {
			System.out.println(dto.getChatIdx());
			System.out.println(dto.getFriendMemberIdx());
			System.out.println(dto.getMemberName());
			System.out.println(dto.getContent());
		}
		
		return new ChatListDTO(chatListFriendDTO, chatListRoomDTO);
	}

}
