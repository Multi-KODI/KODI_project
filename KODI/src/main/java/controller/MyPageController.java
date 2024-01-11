package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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

  /**
   * POST 비밀번호 인증 (/api/verifyPw) DATA: 유저 입력 비밀번호
   * POST 회원탈퇴 (/api/withdrawMember)DATA: X
   * POST 회원정보 수정 (/api/updateMemberInfo) DATA: 변경할 비밀번호, 닉네임, 국적
   * GET 마이페이지 요청 (/api/myPage) DATA: X
   */

  @Autowired
  private MemberService memberService;

  @Autowired
  private MyPageService myPageService;

  /**
   * 회원탈퇴 시 비밀번호 인증
   * 
   * @param session
   * @return
   */
  @PostMapping("/verifyPw")
  public ResponseEntity<String> verifyPw(HttpSession session, @RequestParam String typedPassword) {

    // 세션에 로그인이 되어있는지 확인
    // 로그인이 안되어 있을 때
    if (session.getAttribute("memberIdx") == null) {
      return new ResponseEntity<>("로그인 정보가 없습니다", HttpStatus.BAD_REQUEST);

      // 로그인이 되어 있을 때
    } else {

      // 세션에 바운딩된 멤버아이디를 가져옴
      int memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

      // 비밀번호를 받아옴
      String password = memberService.findMemberByIdx(memberIdx).getPw();

      // 비밀번호가 일치하는 경우
      if (typedPassword.equals(password)) {
        return new ResponseEntity<>("회원정보 확인 완료", HttpStatus.OK);

        // 비밀번호가 불일치하는 경우
      } else {
        return new ResponseEntity<>("비밀번호가 일치하지 않습니다", HttpStatus.BAD_REQUEST);
      }
    }
  }

  /**
   * 회원탈퇴 처리
   * 
   * @param session
   * @return
   */
  @PostMapping("/withdrawMember")
  public ResponseEntity<String> withdrawMember(HttpSession session) {

    // 세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    // 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
      memberService.withdrawMember(memberIdx);
      return new ResponseEntity<>("회원탈퇴가 완료되었습니다", HttpStatus.OK);
      // 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
    } else {
      return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
    }
  }

  /**
   * 회원정보 수정
   * 
   * @param memberDTO
   * @param session
   * @return
   */
  @PostMapping("/updateMemberInfo")
  public ResponseEntity<String> updateMemberInfo(@RequestBody MemberDTO memberDTO, HttpSession session) {

    // 세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    // 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
      memberService.updateMemberInfo(memberDTO, memberIdx);
      return new ResponseEntity<>("회원정보가 업데이트 되었습니다", HttpStatus.OK);

      // 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
    } else {
      return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
    }
  }

  /**
   * 마이페이지 요청
   * 
   * @param session
   * @return
   */
  @GetMapping("/myPage")
  public ModelAndView readMyPosts(HttpSession session) {
    ModelAndView mv = new ModelAndView();
    // 세션에 바운딩된 유저아이디를 받아옴
    Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

    // 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
    if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
      // 나의 전체글 가져오기
      List<PostDTO> myPosts = myPageService.readMyPosts(memberIdx);
      // 내가 쓴 글이 존재할 때 Model&View에 추가
      if (myPosts != null) {
        mv.addObject("myPosts", myPosts);
      }
      mv.setViewName("MyPage");
      return mv;

      // 로그인이 안돼어 있거나 회원이 존재하지 않는 경우
    } else {
      return null;
    }
  }
}