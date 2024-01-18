package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.FlagDTO;
import dto.MemberDTO;
import dto.PostDTO;
import jakarta.servlet.http.HttpSession;
import service.AdminService;
import service.MemberService;
import service.MyPageService;

@Controller
@RequestMapping("/api/admin")
public class AdminController {

	/**
	 * GET 전체 유저 조회 (/api/admin/allmembers) DATA: X
	 * GET 전체 게시물 조회 (/api/admin/allposts) DATA: X
	 * POST 유저 삭제 (/api/admin/deletemember) DATA: 삭제할 멤버 아이디
	 * POST 포스트 삭제 (/api/admin/deletepost) DATA: 삭제할 포스트 아이디
	 */

	@Autowired
	private MemberService memberService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private MyPageService myPageService;

	/**
	 * 전체 유저 조회
	 * 
	 * @return
	 */
	@GetMapping("/allmembers")
	public ModelAndView findAllMemebers(HttpSession session) {
		if (validateAdmin(session)) {
			// 전체 멤버 가져오기
			List<MemberDTO> members = memberService.findAllMembers();
			List<FlagDTO> flags = myPageService.allFlags();
			ModelAndView mv = new ModelAndView();
			mv.addObject("members", members);
			mv.addObject("flags", flags);
			mv.setViewName("Admin-Member");
			return mv;
			// 유저가 관리자가 아니거나 유저정보가 없을 때
		} else {
			return null;
		}
	}

	/**
	 * 전체 글 조회
	 * 
	 * @return
	 */
	@GetMapping("/allposts")
	public ModelAndView findAllPosts(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 유저가 관리자일 때
		if (validateAdmin(session)) {
			// 전체 게시물 가져오기

			List<PostDTO> posts = adminService.findAllPosts();
			List<MemberDTO> members = memberService.findAllMembers();
			mv.addObject("members", members);
			mv.addObject("posts", posts);
			mv.setViewName("Admin-Post");
			return mv;
			// 유저가 관리자가 아니거나 유저정보가 없을 때
		} else {
			return null;
		}
	}

	/**
	 * 회원 삭제
	 * 
	 * @return
	 */
	@GetMapping("/deletemember")
	public ModelAndView deleteMember(@RequestBody MemberDTO memberDTO, HttpSession session) {
		// 유저가 관리자일 때
		if (validateAdmin(session)) {
			// 회원삭제
			memberService.withdrawMember(memberDTO.getMemberIdx());
			// 삭제 후 유저리스트를 보여줌
			List<MemberDTO> members = memberService.findAllMembers();
			ModelAndView mv = new ModelAndView();
			mv.addObject("members", members);
			mv.setViewName("Admin-Member");
			return mv;
			// 유저가 관리자가 아니거나 유저정보가 없을 때
		} else {
			return null;
		}

	}

	/**
	 * 게시물 삭제
	 * 
	 * @return
	 */
	@GetMapping("/deletepost/{postIdx}")
	public String deletePost(@PathVariable Integer postIdx, HttpSession session) {
		// 유저가 관리자일 때
		if (validateAdmin(session)) {
			// 게시물이 존재할 때
			if (adminService.findPostByIdx(postIdx) != null) {
				// 게시물 삭제 진행
				adminService.deletePost(postIdx);
			}
			//
			//allPosts url 매핑 컨트롤러 메소드 호출
			return "redirect:/api/admin/allposts";
		} else {
			return "redirect:/api/admin/allposts";
		}
	}

	/**
	 * 관리자 인증
	 * 
	 * @param session
	 * @return
	 */
	private boolean validateAdmin(HttpSession session) {
		// 세션에서 멤버 아이디 받아오기
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		// 멤버 아디디로 멤버 정보 가져오기
		MemberDTO member = memberService.findMemberByIdx(memberIdx);
		if (member != null) {
			// 멤버 이메일 가져오기
			String email = member.getEmail();

			// 이메일이 관리자 소유인지 확인
			// 관리자일 때
			if (isEmailAdmin(email)) {
				return true;

				// 관리자가 아닐 때
			} else {
				return false;
			}
			// 멤버가 존재하지 않는 경우
		} else {
			return false;
		}
	}

	/**
	 * 관리자 인증 (이메일 검사)
	 * 
	 * @param email
	 * @return
	 */
	private boolean isEmailAdmin(String email) {
		// 이메일 주소에서 '@' 이후의 문자열을 추출
		int atIndex = email.indexOf('@');

		if (atIndex != -1) {
			String domain = email.substring(atIndex + 1);
			// '@' 이후의 문자열에 'admin'이 포함되어 있는지 확인
			return domain.contains("admin");
		}

		// '@'이 포함되지 않은 이메일 주소는 관리자가 아님
		return false;
	}
}
