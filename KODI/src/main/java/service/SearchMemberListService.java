package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.SearchMemberListDAO;
import dto.ReadMemberAllDTO;

@Service("searchmemberlistservice")
public class SearchMemberListService {
	
	@Autowired
	@Qualifier("searchmemberlistdao")
	SearchMemberListDAO dao;
	
	//검색어에 해당하는 memberIdx들 조회
	public List<Integer> getReadMemberAllIdx(String question) {
		//검색어를 포함하는 member_name들에 대한 memberIdx들
		List<Integer> memberIdxs = dao.selectMemberIdx(question);
		
		return memberIdxs;
	}
	
	//멤버 하나에 대한 필요 정보 조회
	public ReadMemberAllDTO getReadMemberAll(int memberIdx, int myMemberIdx) {
		//멤버 이름 조회
		String memberName = dao.selectMemberName(memberIdx);
		
		//해당 멤버의 flag_idx 조회
		int flagIdx = dao.selectFlagIdx(memberIdx);
		//조회한 flag_idx의 국가이름(country) 조회
		String country = dao.selectMemberCountry(flagIdx);
		
		//내가 친구요청을 보낸 사람인지 확인하기 위한 나의 friendMemberIdx 리스트 조회
		List<Integer> friendMemberIdx = dao.selectFriendMemberIdx(myMemberIdx);
		
		String friendStatus = "";
		//만약 나의 friendMemberIdx 리스트에 조회 요청한 해당 memberIdx가 있다면
		if(friendMemberIdx.contains(memberIdx)) {
			//member_idx가 myMemberIdx이고, friend_member_idx가 memberIdx인 칼럼의 friend_idx값 조회 
			int friendIdx = dao.selectFriendIdx(myMemberIdx, memberIdx);
			
			//조회한 friendIdx의 isFriend가 true인지 false인지 조회
			boolean isFriend = dao.selectIsFriend(friendIdx);
			if(isFriend == true) {
				//member_idx가 memberIdx이고, friend_member_idx가 myMemberIdx인 칼럼의 friend_idx값 조회
				friendIdx = dao.selectFriendIdx(memberIdx, myMemberIdx);
				
				isFriend = dao.selectIsFriend(friendIdx);
				//둘다 is_friend가 true인 경우
				if(isFriend == true) {
					friendStatus = "친구"; 
				}
				//나만 is_friend가 true인 경우
				else {
					friendStatus = "신청취소";
				}
			}
		}
		else {
			friendStatus = "친구신청";
		}
		
		return new ReadMemberAllDTO(memberIdx, memberName, country, friendStatus);
	}
	
}
