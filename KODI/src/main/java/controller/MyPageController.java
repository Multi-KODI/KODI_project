package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.MemberDTO;
import dto.PostDTO;
import jakarta.servlet.http.HttpSession;
import service.MemberService;
import service.MyPageService;

@Controller
@RequestMapping("/api")
public class MyPageController {
  
  @Autowired
  private MemberService memberService;

  @Autowired 
  private MyPageService myPageService;

  /**
   * 회원탈퇴 시 비밀번호 인증
   * @param session
   * @return
   */
  @PostMapping("/verifyPw") 
	public boolean verifyPw(HttpSession session, @RequestParam String typedPassword){

    //세션에 로그인이 되어있는지 확인
      //로그인이 안되어 있을 때
    if(session.getAttribute("memberIdx") == null){
      return false;
      
      //로그인이 되어 있을 때
    }else{
      
      //세션에 바운딩된 멤버아이디를 가지고 회원조회
      int memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));
      
      //비밀번호를 받아옴
      String password = memberService.findMemberByIdx(memberIdx).getPw();
      
      //비밀번호가 일치하는 경우
      if(typedPassword.equals(password)){
        return true;

      //비밀번호가 불일치하는 경우
      }else{
        return false;
      }
    }
	}

  /**
   * 회원탈퇴 처리
   * @param session
   * @return
   */
  @PostMapping("/withdrawMember") 
	public boolean withdrawMember(HttpSession session){
    
    //세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    //세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if(memberIdx != null && memberService.findMemberByIdx(memberIdx) != null){
      memberService.withdrawMember(memberIdx);
      return true;
    //세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
    }else{
      return false;
    }
	}

  /**
   * 회원정보 수정
   * @param memberDTO
   * @param session
   * @return
   */
  @PostMapping("/updateMemberInfo") 
	public boolean updateMemberInfo(@RequestBody MemberDTO memberDTO, HttpSession session){
    
    //세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    //세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if(memberIdx != null && memberService.findMemberByIdx(memberIdx) != null){
      memberService.updateMemberInfo(memberDTO);
      return true;

    //세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
    }else{
      return false;
    }
	}

  /**
   * 나의 글 가져오기
   * @param session
   * @return
   */
  @PostMapping("/readMyPosts") 
	public ModelAndView readMyPosts(HttpSession session){
    ModelAndView mv = new ModelAndView();
    //세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    //세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if(memberIdx != null && memberService.findMemberByIdx(memberIdx) != null){
      //나의 전체글 가져오기
      List<PostDTO> myPosts = myPageService.readMyPosts(memberIdx);
      //내가 쓴 글이 존재할 때 Model&View에 추가
      if(myPosts != null){
        mv.addObject("myPosts", myPosts);
      }
      mv.setViewName("MyPage");
      return mv;

    //로그인이 안돼어 있거나 회원이 존재하지 않는 경우
    }else{
      return null;
    }
  }
}