package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.ChatListDTO;
import service.ChatListService;

@Controller
@RequestMapping("/api")
public class ChatListController {
	@Autowired
	@Qualifier("chatlistservice")
	ChatListService service;

	/**
	 * 채팅 리스트 정보 조회 API
	 * @param memberIdx
	 * @return 전체 친구 리스트, 채팅방 리스트
	 */
	@GetMapping("/chat/{memberIdx}")
	public ModelAndView chatList(@PathVariable int memberIdx) {
		ChatListDTO chatListInfo = service.getChatListInfo(memberIdx);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chatListInfo", chatListInfo);
		mv.setViewName("ChatList");
		
		return mv;
	}
	
}
