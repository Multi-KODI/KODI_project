<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/MyPage.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="js/jquery-3.7.1.min.js"></script>
<title>mypage</title>
</head>

<body>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>


<script>
  $(document).ready(function() {
    var userId = 1; // 예시 

    $.get(`/api/posts/user/${userId}`, function(posts) {
      displayAlbum(posts);
    });
    
    $("#writebtn").on("click", function () {
      window.location.href=("/api/post/write");
    });
    
    $("#modifybtn").on("click", function () {
      var userInput = prompt("정보수정을 하려면 비밀번호를 입력하세요");
      var passwordFromServer = "1234"; 
      if (userInput === passwordFromServer) {
        $(".modal_box").load("/modifyModal", function() {
          $(".modal_background").fadeIn();
        });
      } else {
        alert("비밀번호가 틀렸습니다.");
      }
    });

    function displayAlbum(posts) {
      var albumDiv = $("#album");
      posts.forEach(function(post) {
        // 각 포스트에 대한 처리
      });
    }
  });
</script>


<main>
<div class="modal_background">
		<div class="modal_box"></div>
	</div>


	<main>
		<div class="mypagebtn-box">
			<button class="mypagebtn" id="writebtn">글작성</button>
			<button class="mypagebtn" id="modifybtn">정보수정</button>
		</div>

		<div id="mypage-box">

			<div id="album">

				<!-- 임시데이터 -->
				<div class="album-item">
					<img src="https://placekitten.com/300/300">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/301/301">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/302/302">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/302/302">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/301/301">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/300/300">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/301/301">
				</div>
				<div class="album-item">
					<img src="https://placekitten.com/302/302">
				</div>
			</div>
		</div>


</main>

</body>
</html>