package controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api")
public class PageRequestController {
  /**
   * GET 회원가입 페이지 (/api/register)
	 * GET 로그인 페이지 (/api/login)
   */

  /**
	 * 회원가입 페이지 요청
	 * @return
	 */
	@GetMapping("/register")
	public String registerMember() {
		return "Register";
	}
  /**
	 * 로그인 페이지 요청
	 * 
	 * @return
	 */
	@GetMapping("/login")
	public String loginMember() {
		return "Login";
	}

}
