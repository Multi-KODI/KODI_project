<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Admin.css">
<link rel="stylesheet" href="/css/AdminHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="js/jquery-3.7.1.min.js"></script>
<title>administrator</title>
</head>

<body>

<header>
	<div class="header-container">
		<div class="menu">
			<img src="/image/icon/menu.png" class="icon" id="menubtn">
		</div>

		<div class="end-btn">
			<button class="btn" id="adminbtn">관리자</button>
			<button class="btn" id="logoutbtn">로그아웃</button>
			<div class="language-selection">
				<select>
					<option value="ko">한국어</option>
					<option value="en">English</option>
				</select>
			</div>
		</div>
	</div>
</header>

<div class="menu-content">
	<a href="" id="listallBtn">전체글</a> 
	<a href="" id="memberlistBtn">회원목록</a>
</div>

<div class="main">

	<div class="logo-container">
		<img src="/image/icon/logo.png" alt="KoDi"
			style="width: 170px; height: 150px;">
	</div>

	<div class="board-box">
		<div class="title">

			<div id="title">
				<span style="margin-left: 10px;   ">전체글</span>
				<form action="boardsearchlist">
					<select id="searchselect"name="search">
						<option>제목</option>
						<option>내용</option>
						<option>작성자</option>
						<option>모두</option>
					</select> 
					<input id="searchinput" name="word">
					<button type="submit"
						style="border: none; background: none; cursor: pointer;">
						<img src="/image/icon/search.png"
							style="margin-right: 10px; height: 20px; width: 20px;">
					</button>
				</form>
			</div>
		</div>

		<div id="board">
			<table>
				<thead >
					<tr>
						<th><div class="tdDiv">작성자(이메일)</div></th>
						<th><div class="tdDiv">글제목</div></th>
						<th><div class="tdDiv">글내용</div></th>
					</tr>
				</thead>
			<tbody id="postList">
			<!-- 예시데이터 -->

			</tbody>
		</table>
		 <div id="pagination">
        <!-- 페이지네이션 버튼 -->
    	</div>
		
		

		</div>


	</div>
</div>


<!-- <script src="js/AdminScript.js"></script> -->
<script>
$(document).ready(function () {
	//메뉴버튼
	function updateMenuContentPosition() {
	    var menuOffset = $(".menu").offset(); 
	    $(".menu-content").css({'left': menuOffset.left }); 
	}
	
	
	$("#menubtn").on("click", function () {
		updateMenuContentPosition();
	    $(".menu-content").slideToggle();
	});
	
	$(window).on('resize', function(){
	    if($(".menu-content").is(":visible")) {
	        updateMenuContentPosition();
	    }
	});

      
      $("#logoutbtn").on("click", function () {
      	if (confirm("로그아웃 하시겠습니까?")) {
              window.location.href = "/start";
          } else {
          }
        });
	
      var currentPage = 1;
      var itemsPerPage = 10; //글개수
      var pagesPerGroup = 10; // 페이징버튼개수
      var currentGroup = 1; // 현재 페이지 그룹

      function loadTableData(page) {
          var data = [];
          for(var i = 0; i < 200; i++) {
              data.push({
                  작성자이메일: 'author@example.com',
                  글제목: 'Sample Title ' + (i + 1),
                  글내용: 'Sample Content ' + (i + 1)
              });
          }

          var tableContent = '';
          var start = (page - 1) * itemsPerPage;
          var end = start + itemsPerPage;
          for(var i = start; i < end && i < data.length; i++) {
              tableContent += '<tr><td><div class="tdDiv">' + data[i].작성자이메일 + '</div></td>';
              tableContent += '<td><div class="tdDiv">' + data[i].글제목 + '<div></td>';
              tableContent += '<td><div class="tdDiv">' + data[i].글내용 + '<div></td>';
              tableContent += '<td><button class="viewBtn" data-id="' + data[i].postIdx + '">보기</button></td>';
              tableContent += '<td><button class="deleteBtn" data-id="' + data[i].postIdx + '">삭제</button></td></tr>';
          }
          $('#postList').html(tableContent);

          $('#pagination').html('');
          var startPage = (currentGroup - 1) * pagesPerGroup + 1; // 현재 그룹의 시작 페이지 번호
          var endPage = startPage + pagesPerGroup; // 현재 그룹의 끝 페이지 번호
          if(currentGroup > 1) {
              $('#pagination').append('<button class="pageBtn" data-page="' + (startPage - 1) + '">이전</button>');
          }
          for(var i = startPage; i < endPage && i <= Math.ceil(data.length / itemsPerPage); i++) {
        	  if(i===currentPage){
        		  $('#pagination').append('<button class="pageBtn selected" data-page="' + i + '">' + i + '</button>');
        	  }else{
        		  $('#pagination').append('<button class="pageBtn" data-page="' + i + '">' + i + '</button>');
        	  }
       }
          if(endPage <= Math.ceil(data.length / itemsPerPage)) {
              $('#pagination').append('<button class="pageBtn" data-page="' + endPage + '">다음</button>');
          }
      }

      loadTableData(currentPage);

      $(document).on('click', '.pageBtn', function() {
          currentPage = $(this).data('page');
          currentGroup = Math.ceil(currentPage / pagesPerGroup); // 현재 페이지 그룹 업데이트
          loadTableData(currentPage);
      });

      

		
      $('#listallBtn').click(function() {
          $('span').text('전체글');
          var tableHeader = '<tr><th>작성자(이메일)</th><th>글제목</th><th>글내용</th></tr>';
          loadTableData('/api/allposts', tableHeader);
      });

      $('#memberlistBtn').click(function() {
          $('span').text('회원 목록');
          var tableHeader = '<tr><th>이메일</th><th>닉네임</th><th>국적</th></tr>';
          loadTableData('/api/allmembers', tableHeader);
      });

      
      
	
	//글 보기버튼
	$(document).on('click', '.viewBtn', function() {
	    var postIdx = $(this).data('id');
	    window.location.href = '/api/post/' + postIdx;
	});
	
	//글 삭제버튼
	$(document).on('click', '.deleteBtn', function() {
	    var postIdx = $(this).data('id');
	    if (confirm('이 게시글을 삭제하시겠습니까?')) {
	        $.ajax({
	            url: '/api/post/' + postIdx,
	            type: 'DELETE',
	            success: function(result) {
	                // 게시글이 성공적으로 삭제된 후 수행할 작업
	            }
	        });
	    }
	});
	
	//회원 탈퇴버튼
	$(document).on('click', '.withdrawBtn', function() {
	    var memberIdx = $(this).data('id');
	    if (confirm('정말로 이 회원을 탈퇴시키시겠습니까?')) {
	        $.ajax({
	            url: '/api/deletemember',
	            type: 'POST',
	            data: { memberIdx: memberIdx },
	            success: function(result) {
	                // 회원이 성공적으로 탈퇴된 후 수행할 작업
	            }
	        });
	    }
	});
    
  }); //ready

</script>




</body>
</html>