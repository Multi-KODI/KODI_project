package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.ChatMsgDTO;
import service.LiveChatService;

@Controller
@RequestMapping("/api")
public class LiveChatController {
	@Autowired
	@Qualifier("livechatservice")
	LiveChatService service;
	
	/**
	 * 과거 채팅방 메시지 조회 API
	 * @param chatIdx
	 * @return 과거 채팅방 메시지 리스트
	 */
	@GetMapping("/chatroom/{chatIdx}")
	public ModelAndView liveChat(@PathVariable int chatIdx) {
		List<ChatMsgDTO> allChatMsg = service.selectAllChatMsg(chatIdx);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("allChatMsg", allChatMsg);
		mv.setViewName("LiveChat");
		
		return mv;
	}
}
