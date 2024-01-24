package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import jakarta.servlet.http.HttpSession;
import service.PlannerService;

@Controller
@RequestMapping("/api")
public class PlannerController {
	
	@Autowired
	@Qualifier("")
	PlannerService service;
	
	//체크리스트 데이터 호출
	@GetMapping("/planner")
	public ModelAndView selectChecklist(HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
				
		//체크리스트 호출
		List<String> checklist = service.selectAllChecklist(memberIdx); 
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("checklist", checklist);
		mv.setViewName("Checklist");
		
		return mv;
	}
	
	
	//해당 날짜 일정 데이터 호출
	@PostMapping("/planner/date1={day1}&date2={day2}")
	@ResponseBody
	public Map<Integer, String> selectSchedule(@PathVariable Integer day1, 
			@PathVariable Integer day2, HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//선택된 날짜 저장
		List<Integer> days = new ArrayList<Integer>();
		for(int i=day1; i<=day2; i++) {
			days.add(i);
		}
		
		//선택된 날짜에 해당하는 스케줄 호출
		Map<Integer, String> schedulelist = new HashMap<Integer, String>(); //전체 스케줄 리스트
		String schedule; //하루에 대한 스케줄(String)
		for (Integer oneday : days) {
			schedule = service.selectSchedule(memberIdx, oneday);
			schedulelist.put(oneday, schedule);
		}
		
		return schedulelist;
	}
	
	//체크리스트 저장
	@PostMapping("/planner/checklist/issave")
	@ResponseBody
	public void isSaveChecklist(@RequestBody String content, HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//현재 저장된 checklist가 있는지 확인(해당 list_idx 확인)
		int isSave = service.selectChecklistIsSave(memberIdx);
		if(isSave > 0) { //저장된 checklist가 있는 경우 update
			service.updateChecklist(content, isSave);
		}
		else { //저장된 checklist가 없는 경우 insert
			service.insertChecklist(content, memberIdx);
		}
	}
	
	//스케줄 저장
	@PostMapping("/planner/schedule/issave")
	@ResponseBody
	public void isSaveSchedule(@RequestBody String content, @RequestBody String date, 
			HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//현재 날짜에 저장된 스케줄이 있는지 확인(해당 plan_idx 확인)
		int isSave = service.selectScheduleIsSave(memberIdx, date);
		if(isSave > 0) { //저장된 schedule이 있는 경우 update
			service.updateSchedule(content, isSave);
		}
		else { //저장된 schedule가 없는 경우 insert
			service.insertSchedule(content, date, memberIdx);
		}
	}
	
	
	
}
