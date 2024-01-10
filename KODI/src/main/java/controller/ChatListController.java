package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/api")
public class ChatListController {

	@GetMapping("/chat/{memberIdx}")
	public ModelAndView chatList(@PathVariable int memberIdx) {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("ChatList");
		
		return mv;
	}
	
}
