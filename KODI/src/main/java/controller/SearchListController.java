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
import org.springframework.web.servlet.ModelAndView;

import dto.ReadMemberAllDTO;
import dto.ReadPostAllDTO;
import jakarta.servlet.http.HttpSession;
import service.SearchMemberListService;
import service.SearchPostListService;

@Controller
@RequestMapping("/api")
public class SearchListController {

    @Autowired
    @Qualifier("searchpostlistservice")
    SearchPostListService postservice;

    @Autowired
    @Qualifier("searchmemberlistservice")
    SearchMemberListService memberservice;

    @GetMapping("/search")
    public ModelAndView searchList(
        @RequestParam String filter,
        @RequestParam String question,
        HttpSession session
    ) {
        ModelAndView mv = new ModelAndView();

        // sql문에서 like 조건에 해당하는 형태로 만들기 위해
        question = "%" + question + "%";

        // filter에 따른 구분(게시글인지 사용자인지)
        if (filter.equals("게시글")) {
            // question에 해당하는 게시글 idx 받아오기
            List<Integer> readPostAllIdx = postservice.getReadPostAllIdx(question);

            // 받아온 idx에 대한 게시글의 정보들 추출
            List<ReadPostAllDTO> readPostAll = new ArrayList<ReadPostAllDTO>();
            for (int i = 0; i < readPostAllIdx.size(); i++) {
                ReadPostAllDTO readPostAllone = postservice.getReadPostAll(readPostAllIdx.get(i));
                readPostAll.add(readPostAllone);
            }

            mv.addObject("readPostAll", readPostAll);
            mv.setViewName("/SearchList/SearchListPost");
            
            
        } else if (filter.equals("사용자")) {
            // question에 해당하는 사용자 idx 받아오기
            List<Integer> readMemberAllIdx = memberservice.getReadMemberAllIdx(question);

            // 세션에서 나의 member_idx 받아오기
            //String sessionIdx = (String)session.getAttribute("memberIdx");
    		String sessionIdx = "1";
    		Integer memberIdx = Integer.parseInt(sessionIdx);

            if (memberIdx != null) {
                List<ReadMemberAllDTO> readMemberAll = new ArrayList<ReadMemberAllDTO>();
                for (int i = 0; i < readMemberAllIdx.size(); i++) {
                	//나에 대한 검색은 제외
                	if(readMemberAllIdx.get(i) != memberIdx) {
                		ReadMemberAllDTO readMemberAllone = memberservice.getReadMemberAll(readMemberAllIdx.get(i), memberIdx);
                		readMemberAll.add(readMemberAllone);
                	}
                }
                mv.addObject("readMemberAll", readMemberAll);
                mv.setViewName("/SearchList/SearchListMember");
            } 
        }

        return mv;
    }
    
    //친구 관련 버튼(친추 or 친추취소 or 친추수락) 클릭시 
    @PostMapping("/search/isClick")
    public void isClickFriend(
    		@RequestParam("clickState") String clickState, 
    		@RequestParam("friendMemberIdx") int friendMemberIdx,
    		HttpSession session) {
    	// 세션에서 나의 member_idx 받아오기
        //String sessionIdx = (String)session.getAttribute("memberIdx");
		String sessionIdx = "1";
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//버튼 상태에 따라 구분
    	if(clickState == "친구 삭제") { //친구인 상태
    		memberservice.deleteFriend(memberIdx, friendMemberIdx);
    	}
    	else if(clickState == "친구 요청") { //친구신청이 가능한 상태
    		memberservice.insertFriendRequest(memberIdx, friendMemberIdx);
    	}
    	else if(clickState == "요청 취소") { //친구 요청을 한 상태
    		memberservice.deleteFriend(memberIdx, friendMemberIdx);
    	}
    	else if(clickState == "요청 수락") { //친구 요청을 받은 상태
    		memberservice.updateFriendRequest(memberIdx, friendMemberIdx);
    	}
    	else if(clickState == "요청 삭제") { //친구 요청을 받은 상태
    		memberservice.deleteFriend(memberIdx, friendMemberIdx);
    	}
    }
}
