package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("searchmemberlistdao")
@Mapper
public interface SearchMemberListDAO {
	
	//검색어에 해당하는 멤버 idx 전부 조회
	//@param question
	//@return 멤버 idx 리스트
	public List<Integer> selectMemberIdx(String question);
	
	//조회한 memberIdx에 대한 멤버 이름 조회
	//@param memberIdx
	//@return 멤버 이름
	public String selectMemberName(int memberIdx);
	
	//조회한 memberIdx에 대한 flag_idx 조회
	//@param memberIdx
	//@return flag_idx
	public int selectFlagIdx(int memberIdx);
	
	//조회한 flag_idx에 대한 나라이름(country) 조회
	//@param flagIdx
	//@return 나라이름(country)
	public String selectMemberCountry(int flagIdx);
	
	//나의 friend_member_idx들 조회
	//@param myMemberIdx
	//@return friend_member_idx 리스트
	public List<Integer> selectFriendMemberIdx(int myMemberIdx);
	
	//memberIdx1은 member_idx를 의미하고 memberIdx2는 friend_member_idx를 의미한다.
	//@param myMemberIdx, friendMemberIdx
	//@return friend_idx
	public int selectFriendIdx(int memberIdx1, int memberIdx2);
	
	//friendIdx인 칼럼의 is_friend값 조회
	//@param friendIdx
	//@return is_friend(boolean타입)
	public boolean selectIsFriend(int friendIdx);
	
	
}