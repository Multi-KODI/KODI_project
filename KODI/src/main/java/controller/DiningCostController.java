package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import dto.DiningCostDTO;
import service.DiningCostService;

//@RestController
@Controller
@RequestMapping("/api")
public class DiningCostController {
	@Autowired
	@Qualifier("diningcostservice")
	DiningCostService service;
	
	/**
	 * 백엔드 테스트
	 * @return
	 */
	@GetMapping("/test")
	public List<DiningCostDTO> selectAllTest(){
		return service.selectAllCost();
	}
	@PostMapping("/test")
	public DiningCostDTO selectOneTest(String item) {
		return service.selectOneCost(item);
	}
	
	/**
	 * 전체 품목 외식비 정보 API (default)
	 * @return 품목별 외식비 리스트
	 */
	@GetMapping("/diningcost")
	public ModelAndView selectAllCost(){
		List<DiningCostDTO> list = service.selectAllCost();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("DiningCost");
		
		return mv;
	}
	
	/**
	 * 특정 품목 외식비 정보 API
	 * @param item
	 * @return 특정 품목 외식비
	 */
	@PostMapping("/diningcost")
	@ResponseBody
	public DiningCostDTO selectOneCost(String item) {
		return service.selectOneCost(item);
	}
	
	
}
