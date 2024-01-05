package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api")
public class ReadPostOne {
	
	@GetMapping("/post")
	public String test() {
		return "ReadPostOne";
	}
}
