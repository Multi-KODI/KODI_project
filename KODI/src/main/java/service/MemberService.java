package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDAO;
import dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	//회원등록
	public void registerMember(MemberDTO memberDTO) {
		memberDAO.registerMember(memberDTO);
	}
	
	//이메일로 회원찾기
	public MemberDTO findMemberByEmail(String email) {
		MemberDTO findedMember = memberDAO.findMemberByEmail(email);
		return findedMember;
	}
	
}
