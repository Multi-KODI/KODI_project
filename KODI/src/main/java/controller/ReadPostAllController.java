package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.ReadPostAllDTO;
import service.ReadPostAllService;

@Controller
@RequestMapping("/api")
public class ReadPostAllController {
	
	@Autowired
	@Qualifier("readpostallservice")
	ReadPostAllService service;
	
	/* 게시글 조회
	 * return 게시글 데이터
	 * 게시글 idx, 제목, 이미지, 유저닉네임, 추천수, 위치(주소), 태그, 국기
	 */
	@GetMapping("/ReadPostAll")
	public ModelAndView readPostAll(/*@RequestParam("category") String category*/) {
		String category = "";
		// 처음 들어오는 경우
		if(category.length() == 0) {
			category = "맛집";
		}
		
		List<Integer> readPostAllIdx = service.getReadPostAllIdx(category);
		
		List<ReadPostAllDTO> readPostAll = new ArrayList<ReadPostAllDTO>();
		for(int i=0; i<readPostAllIdx.size(); i++) {
			ReadPostAllDTO readPostAllone = service.getReadPostAll(readPostAllIdx.get(i));
			readPostAll.add(readPostAllone);
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("ReadPostAll"); 
		mv.addObject("readPostAll", readPostAll);
		
		return mv;
	}

}
