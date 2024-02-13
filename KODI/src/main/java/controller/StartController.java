package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class StartController {
    @GetMapping("/")
    public ModelAndView start(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        
        // 세션값 여부
        if(session.getAttribute("memberIdx") != null) {
            mv.addObject("isSession", true);
            mv.setViewName("redirect:/api/home");
        } else {
            mv.addObject("isSession", false);
            mv.setViewName("Start");
        }
        return mv;
    }
}
