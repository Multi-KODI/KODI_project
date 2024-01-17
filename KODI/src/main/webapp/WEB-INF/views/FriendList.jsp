<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style>
.friendbox {
	display: flex;
	overflow: hidden;
	justify-content: center;
	text-align: center;
	position: static; 
	width: 60vw;
	height: 60vh;
	max-width: 1000px;
	max-height: 700px;
	align-items: center;
	flex-direction: column;
	
}

.form-group label {
	width: 60%;
}

.friend-btn {
margin-botton: 10px;

}
#closebtn{
	font-family: 'NanumSquareNeo';
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

}

#friendheader {
	
}

#logo-icon {
	justify-content: flex-start;
	width: 100px;
	height: 80px;
}

.mainBox {
	height: 90%;
	width: 90%; 
	max-height: 90%;
	max-width: 90%;
	box-sizing: border-box;
	background-color: yellow;
	margin: auto;
	justify-content: center;
	text-align: center;
	position:relative ;
	display : flex;
	flex-direction: column;
}

.contentBox{
	height: 100%;
	width: 100%; 
	box-sizing: border-box;
	background-color: red;
	margin: auto;
	justify-content: center;
	text-align: center;
	position:relative ;
	display: flex;
}


.logoBtn{
display: flex;
flex-direction:column;
background-color: blue;
flex:30%;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group button{
	font-family: 'NanumSquareNeo';
	max-width: 150px;
	width: 120px;
	box-sizing: border-box;
	padding: 10px;
	border: none;
	cursor: pointer;
	border-radius: 8px;
	background-color: #D9D9D9;
	margin-left: auto;
  	margin-right: auto;
  	margin-top: 20px;
	
}



.friendList{
display: flex;
background-color: green;
flex:70%;
}

</style>
</head>

<body>
	<div class="friendbox" id="friendModal" tabindex="-1" role="dialog"
		aria-labelledby="friendModalLabel" aria-hidden="true">
		
		<div class="mainBox">
		<div class="contentBox">
		
		<div class="logoBtn">
		<dlv id="friendheader"> 
		<img id="logo-icon" src="/image/icon/logo.png"> <h2>친구목록</h2>
		</dlv>
		
		<div class="form-group" >
			<button id="show-my-friends">내가 추가한 친구</button>
			<button id="show-added-me">나를 추가한 친구</button>
			<button id="show-requests">친구 신청</button>
		</div>
		
		</div>
	<div class="friendList">
		<div id="list">
			<!-- 선택한 목록이 여기에 표시됩니다. -->
		</div>
		
	
		
		</div>
		
	</div>
		<div class="friend-btn"><button type="button"  id="closebtn">닫기</button></div>

	
		
	</div>
	
	
	</div>


			

	

<script>
$(document).ready(function() {

	
	
	//닫기버튼
	$("#closebtn").on("click", function() {
		$(".modal_background").fadeOut();
	});
	

	// 친구 목록 데이터. 실제로는 서버에서 가져올 수 있습니다.
	var friends = [
		{ name: '친구1', status: '내가 추가한 친구' },
		{ name: '친구2', status: '나를 추가한 친구' },
		{ name: '친구3', status: '친구 신청' },
		// ...
	];

	var list = document.getElementById('list');

	function showList(status) {
		// 목록을 비웁니다.
		list.innerHTML = '';

		// 선택한 상태의 친구만 목록에 추가합니다.
		friends.filter(function(friend) {
			return friend.status === status;
		}).forEach(function(friend) {
			var listItem = document.createElement('li');
			listItem.textContent = friend.name;
			list.appendChild(listItem);
		});
	}
	
	// 내가 추가한 친구 버튼
	$("#show-my-friends").on("click", function() {
		event.preventDefault();
		showList('내가 추가한 친구');
	});

	// 나를 추가한 친구 버튼
	$("#show-added-me").on("click", function() {
		event.preventDefault();
		showList('나를 추가한 친구');
	});

	// 친구 신청 버튼
	$("#show-requests").on("click", function() {
		event.preventDefault();
		showList('친구 신청');
	});


	

}); //ready
</script>

</body>
</html>