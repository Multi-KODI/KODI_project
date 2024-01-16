package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.FlagDTO;
import dto.FriendDTO;
import dto.MemberDTO;
import dto.PostDTO;

@Repository("mypagedao")
@Mapper
public interface MyPageDAO {
	
	//나의 전체글 가져오기 SQL문
	List<PostDTO> readMyPosts(int memberIdx);
	//서로이웃
	List<FriendDTO> allFriends(int memberIdx);
	//내가 추가한 사용자
	List<FriendDTO> mySideFriends(int memberIdx);
	//나를 추가한 사용자
	List<FriendDTO> otherSideFriends(int memberIdx);
	//친구 정보 조회
	List<MemberDTO> friendInfo(List<Integer> friendList);
  List<FlagDTO> allFlags();
}
