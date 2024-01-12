package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.AdminDAO;
import dto.PostDTO;

@Service("adminservice")
public class AdminService {
	
	@Autowired
	@Qualifier("admindao")
	private AdminDAO adminDAO;
	
	//전체 게시글 조회
	public List<PostDTO> findAllPosts() {
		List<PostDTO> posts = adminDAO.findAllPosts();
		return posts;
	}

	//게시물 아이디로 검색
	public PostDTO findPostByIdx(int postIdx) {
		PostDTO post = adminDAO.findPostByIdx(postIdx);
		return post;
	}

	//게시물 삭제
	public void deletePost(int postIdx) {
		adminDAO.deletePost(postIdx);
	}
}
