package dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;

@Repository("memberdao")
@Mapper
public interface MemberDAO {
	//회원등록 SQL문
	@Insert("INSERT INTO members (email, pw, member_name, flag_idx) VALUES (#{email}, #{pw}, #{memberName}, #{flagIdx})")
	int registerMember(MemberDTO memberDTO);

	//이메일로 회원탐색 SQL문
	@Select("SELECT * FROM members WHERE email=#{email}")
	MemberDTO findMemberByEmail(String email);

	//아이디로 회원탐색 SQL문
	@Select("SELECT * FROM members WHERE member_idx=#{memberIdx}")
	MemberDTO findMemberByIdx(int memberIdx);

	//회원탈퇴 SQL문
	@Delete("DELETE * FROM members WHERE member_idx=#{memberIdx}")
	int withdrawMember(int memberIdx);

	//회원정보 업데이트 SQL문
	@Update("UPDATE members SET email = #{email}, pw = #{pw}, member_name = #{memberName} , flag_idx = #{flagIdx} WHERE memberIdx = {memberIdx}; ")
	int updateMemberInfo(MemberDTO memberDTO);

	//전체 회원 조회
	@Select("SELECT * from members")
	List<MemberDTO> findAllMembers();
}
