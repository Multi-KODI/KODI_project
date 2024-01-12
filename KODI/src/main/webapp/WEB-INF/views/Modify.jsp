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
	display: flex;
}

.form-group label {
	width: 60%;
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
				<label for="email">이메일</label> <input type="email"
					class="form-control" id="email" value="user@example.com" readonly>
			</div>

			<div class="form-group">
				<label for="newPassword">변경 비밀번호</label> <input type="password"
					class="form-control" id="newPassword" placeholder="변경할 비밀번호 입력">
			</div>

			<div class="form-group">
				<label for="confirmPassword">비밀번호 확인</label> <input type="password"
					class="form-control" id="confirmPassword" placeholder="비밀번호 확인">
			</div>

			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text"
					class="form-control" id="nickname" value="사용자닉네임">
			</div>

			<div class="form-group">
				<label for="nationality">국적</label> <select class="form-control"
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
	
	//옵션에 보여줄 국가 목록
	$(document).ready(function() {
	    $.ajax({
	        url: '/api/????', //국가 데이터 받기
	        type: 'GET',
	        success: function(flags) {
	            var select = $('#nationality');
	            flags.forEach(function(flag) {
	                select.append('<option value="' + flag.flagIdx + '">' + flag.country + '</option>');
	            });
	        },
	        error: function(error) {
	            console.error("error : 국가 데이터를 가져오는 데 실패했습니다.", error);
	        }
	    });
	});
	
	//탈퇴버튼
	$("#drawbtn").on("click", function() {
		var confirmWithdraw = confirm("회원 탈퇴를 하시겠습니까?");

	    if (confirmWithdraw) {
	        $.ajax({
	            url: '/api/withdrawMember',
	            type: 'POST',
	            success: function(response) {
	                alert("회원 탈퇴가 완료되었습니다.");
	                window.location.href = "/start";
	            },
	            error: function(error) {
	                alert("error : 회원 탈퇴에 실패했습니다.");
	            }
	        });
	    }
	});
	
	//수정버튼
	$("#modibtn").on("click", function() {
		var newPassword = $("#newPassword").val();
		var confirmPassword = $("#confirmPassword").val();
		var nickname = $("#nickname").val();
	    var nationality = $("#nationality").val();
		
		
		if (newPassword !== confirmPassword) {
			alert("변경 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			return;
		}
		
		 var memberDTO = {
	        pw: newPassword,
	        memberName: nickname,
	        flagIdx: nationality
			    };
		
		 //데이터요청
		 $.ajax({
		        url: '/api/updateMemberInfo',
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(memberDTO),
		        success: function(response) {
		            alert("수정 되었습니다.");
		            $(".modal_background").fadeOut();
		        },
		        error: function(error) {
		            alert("error : 회원 정보 수정에 실패했습니다.");
		        }
		    });
		});

	//수정 취소버튼
	$("#cancelbtn").on("click", function() {
		$(".modal_background").fadeOut();
	});
	
}); //ready
</script>

</body>
</html>