package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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

			if(isFriendByMe == 1 && isFriendByOther == 1) {
				String friendMemberName = dao.selectFriendMemberName(friendIdx);
				
				ChatListFriendDTO friendInfo = new ChatListFriendDTO(friendIdx, friendMemberName);
				chatListFriendDTO.add(friendInfo);
			}
		}
		
		// 채팅방 리스트
		List<Integer> allChatIdx = dao.selectChatList(memberIdx);
		List<ChatListRoomDTO> chatListRoomDTO = new ArrayList<>();
		
		for (Integer chatIdx : allChatIdx) {
			int chatFriendIdx = dao.selectChatFriendIdx(chatIdx);
			String friendMemberName = dao.selectFriendMemberName(chatFriendIdx);
			String content = dao.selectContent(chatIdx);
			
			ChatListRoomDTO chatInfo = new ChatListRoomDTO(chatIdx, chatFriendIdx, friendMemberName, content);
			chatListRoomDTO.add(chatInfo);
		}
		
		return new ChatListDTO(memberIdx, chatListFriendDTO, chatListRoomDTO);
	}

	/**
	 * 채팅방 여부 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 여부
	 */
	public boolean selectChatRoom(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		int result = dao.selectChatRoom(map);
		if(result == 1) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 채팅방 번호 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 번호
	 */
	public int selectChatIdx(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		return dao.selectChatIdx(map);
	}

	/**
	 * 새로운 채팅방 생성
	 * @param memberIdx
	 * @param friendMemberIdx
	 */
	public void createChatRoom(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		dao.insertChat(map);
	}

	/**
	 * 친구 검색
	 * @param memberIdx
	 * @param friendName
	 * @return 친구 정보
	 */
	public List<ChatListFriendDTO> searchFriend(int memberIdx, String friendName) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("friendName", friendName);
		map.put("memberIdx", memberIdx);
		
		return dao.selectFriendInfo(map);
	}

	/**
	 * 채팅방 삭제
	 * @param chatIdx
	 * @return 삭제 여부(1|0)
	 */
	public int deleteChat(int chatIdx) {
		return dao.deleteChat(chatIdx);
	}

}
