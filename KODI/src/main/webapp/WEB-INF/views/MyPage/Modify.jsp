<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/Modify.css">
<script src="/js/jquery-3.7.1.min.js"></script>

<title></title>

<style>
</style>
</head>

<body>
<div class="modifybox" id="modifyModal" tabindex="-1" role="dialog"
	aria-labelledby="modifyModalLabel" aria-hidden="true">

	<form id="modifyForm">
		<dlv id="modifyheader"> 
		<img id="logo-icon" src="/image/icon/logo.png">
		<button type="button" id="drawbtn">회원탈퇴</button>
		</dlv>

			<div class="form-group">
				<label for="email">이메일</label> 
				<input type="email" class="form-control" id="email" value="${member.email}" readonly>
			</div>
	
			<div class="form-group">
				<label for="newPassword">변경 비밀번호</label> 
				<input type="password"
					class="form-control" id="newPassword" placeholder="변경할 비밀번호 입력">
			</div>
	
			<div class="form-group">
				<label for="confirmPassword">비밀번호 확인</label> 
				<input type="password"
					class="form-control" id="confirmPassword" placeholder="비밀번호 확인">
			</div>
	
			<div class="form-group">
				<label for="nickname">닉네임</label> 
				<input type="text"
					class="form-control" id="nickname" value="${member.memberName}">
			</div>
			
			<div class="form-group">
				<label for="country">국적</label>
				<select class="form-control" id="country">
		        <c:forEach var="flag" items="${flags}">
		       		 <option value="${flag.flagIdx}" 
		       		 <c:if test="${flag.flagIdx eq member.flagIdx}">selected</c:if>>
		       		 ${flag.country}</option>
	       		 </c:forEach>
 			   </select>
			</div>
			
				
		

		<button type="button" class="modify-btn" id="modibtn">수정</button>
		<button type="button" class="modify-btn" id="cancelbtn">취소</button>
	</form>
</div>

<script>
$(document).ready(function() {
	//탈퇴버튼
	$("#drawbtn").on("click", function() {
	    if (confirm("회원 탈퇴를 하시겠습니까?")) {
	        $.ajax({
	            url: '/api/withdrawMember',
	            type: 'POST',
	            success: function(response) {
	                alert("회원 탈퇴가 완료되었습니다.");
	                window.location.href = "/";
	            },
	            error: function(error) {
	                alert("error : 회원 탈퇴에 실패했습니다.");
	            }
	        });
	    }
	});
	
	$("#modibtn").on("click", function() {
	    var newPassword = $("#newPassword").val();
	    var confirmPassword = $("#confirmPassword").val();
	    var nickname = $("#nickname").val();
	    var country = $("#country").val();

	    // 비밀번호를 입력하지 않았을 때 기존 비밀번호를 사용하도록 수정
	    var useOldPassword = newPassword === '' && confirmPassword === '';

	    if (!useOldPassword && newPassword !== confirmPassword) {
	        alert("변경 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	        return;
	    }

	    var memberDTO = {
	        pw: useOldPassword ? "unchanged" : newPassword,
	        memberName: nickname,
	        flagIdx: country
	    };

	    // 데이터요청
	    $.ajax({
	        url: '/api/updateMemberInfo',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify(memberDTO),
	        success: function(response) {
	            alert("수정 되었습니다.");
	            $(".modal_background1").fadeOut();
	        },
	        error: function(error) {
	            alert("error : 회원 정보 수정에 실패했습니다.");
	        }
	    });
	});


	// 수정 취소
	$("#cancelbtn").on("click", function() {
	    $(".modal_background1").fadeOut();
	});




	
}); //ready
</script>

</body>
</html>