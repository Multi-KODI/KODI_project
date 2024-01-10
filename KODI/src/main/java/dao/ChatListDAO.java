package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("chatlistdao")
@Mapper
public interface ChatListDAO {
	
	/**
	 * 전체 친구 고유 값정보 조회
	 * @param memberIdx
	 * @return 전체 친구 고유값 리스트
	 */
	List<Integer> selectFriendMemberIdx(int memberIdx);

	/**
	 * 친구 이름 조회
	 * @param friendIdx
	 * @return 친구 이름
	 */
	String selectFriendMemberName(int friendIdx);

	/**
	 * 내가 친구를 추가했는지 여부
	 * @param map
	 * @return 나의 친구신청 여부(1|0)
	 */
	int selectIsFriendByMe(HashMap<String, Integer> map);

	/**
	 * 친구가 나를 추가했는지 여부
	 * @param map
	 * @return 친구의 친구신청 여부(1|0)
	 */
	int selectIsFriendByOther(HashMap<String, Integer> map);

	/**
	 * 채팅방 리스트 조회
	 * @param memberIdx
	 * @return 채팅방 고유값 리스트
	 */
	List<Integer> selectChatIdx(int memberIdx);

	/**
	 * 채팅방 친구 고유값 조회
	 * @param memberIdx
	 * @return 채팅방 친구 고유값 리스트
	 */
	int selectChatFriendIdx(int chatIdx);

	/**
	 * 채팅방의 가장 최근 메시지 조회
	 * @param chatIdx
	 * @return 최근 메시지 내용
	 */
	String selectContent(Integer chatIdx);

}