package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	@RequestMapping("/map")
		String main(){
			return "/map";
		}

}
