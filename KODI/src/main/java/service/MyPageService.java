package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MyPageDAO;
import dto.PostDTO;

@Service
public class MyPageService {
  @Autowired
  private MyPageDAO myPageDAO;
  
  public List<PostDTO> readMyPosts(int memberIdx){
    List<PostDTO> myPosts = myPageDAO.readMyPosts(memberIdx);
    return myPosts;
  }
}
