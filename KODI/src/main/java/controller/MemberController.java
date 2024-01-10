package controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import dto.MemberDTO;
import jakarta.servlet.http.HttpSession;
import service.EmailService;
import service.MemberService;

@RestController
@RequestMapping("/api")
public class MemberController {
	/**
	 * POST 이메일 발송(/api/email) DATA: 회원가입할 이메일
	 * POST 이메일 검증(/api/verify) DATA: 회원가입자가 입력한 OTP
	 * POST 회원가입 처리(/api/register) DATA: 회원가입자 이메일, 패스워드, 이름, 국적
	 * POST 로그인 처리(/api/login) DATA: 유저 이메일, 패스워드
	 * POST 로그아웃 처리(/api/logout) DATA: X
	 * 
	 */
	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;

	@Autowired
	@Qualifier("emailService")
	private EmailService emailService;

	/**
	 * 이메일 전송
	 * DATA: 회원가입할 이메일
	 * 
	 * @return
	 */
	@PostMapping("/email")
	@ResponseBody
	public boolean sendEmail(@RequestBody MemberDTO memberDTO, HttpSession session) {
		MemberDTO existingMember = memberService.findMemberByEmail(memberDTO.getEmail());
		// 중복 유저 확인
		if (existingMember != null) {
			return false;
		}

		// OTP 생성
		Random r = new Random();
		String otp = String.format("%06d", r.nextInt(100000));

		// OTP 비교를 위해 세션에 바운딩
		session.setAttribute("otp", otp);

		// 이메일 발송
		String subject = "Email Verfication";
		String body = "Your verification OPT is " + otp;
		emailService.sendEmail(memberDTO.getEmail(), subject, body);
		return true;
	}

	/**
	 * 이메일 검증
	 * DATA: 유저가 입력한 OTP번호
	 * 
	 * @return
	 */
	@PostMapping("/verify")
	@ResponseBody
	public boolean verifyEmail(String otp, HttpSession session) {

		// 사용자가 입력한 OTP와 세션의 OTP 비교
		if (session.getAttribute(otp).equals(otp)) {
			session.removeAttribute("otp");
			return true;
		}
		return false;
	}

	/**
	 * 회원가입 처리
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/register")
	public boolean registerMember(@RequestBody MemberDTO memberDTO, HttpSession session) {
		MemberDTO findedMember = memberService.findMemberByEmail(memberDTO.getEmail());

		// 기존에 멤버가 없을 때 회원등록
		if (findedMember == null) {
			memberService.registerMember(memberDTO);
			return true;
		}
		return false;
	}

	/**
	 * 로그인 처리
	 * 
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/login")
	public boolean loginMember(@RequestBody MemberDTO memberDTO,
			HttpSession session) {

		// 이메일로 회원여부 확인
		MemberDTO findedMember = memberService.findMemberByEmail(memberDTO.getEmail());
		if (findedMember == null) {
			// 회원이 없는 경우
			return false;
		}
		// 아이디가 존재하고, 비밀번호가 일치하는 경우
		if (memberDTO.getPw().equals(findedMember.getPw())) {
			// 멤버 아이디를 세션에 바운딩
			session.setAttribute("memberIdx", findedMember.getMemberIdx());
			return true;
		}
		return false;
	}

	/**
	 * 로그아웃 처리
	 * 
	 * @return
	 */
	@PostMapping("/logout")
	public boolean logoutMember(HttpSession session) {

		// 로그인이 아닐 시
		if (session.getAttribute("memberId") == null) {
			return false;
			// 로그인한 상태일 때
		} else {
			session.removeAttribute("memberId");
			return true;
		}
	}
}
