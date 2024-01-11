package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.ChatListDTO;
import dto.ChatRq;
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
	@GetMapping("/chatlist/{memberIdx}")
	public ModelAndView chatList(@PathVariable int memberIdx) {
		ChatListDTO chatListInfo = service.getChatListInfo(memberIdx);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("chatListInfo", chatListInfo);
		mv.setViewName("ChatList");
		
		return mv;
	}
	
	/**
	 * 채팅방 여부 조회 API
	 * @param clickChatInfo
	 * @return 채팅방 여부
	 */
	@PostMapping("/chatlist/clickchat")
	@ResponseBody
	public boolean clickChat(@RequestBody ChatRq chatInfo) {		
		return service.selectChatRoom(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
	/**
	 * 채팅방 번호 조회 API
	 * @param chatInfo
	 * @return 채팅방 번호
	 */
	@PostMapping("/chatlist/chatidx")
	@ResponseBody
	public int searchChatIdx(@RequestBody ChatRq chatInfo) {		
		return service.selectChatIdx(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
	/**
	 * 새로운 채팅방 생성 후 채팅방 번호 조회 API
	 * @param chatInfo
	 * @return 생성한 채팅방 번호
	 */
	@PostMapping("/chatlist/createchatroom")
	@ResponseBody
	public int createChatRoom(@RequestBody ChatRq chatInfo) {		
		service.createChatRoom(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
		return service.selectChatIdx(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
}
