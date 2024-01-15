package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.AllChatDTO;
import dto.ChatMsgRq;
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
		List<AllChatDTO> allChatMsg = service.selectAllChatMsg(chatIdx);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("allChatMsg", allChatMsg);
		mv.addObject("chatIdx", chatIdx);
		
		mv.setViewName("LiveChat");
		
		return mv;
	}
	
	/**
	 * WebSocket 메시지 DB 저장 API
	 * @param chatMsgRq
	 * @return DB 저장 성공 여부(1|0)
	 */
	@PostMapping("/chatroom/savemsg")
	@ResponseBody
	public int saveMsg(@RequestBody ChatMsgRq chatMsgRq) {
		return service.saveChatMsg(chatMsgRq.getMemberIdx(), chatMsgRq.getChatIdx(), chatMsgRq.getContent());
	}
	
	/**
	 * 메시지 작성자명 조회 API
	 * @param memberIdx
	 * @return 메시지 작성자명
	 */
	@PostMapping("/chatroom/showmembername")
	@ResponseBody
	public String showMemberName(int memberIdx) {
		return service.showMemberName(memberIdx);
	}
	
}
