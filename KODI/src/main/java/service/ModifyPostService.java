package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ModifyPostDAO;
import dto.ReadPostOneDTO;

@Service("modifypostservice")
public class ModifyPostService {
	
	@Autowired
	@Qualifier("modifypostdao")
	ModifyPostDAO dao;
	
	//게시글 수정
	//@return 게시글 수정 성공 여부(1|0)
	public String UpdatePost(ReadPostOneDTO post) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int postIdx = post.getPostInfo().getPostIdx();
		String category = post.getPostInfo().getCategory();
		double grade = post.getPostInfo().getGrade();
		String title = post.getPostInfo().getTitle();
		String content = post.getPostInfo().getContent();
		String address = post.getPostInfo().getAddress();
		List<String> tags = post.getPostTags();
		List<String> images = post.getPostImages();
		
		//수정 실패 요건 확인
		if(title.isBlank()) {
			return "제목이 비어있어 수정에 실패하였습니다.";
		}
		else if(content.isBlank()) {
			return "내용이 비어있어 수정에 실패하였습니다.";
		}
		else if(address.isBlank()) {
			return "주소가 비어있어 수정에 실패하였습니다.";
		}
		
		map.put("postIdx", postIdx);
		map.put("category", category);
		map.put("grade", grade);
		map.put("title", title);
		map.put("content", content);
		map.put("address", address);
		
		dao.updatePost(map);
		
		//기존에 저장되어있는 태그의 tag_idx값들 저장
		List<Integer> tagIdxs = dao.selectTag(postIdx);
		//기존에 저장되어있던 해당 게시글의 태그 수
		int tagsNum = dao.selectTagNum(postIdx);
		//태그 수정
		UpdateTag(map, postIdx, tags, tagIdxs, tagsNum);
		
		//기존에 저장되어있는 이미지의 image_idx값들 저장
		List<Integer> imageIdxs = dao.selectImage(postIdx);
		//기존에 저장되어있던 해당 게시글의 이미지 수
		int imagesNum = dao.selectImageNum(postIdx);
		//이미지 수정
		UpdateImage(map, postIdx, images, imageIdxs, imagesNum);
		
		return "수정을 완료하였습니다.";
	}
	
	
	private void UpdateImage(HashMap<String, Object> map, int postIdx, List<String> images, 
			List<Integer> imageIdxs, int imagesNum) {
		//insert용 update용 delete용 image(src) 리스트들 구분
		List<String> insertImages = new ArrayList<String>();
		List<String> updateImages = new ArrayList<String>();
		List<Integer> deleteImages = new ArrayList<Integer>();
		
		//새로 저장할 이미지 수(images.size)와 기존에 저장되어있는 이미지 수(imagesNum)를 비교
		if(images.size() > imagesNum) { //새로 저장할 이미지가 더 많은 경우
			//기존의 이미지에는 update
			for(int i=0; i<imagesNum; i++) {
				updateImages.add(images.get(i));
			}
			map.clear();
			map.put("imageIdxs", imageIdxs);
			map.put("updateImages", updateImages);
			dao.updateImage(map);
			//추가된 이미지에는 insert
			for(int i=imagesNum; i<images.size(); i++) {
				insertImages.add(images.get(i));
			}
			map.clear();
			map.put("postIdx", postIdx);
			map.put("insertImages", insertImages);
			dao.insertImage(map);
		}
		else if(images.size() == imagesNum) { //새로 저장할 이미지와 기존의 이미지 수가 같은 경우
			//기존의 이미지와 수가 같으므로 update
			for(int i=0; i<imagesNum; i++) {
				updateImages.add(images.get(i));
			}
			map.clear();
			map.put("imageIdxs", imageIdxs);
			map.put("updateImages", updateImages);
			dao.updateImage(map);
		}
		else {
			//기존의 이미지에는 update
			for(int i=0; i<images.size(); i++) {
				updateImages.add(images.get(i));
			}
			map.clear();
			map.put("imageIdxs", imageIdxs);
			map.put("updateImages", updateImages);
			dao.updateImage(map);
			//남은 이미지에는 delete
			for(int i=images.size(); i<imagesNum; i++) {
				deleteImages.add(imageIdxs.get(i));
			}
			map.clear();
			map.put("deleteImages", deleteImages);
			dao.deleteImage(map);
		}
	}
	
	
	private void UpdateTag(HashMap<String, Object> map, int postIdx, List<String> tags, 
			List<Integer> tagIdxs, int tagsNum) {
		//insert용 update용 delete용 tag 리스트들 구분
		List<String> insertTags = new ArrayList<String>();
		List<String> updateTags = new ArrayList<String>();
		List<Integer> deleteTags = new ArrayList<Integer>();
		
		//새로 저장할 태그 수(tags.size)와 기존에 저장되어있는 태그 수(tagsNum)를 비교
		if(tags.size() > tagsNum) { //새로 저장할 태그가 더 많은 경우
			//기존의 태그에는 update
			for(int i=0; i<tagsNum; i++) {
				updateTags.add(tags.get(i));
			}
			map.clear();
			map.put("tagIdxs", tagIdxs);
			map.put("updateTags", updateTags);
			dao.updateTag(map);
			//추가된 태그에는 insert
			for(int i=tagsNum; i<tags.size(); i++) {
				insertTags.add(tags.get(i));
			}
			map.clear();
			map.put("postIdx", postIdx);
			map.put("insertTags", insertTags);
			dao.insertTag(map);
		}
		else if(tags.size() == tagsNum){ //새로 저장할 태그와 기존의 태그의 수가 같은 경우
			//기존의 태그와 수가 같으므로 update
			for(int i=0; i<tagsNum; i++) {
				updateTags.add(tags.get(i));
			}
			map.clear();
			map.put("tagIdxs", tagIdxs);
			map.put("updateTags", updateTags);
			dao.updateTag(map);
		}
		else {
			//기존의 태그에는 update
			for(int i=0; i<tags.size(); i++) {
				updateTags.add(tags.get(i));
			}
			map.clear();
			map.put("tagIdxs", tagIdxs);
			map.put("updateTags", updateTags);
			dao.updateTag(map);
			//남은 태그에는 delete
			for(int i=tags.size(); i<tagsNum; i++) {
				deleteTags.add(tagIdxs.get(i)); 
			}
			map.clear();
			map.put("deleteTags", deleteTags);
			dao.deleteTag(map);
		}
	}
	
}
