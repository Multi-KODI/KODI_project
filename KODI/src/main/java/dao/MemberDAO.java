package dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;

@Repository("memberdao")
@Mapper
public interface MemberDAO {
	//회원등록 SQL문
	@Insert("INSERT INTO members (email, pw, member_name, flag_idx) VALUES (#{email}, #{pw}, #{memberName}, #{flagIdx})")
	int registerMember(MemberDTO memberDTO);

	//회원탐색 SQL문
	@Select("SELECT * FROM members WHERE email=#{email}")
	MemberDTO findMemberByEmail(String email);
}
