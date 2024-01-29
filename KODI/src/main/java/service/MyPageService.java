package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MyPageDAO;
import dto.FlagDTO;
import dto.FriendDTO;
import dto.MemberDTO;
import dto.PostDTO;
import dto.PostImageDTO;

@Service("mypageservice")
public class MyPageService {
  @Autowired
  private MyPageDAO myPageDAO;
  //나의 게시물
  public List<PostDTO> readMyPosts(int memberIdx){
    List<PostDTO> myPosts = myPageDAO.readMyPosts(memberIdx);
    return myPosts;
  }
  //서로이웃
  public List<FriendDTO> allFriends(int memberIdx){
    List<FriendDTO> allFriends = myPageDAO.allFriends(memberIdx);
    return allFriends;
  }

  //내가 추가한 사용자
  public List<FriendDTO> mySideFriends(int memberIdx){
    List<FriendDTO> mySideFriends = myPageDAO.mySideFriends(memberIdx);
    return mySideFriends;
  }
  //나를 추가한 사용자
  public List<FriendDTO> otherSideFriends(int memberIdx){
    List<FriendDTO> otherSideFriends = myPageDAO.otherSideFriends(memberIdx);
    return otherSideFriends;
  }
  //친구정보 조회
  public List<MemberDTO> friendInfo (List<Integer> friendList){
    List<MemberDTO> friendInfo = myPageDAO.friendInfo(friendList);
    return friendInfo;
  }
  //전체 국가 조회
  public List<FlagDTO> allFlags() {
    return myPageDAO.allFlags();
  }
  //전체 이미지 조회
  public List<PostImageDTO> allImages() {
    return myPageDAO.allImages();
  }

  //서로 이웃 삭제
  public void pairDelete(Integer member_Idx, Integer memberIdx){
    myPageDAO.pairDelete(member_Idx, memberIdx);
  }
  
  //팔로잉 삭제
  public void followingDelete(Integer member_Idx, Integer memberIdx) {
    myPageDAO.followingDelete(member_Idx, memberIdx);
  }

  //팔로워 수락
  public void followerAccept(Integer member_Idx, Integer memberIdx) {
    myPageDAO.followerAccept(member_Idx, memberIdx);
  }

  //팔로워 삭제
  public void followerDelete(Integer member_Idx, Integer memberIdx) {
    myPageDAO.followerDelete(member_Idx, memberIdx);
  }
}
