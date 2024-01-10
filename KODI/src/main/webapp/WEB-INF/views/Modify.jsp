<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
.modifybox {
	display: flex;
	overflow: hidden;
	justify-content: center;
	text-align: center;
	width: 400px;
	height: 500px;
}

#modifyForm {
	margin: auto;
	margin-left: 10px;
	margin-right: 10px;
}

.form-group {
	text-align: left;
	margin-top: 7%;
	border-bottom: 1px solid #D9D9D9;
	padding-bottom: 10px;
	display:flex;
}

.form-group label{
	width : 60%;
}

.form-control {
	font-family: 'NanumSquareNeo';
	width: 100%;
	border: 1px soild #292929;
	outline: none;
	padding: 5px;
	box-sizing: border-box;
}

.modify-btn {
	font-family: 'NanumSquareNeo';
	margin-top: 10%;
	margin-botton: 5%;
	max-width: 80px;
	width: 80px;
	justify-content: center;
	text-align: center;
	box-sizing: border-box;
	padding: 5px;
	border: none;
	cursor: pointer;
	border-radius: 8px;
	background-color: #D9D9D9;
	max-width: 80px;
}

#modifyheader {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

#logo-icon {
	justify-content: flex-start;
	width: 100px;
	height: 80px;
}

#drawbtn {
	font-family: 'NanumSquareNeo';
	justify-content: flex-end;
	max-width: 80px;
	width: 80px;
	padding: 7px;
	text-align: center;
	box-sizing: border-box;
	border: none;
	cursor: pointer;
	border-radius: 8px;

}
</style>
</head>

<body>
	<div class="modifybox" id="modifyModal" tabindex="-1" role="dialog"
		aria-labelledby="modifyModalLabel" aria-hidden="true">

		<form id="modifyForm">
			<dlv id="modifyheader"> <img id="logo-icon"
				src="/image/icon/logo.png">
			<button type="button" id="drawbtn">회원탈퇴</button>
			</dlv>

			<div class="form-group">
				<label for="email">이메일</label> 
				<input type="email"
					class="form-control" id="email" value="user@example.com" readonly>
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
					class="form-control" id="nickname" value="사용자닉네임">
			</div>

			<div class="form-group">
				<label for="nationality">국적</label> 
				<select class="form-control"
					id="nationality">
					<option value="korea">대한민국</option>
					<option value="usa">미국</option>
				</select>
			</div>

			<button type="button" class="modify-btn" id="modibtn">수정</button>
			<button type="button" class="modify-btn" id="cancelbtn">취소</button>
		</form>
	</div>

	<script>
		$(document).ready(function() {
			$("#drawbtn").on("click", function() {
				var confirmWithdraw = confirm("회원 탈퇴를 하시겠습니까?");

				if (confirmWithdraw) {
					alert("회원 탈퇴가 완료되었습니다.");
					// 회원 탈퇴 로직 추가
					window.location.href = "/start";
				}
			});

			$("#modibtn").on("click", function() {
				//정보 수정 로직 추가
				var newPassword = $("#newPassword").val();
				var confirmPassword = $("#confirmPassword").val();
				if (newPassword !== confirmPassword) {
					alert("변경 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
					return;
				}
				alert("수정 되었습니다.");
				$(".modal_background").fadeOut();
			});

			$("#cancelbtn").on("click", function() {
				$(".modal_background").fadeOut();
			});
		});
	</script>

</body>
</html>