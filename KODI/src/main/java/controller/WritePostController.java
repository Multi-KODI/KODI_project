package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.WritePostDTO;
import jakarta.servlet.http.HttpSession;
import service.WritePostService;

@Controller
@RequestMapping("/api")
public class WritePostController {
	
	@Autowired
	@Qualifier("writepostservice")
	WritePostService writeservice;
	
	@GetMapping("/post/write")
	public ModelAndView writePost() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("WritePost");
		
		return mv;
	}
	
	//게시물 작성 페이지
	@PostMapping("/post/issave")
	@ResponseBody
	public String isWrite(@RequestBody WritePostDTO writePostDTO, HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer myMemberIdx = Integer.parseInt(sessionIdx);
		
		return writeservice.insertPost(writePostDTO, myMemberIdx);
		
//		return "게시물이 성공적으로 작성되었습니다.";
	}
	
}
