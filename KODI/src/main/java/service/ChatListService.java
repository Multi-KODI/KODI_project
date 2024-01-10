package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ChatListDAO;
import dto.ChatListDTO;
import dto.ChatListFriendDTO;

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
		
		List<Integer> friendMemberIdx = dao.selectFriendMemberIdx(memberIdx);
		List<String> friendMemberNames = new ArrayList<>();
		
		for (Integer friendIdx : friendMemberIdx) {
			String friendMemberName = dao.selectFriendMemberName(friendIdx);
			friendMemberNames.add(friendMemberName);
		}

		ChatListFriendDTO allFriendInfo =  new ChatListFriendDTO(friendMemberIdx,friendMemberNames);

		System.out.println(allFriendInfo.getFriendMemberIdx().get(0));
		System.out.println(allFriendInfo.getFriendMemberName().get(0));

		return new ChatListDTO(allFriendInfo, null);
	}

}
