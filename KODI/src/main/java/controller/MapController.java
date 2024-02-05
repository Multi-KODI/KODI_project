package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import service.MapService;

@Controller
@RequestMapping("/api")
public class MapController {
	
	@Autowired
	@Qualifier("mapservice")
	MapService service;
	
	@GetMapping("/map")
	public ModelAndView myMap() {
		
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Map");
		return mv; 
	}
	
	@PostMapping("/map/marking")
	@ResponseBody
	public List<String> selectMarking(@RequestParam("marking") String marking, HttpSession session) {
		System.out.println(marking);
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer myMemberIdx = Integer.parseInt(sessionIdx);
		List<String> markList = new ArrayList<String>();
		
		if(marking.equals("myMark")) {
			//내가 저장한 게시글들의 idx
			List<Integer> myPostIdxs = service.selectMyPostIdx(myMemberIdx);
			
			for(Integer data : myPostIdxs) {
				//저장된 게시글들의 주소
				String address = service.selectPostAddress(data);
				markList.add(address);
			}
		}
		
		if(marking.equals("friendMark")) {
			//나의 친구들(서로 친구)의 idx
			List<Integer> myFriendsIdx = service.selectMyFriendIdx(myMemberIdx);
			
			//나의 친구들이 저장한 게시글들의 idx
			List<Integer> friendsPostIdx = new ArrayList<Integer>();
			for(Integer data : myFriendsIdx) {
				List<Integer> postIdx = service.selectFriendPostIdx(data);
				//friendsPostIdx에 저장
				for(Integer idx : postIdx) {
					//post_idx가 중복되는 경우 제외
					if(!friendsPostIdx.contains(idx)) {
						friendsPostIdx.add(idx);
					}
				}
			}
			
			//저장된 게시글들의 idx를 기반으로 주소 가져오기
			for(Integer post : friendsPostIdx) {
				String address = service.selectPostAddress(post);
				markList.add(address);
			}
		}
		
		System.out.println(markList.toString());
		
		return markList;
	}

}
