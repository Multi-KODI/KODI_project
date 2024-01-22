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

import dto.ReadPostOneDTO;
import service.ModifyPostService;
import service.ReadPostOneService;

@Controller
@RequestMapping("/api")
public class ModifyPostController {
	
	@Autowired
	@Qualifier("readpostoneservice")
	ReadPostOneService oneservice;
	
	@Autowired
	@Qualifier("modifypostservice")
	ModifyPostService modifyservice;
	
	//게시물 수정 페이지
	@GetMapping("/post/modify/{postIdx}")
	public ModelAndView ModifyPost(@PathVariable int postIdx) {
		//게시물 하나에 대한 데이터
		ReadPostOneDTO readPostOne = oneservice.getReadPostOne(postIdx);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("readPostOne", readPostOne);
		mv.setViewName("Modify");
		
		return mv;
	}
	
	@PostMapping("/post/isupdate")
	@ResponseBody
	public String isUpdate(@RequestBody ReadPostOneDTO post) {
		return modifyservice.UpdatePost(post);
	}
	
}
