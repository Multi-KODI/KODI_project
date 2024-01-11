package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.SearchMemberListService;
import service.SearchPostListService;

@Controller
@RequestMapping("/api")
public class SearchListController {
	
	@Autowired
	@Qualifier("searchpostlistservice")
	SearchPostListService searchpostservice;
	
	@Autowired
	@Qualifier("searchmemberlistservice")
	SearchMemberListService searchmemberservice;
	
	@GetMapping("/search?{filter}={question}")
	public ModelAndView searchList(@PathVariable String filter, @PathVariable String question) {
		
		//게시글을 검색하는 경우 (제목, 태그)
		if(filter.equals("게시글")) {
			
		}
		//사용자를 검색하는 경우
		else if(filter.equals("사용자")) {
			
		}
		
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}
	

}
