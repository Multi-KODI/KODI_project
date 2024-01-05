package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.DiningCostDTO;
import service.DiningCostService;

@Controller
public class DiningCostController {
	@RequestMapping("/diningcost")
	String main(){
		return "/diningcost";
	}
	
	
	@Autowired
	@Qualifier("diningcostservice")
	DiningCostService service;

	@GetMapping("/api")
	public ModelAndView selectCost(){
		List<DiningCostDTO> list = service.selectCost();
		System.out.println(list);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("DiningCost");
		
		return mv;
	}
	
}
