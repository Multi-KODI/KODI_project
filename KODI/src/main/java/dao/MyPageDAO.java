package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import dto.PostDTO;

@Repository("mypagedao")
@Mapper
public interface MyPageDAO {
	
	//나의 전체글 가져오기 SQL문
	@Select("SELECT * FROM posts WHERE member_idx=#{memberIdx}")
	List<PostDTO> readMyPosts(int memberIdx);
}
