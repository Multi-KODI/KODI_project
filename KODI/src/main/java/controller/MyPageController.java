package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.FlagDTO;
import dto.FriendDTO;
import dto.MemberDTO;
import dto.MemberFlagDTO;
import dto.PostDTO;
import dto.PostImageDTO;
import jakarta.servlet.http.HttpSession;
import service.MemberService;
import service.MyPageService;

@Controller
@RequestMapping("/api")
public class MyPageController {

	/**
	 * POST 비밀번호 인증 (/api/verifyPw) DATA: 유저 입력 비밀번호 POST 회원탈퇴
	 * (/api/withdrawMember)DATA: X POST 회원정보 수정 (/api/updateMemberInfo) DATA: 변경할
	 * 비밀번호, 닉네임, 국적 GET 마이페이지 요청 (/api/myPage) DATA: X
	 */

	@Autowired
	private MemberService memberService;

	@Autowired
	private MyPageService myPageService;

	/**
	 * 회원탈퇴 시 비밀번호 인증
	 * 
	 * @param session
	 * @return
	 */
	@PostMapping("/verifyPw")
	public ResponseEntity<String> verifyPw(HttpSession session, @RequestBody MemberDTO memberDTO) {
		String memberSessionIdx = (String) session.getAttribute("memberIdx");

		// 세션에 로그인이 되어있는지 확인
		// 로그인이 안되어 있을 때
		if (memberSessionIdx == null) {
			return new ResponseEntity<>("로그인 정보가 없습니다", HttpStatus.BAD_REQUEST);

			// 로그인이 되어 있을 때
		} else {

			// 비밀번호를 받아옴
			Integer memberIdx = Integer.parseInt(memberSessionIdx);
			String password = memberService.findMemberByIdx(memberIdx).getPw();

			// 비밀번호가 일치하는 경우
			if (memberDTO.getPw().equals(password)) {
				return new ResponseEntity<>("회원정보 확인 완료", HttpStatus.OK);

				// 비밀번호가 불일치하는 경우
			} else {
				return new ResponseEntity<>("비밀번호가 일치하지 않습니다", HttpStatus.BAD_REQUEST);
			}
		}
	}

	/**
	 * 회원탈퇴 처리
	 * 
	 * @param session
	 * @return
	 */
	@PostMapping("/withdrawMember")
	public ResponseEntity<String> withdrawMember(HttpSession session) {

		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
		if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
			memberService.withdrawMember(memberIdx);
			return new ResponseEntity<>("회원탈퇴가 완료되었습니다", HttpStatus.OK);
			// 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
		} else {
			return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 회원 수정창 요청
	 * 
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@GetMapping("/update")
	public ModelAndView updateModal(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<FlagDTO> allFlags = myPageService.allFlags();
		mv.addObject("flags", allFlags);

		String memberIdx = (String) session.getAttribute("memberIdx");
		MemberDTO member = memberService.findMemberByIdx(Integer.parseInt(memberIdx));
		mv.addObject("member", member);
		mv.setViewName("/MyPage/Modify");
		return mv;
	}

	/**
	 * 회원정보 수정
	 * 
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/updateMemberInfo")
	public ResponseEntity<String> updateMemberInfo(@RequestBody MemberDTO memberDTO, HttpSession session) {

		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
		if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
			// 기존 비밀번호 유지 처리
			if ("unchanged".equals(memberDTO.getPw())) {
				// 기존 비밀번호를 가져와서 설정
				String existingPassword = memberService.findMemberByIdx(memberIdx).getPw();
				memberDTO.setPw(existingPassword);
			}

			memberDTO.setMemberIdx(memberIdx);
			memberService.updateMemberInfo(memberDTO);
			return new ResponseEntity<>("회원정보가 업데이트 되었습니다", HttpStatus.OK);

		} else {
			// 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
			return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 마이페이지 요청
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/mypage")
	public ModelAndView readMyPosts(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
		if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
			// 나의 전체글 가져오기
			List<PostDTO> posts = myPageService.readMyPosts(memberIdx);
			if (posts != null) {
				mv.addObject("posts", posts);
			}
			List<PostImageDTO> images = myPageService.allImages();
			mv.addObject("images", images);
			mv.setViewName("/MyPage/MyPage");
			return mv;

			// 로그인이 안돼어 있거나 회원이 존재하지 않는 경우
		} else {
			return null;
		}
	}

	/**
	 * 나를 추가한 친구
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/follower")
	public ModelAndView follower(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 나를 추가한 친구
		List<FriendDTO> otherSideFriendsList = myPageService.otherSideFriends(memberIdx);
		List<Integer> resultList3 = new ArrayList<>();
		for (FriendDTO otherSideFriend : otherSideFriendsList) {
			resultList3.add(otherSideFriend.getMemberIdx());
		}

		if (!resultList3.isEmpty()) {
			List<MemberDTO> otherSideFriends = myPageService.friendInfo(resultList3);
			System.out.println(otherSideFriends);
			mv.addObject("otherSideFriends", otherSideFriends);
		}
		List<FlagDTO> flags = myPageService.allFlags();
		mv.addObject("flags", flags);
		mv.setViewName("/MyPage/FollowerFriendList");
		return mv;

	}

	/**
	 * 내가 추가한 친구
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/following")
	public ModelAndView following(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 내가 추가한 친구
		List<FriendDTO> mySideFriendsList = myPageService.mySideFriends(memberIdx);
		List<Integer> resultList2 = new ArrayList<>();
		for (FriendDTO mySideFriend : mySideFriendsList) {
			resultList2.add(mySideFriend.getFriendMemberIdx());
		}

		if (!resultList2.isEmpty()) {
			List<MemberDTO> mySideFriends = myPageService.friendInfo(resultList2);
			mv.addObject("mySideFriends", mySideFriends);
			System.out.println(mySideFriends);
		}
		List<FlagDTO> flags = myPageService.allFlags();
		mv.addObject("flags", flags);
		mv.setViewName("/MyPage/FollowingFriendList");
		return mv;
	}

	/**
	 * 서로 친구
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/pair")
	public ModelAndView pair(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 전체친구
		List<FriendDTO> allFriendsList = myPageService.allFriends(memberIdx);
		List<Integer> resultList1 = new ArrayList<>();
		for (FriendDTO allFriend : allFriendsList) {
			resultList1.add(allFriend.getFriendMemberIdx());
		}
	
		if (!resultList1.isEmpty()) {
			List<MemberDTO> allFriends = myPageService.friendInfo(resultList1);
			System.out.println(allFriends);
			mv.addObject("allFriends", allFriends);
		}
		List<FlagDTO> flags = myPageService.allFlags();
		mv.addObject("flags", flags);
		mv.setViewName("/MyPage/PairFriendList");
		return mv;
	}

	/**
	 * 서로이웃 삭제
	 * 
	 * @return
	 */
	@GetMapping("/pair/delete/{memberIdx}")
	@ResponseBody
	public MemberFlagDTO pairDelete(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		myPageService.pairDelete(member_Idx, memberIdx);
		List<FlagDTO> flags = myPageService.allFlags();
		List<FriendDTO> allFriendsList = myPageService.allFriends(member_Idx);
		List<Integer> resultList1 = new ArrayList<>();
		for (FriendDTO allFriend : allFriendsList) {
			resultList1.add(allFriend.getFriendMemberIdx());
		}
		if (!resultList1.isEmpty()) {
			List<MemberDTO> allFriends = myPageService.friendInfo(resultList1);
			return new MemberFlagDTO(allFriends, flags);
		}
		return null;
	}

	/**
	 * 팔로잉 취소
	 * 
	 * @return
	 */
	@GetMapping("/following/delete/{memberIdx}")
	@ResponseBody
	public MemberFlagDTO deleteFollowing(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		myPageService.followingDelete(member_Idx, memberIdx);
		List<FlagDTO> flags = myPageService.allFlags();
		List<FriendDTO> mySideFriendsList = myPageService.mySideFriends(memberIdx);
		List<Integer> resultList2 = new ArrayList<>();
		for (FriendDTO mySideFriend : mySideFriendsList) {
			resultList2.add(mySideFriend.getFriendMemberIdx());
		}
		if (!resultList2.isEmpty()) {
			List<MemberDTO> mySideFriends = myPageService.friendInfo(resultList2);
			return new MemberFlagDTO(mySideFriends, flags);
		}
		return null;
	}

	/**
	 * 팔로워 수락
	 * 
	 * @return
	 */
	@GetMapping("/follower/accept/{memberIdx}")
	@ResponseBody
	public MemberFlagDTO acceptFollower(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		myPageService.followerAccept(member_Idx, memberIdx);
		myPageService.createNewFriend(member_Idx, memberIdx);
		List<FlagDTO> flags = myPageService.allFlags();
		List<FriendDTO> otherSideFriendsList = myPageService.otherSideFriends(memberIdx);
		List<Integer> resultList3 = new ArrayList<>();
		for (FriendDTO otherSideFriend : otherSideFriendsList) {
			resultList3.add(otherSideFriend.getMemberIdx());
		}

		if (!resultList3.isEmpty()) {
			List<MemberDTO> otherSideFriends = myPageService.friendInfo(resultList3);
			return new MemberFlagDTO(otherSideFriends, flags);
		}
		return null;
	}

	/**
	 * 팔로워 삭제
	 * @return
	 */
	@GetMapping("/follower/delete/{memberIdx}")
	@ResponseBody
	public MemberFlagDTO deleteFollower(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		myPageService.followerDelete(member_Idx, memberIdx);
		List<FlagDTO> flags = myPageService.allFlags();
		List<FriendDTO> otherSideFriendsList = myPageService.otherSideFriends(memberIdx);
		List<Integer> resultList3 = new ArrayList<>();
		for (FriendDTO otherSideFriend : otherSideFriendsList) {
			resultList3.add(otherSideFriend.getMemberIdx());
		}

		if (!resultList3.isEmpty()) {
			List<MemberDTO> otherSideFriends = myPageService.friendInfo(resultList3);
			return new MemberFlagDTO(otherSideFriends, flags);
		}
		return null;
	}
}