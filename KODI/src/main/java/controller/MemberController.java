package controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.MemberDTO;
import jakarta.servlet.http.HttpSession;
import service.EmailService;
import service.MemberService;

@Controller
@RequestMapping("/api")
public class MemberController {

	@Autowired
	@Qualifier("memberService")
	private MemberService memberService;
	
	@Autowired
	@Qualifier("emailService")
	private EmailService emailService;
	
	@PostMapping("/email") // 이메일 전송
	@ResponseBody
	public boolean sendEmail(@RequestBody MemberDTO memberDTO, HttpSession session){
		MemberDTO existingMember = memberService.findMemberByEmail(memberDTO.getEmail()); 
		//중복 유저 확인
		if(existingMember != null) {
			return false;
		}
		
		//OTP 생성
		Random r = new Random();
		String otp = String.format("%06d", r.nextInt(100000));
		
		//OTP 비교를 위해 세션에 바운딩
		session.setAttribute("otp", otp);

		//이메일 발송
		String subject = "Email Verfication";
		String body = "Your verification OPT is " + otp;
		emailService.sendEmail(memberDTO.getEmail(), subject, body);
		return true;
	}
	
	@PostMapping("/verify") //이메일 검증
	@ResponseBody
	public boolean verifyEmail(String otp, HttpSession session){
		
		//사용자가 입력한 OTP와 세션의 OTP 비교
		if(session.getAttribute(otp).equals(otp)) {
			return true;
		}
		return false;
	}
	
	/**
	 * 회원가입 페이지 요청
	 * @return
	 */
	@GetMapping("/register") 
	public String registerMember(){
		return "Register";
	} 
	
	/**
	 * 회원가입 처리
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/register") 
	public boolean registerMember(@RequestBody MemberDTO memberDTO, HttpSession session){
		MemberDTO findedMember = memberService.findMemberByEmail(memberDTO.getEmail());
		
		//기존에 멤버가 없을 때 회원등록
		if(findedMember == null) {
			memberService.registerMember(memberDTO);

			//멤버 아이디를 세션에 바운딩
			session.setAttribute("memberIdx", memberDTO.getMemberIdx());
			return true;
		}
		return false;
	}
	
	/**
	 * 로그인 페이지 요청
	 * @return
	 */
	@GetMapping("/login") 
	public String loginMember(){
		return "Login";
	} 
	
	/**
	 * 로그인 처리
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/login") 
	public boolean loginMember(@RequestBody MemberDTO memberDTO, 
			HttpSession session) {
				
		//이메일로 회원여부 확인
		MemberDTO findedMember = memberService.findMemberByEmail(memberDTO.getEmail());
		if(findedMember == null) {
			//회원이 없는 경우
			return false;
		}
		//아이디가 존재하고, 비밀번호가 일치하는 경우
		if(memberDTO.getPw().equals(findedMember.getPw())) {
			//멤버 아이디를 세션에 바운딩
			session.setAttribute("memberIdx", findedMember.getMemberIdx());
			return true;
		}
		return false;
	}
}
