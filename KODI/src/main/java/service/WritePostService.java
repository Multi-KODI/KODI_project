package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.WritePostDAO;
import dto.WritePostDTO;

@Service("writepostservice")
public class WritePostService {
	
	@Autowired
	@Qualifier("writepostdao")
	WritePostDAO dao;
	
	public String insertPost(WritePostDTO writePostDTO, int myMemberIdx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String title = writePostDTO.getTitle();
		String content = writePostDTO.getContent();
		String regdate = writePostDTO.getRegdate();
		String address = writePostDTO.getAddress();
		String category = writePostDTO.getCategory();
		double grade = writePostDTO.getGrade();
		List<String> postTags = writePostDTO.getPostTags();
		List<String> postImages = writePostDTO.getPostImages();
		
		//필수 작성요소 확인(제목, 내용, 주소)
		if(title.isBlank()) {
			return "제목이 비어있습니다. 제목을 작성해주세요.";
		}
		else if(content.isBlank()) {
			return "내용이 비어있습니다. 내용을 작성해주세요.";
		}
		else if(address.isBlank()) {
			return "주소가 비어있습니다. 주소를 작성해주세요.";
		}
		
		//게시글 작성내용 저장
		map.put("myMemberIdx", myMemberIdx);
		map.put("title", title);
		map.put("content", content);
		map.put("regdate", regdate);
		map.put("address", address);
		map.put("category", category);
		map.put("grade", grade);
		dao.insertPostInfo(map);
		
		//나의 게시글 중에서 가장 최근에 저장된 post_idx를 불러오기
		int postIdx = dao.selectPostIdx(myMemberIdx);

		//게시글 태그 저장
		map.clear();
		map.put("postIdx", postIdx);
		map.put("postTags", postTags);
		dao.insertPostTags(map);
		
		//게시글 이미지 저장
		map.clear();
		map.put("postIdx", postIdx);
		map.put("postImages", postImages);
		dao.insertPostImages(map);
		
		return "작성을 완료하였습니다.";
	}
	
	
	
}
