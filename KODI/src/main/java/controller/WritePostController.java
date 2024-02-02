package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.WritePostDTO;
import jakarta.servlet.http.HttpSession;
import service.WritePostService;

@Controller
@RequestMapping("/api")
public class WritePostController {
	
	@Autowired
	@Qualifier("writepostservice")
	WritePostService writeservice;
	
	@GetMapping("/post/write")
	public ModelAndView writePost() {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("WritePost");
		
		return mv;
	}
	
	//게시물 작성 페이지
	@PostMapping("/post/issave")
	public void isWrite(WritePostDTO writePostDTO, HttpSession session) 
			throws IllegalStateException, IOException {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer myMemberIdx = Integer.parseInt(sessionIdx);
		System.out.println(myMemberIdx);
		
		//이미지 파일 이름 저장
		List<String> fileName = new ArrayList<String>();
		//받아온 파일들 저장
		MultipartFile file[] = writePostDTO.getImagePost();
		//이미지 파일들 로컬에 저장
		String fileDir = "C:/FullStack/파이널 프로젝트/git/KODI_project/KODI/src/main/resources/static/image/db/";
		String imagePath = "";
		for(MultipartFile data : file) {
			imagePath = fileDir + data.getOriginalFilename();
			fileName.add(data.getOriginalFilename());
			data.transferTo(new File(imagePath));
		}
		System.out.println(writePostDTO.getTitle());
		System.out.println(writePostDTO.getContent());
		System.out.println(writePostDTO.getCategory());
		System.out.println(writePostDTO.getGrade());
		System.out.println(writePostDTO.getAddress());
		System.out.println(writePostDTO.getPostTags());
		System.out.println(fileName.toString());
		writeservice.insertPost(writePostDTO, fileName, myMemberIdx);
		
//		return "게시물이 성공적으로 작성되었습니다.";
	}
	
}
