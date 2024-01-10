package dao;

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

}