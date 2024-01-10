package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import dto.PostDTO;

@Repository("admindao")
@Mapper
public interface AdminDAO {
  
  //전체 게시물 가져오기
	@Select("SELECT * FROM posts")
	List<PostDTO> findAllPosts();

	//게시물 아이디로 검색하기
	@Select("SELECT * FROM posts WHERE post_idx=#{postIdx}")
	PostDTO findPostByIdx(int postIdx);
  
	//게시물 삭제하기
	@Delete("DELETE * FROM posts WHERE post_idx=#{postIdx}")
	int deletePost(int postIdx);
}
