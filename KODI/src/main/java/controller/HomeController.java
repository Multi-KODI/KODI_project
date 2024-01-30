package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.VehicleDTO;
import service.HomeService;

@Controller
@RequestMapping("/api")
public class HomeController {
	@Autowired
	@Qualifier("homeservice")
	HomeService service;
	
	/**
	 * 홈페이지 API
	 * @return 교통수단 비용 리스트
	 */
	@GetMapping("/home")
	public ModelAndView home() {
		List<VehicleDTO> vehicleList = service.getVehicleList();

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("vehicleList", vehicleList);
		mv.setViewName("Home");
		
		return mv;
	}
	
	
	@GetMapping("/nonhome")
	public ModelAndView nonhome() {
		List<VehicleDTO> vehicleList = service.getVehicleList();

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("vehicleList", vehicleList);
		mv.setViewName("/Nonmember/NonmemberHome");
		
		return mv;
	}
	
}
