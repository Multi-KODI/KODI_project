<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<a href="" id="listallBtn">전체글</a> <a href="" id="memberlistBtn">회원
			목록</a>

	</div>

	<div class="main">

		<div class="logo-container">
			<img src="/image/icon/logo.png" alt="KoDi"
				style="width: 170px; height: 150px;">
		</div>

		<div class="board-box">
			<div class="title">

				<div id="title">
					<span style="margin-left: 10px;">전체글</span>
					<form action="boardsearchlist">
						<select name="search">
							<option>제목</option>
							<option>내용</option>
							<option>작성자</option>
							<option>모두</option>
						</select> <input id="search" name="word">
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
					<thead>
						<tr>
							<th>작성자(이메일)</th>
							<th>글제목</th>
							<th>글내용</th>
						</tr>
					</thead>
					<tbody id="postList">

					</tbody>
				</table>

			</div>


		</div>
	</div>



<script>
$(document).ready(function () {
    $("#menubtn").on("click", function () {
      $(".menu-content").slideToggle();
    });
    
    $("#logoutbtn").on("click", function () {
    	if (confirm("로그아웃 하시겠습니까?")) {
            window.location.href = "/start";
        } else {
        }
      });
    

    $('#listallBtn').click(function() {
		$('span').text('전체글');
		var tableHeader = '<tr><th>작성자(이메일)</th><th>글제목</th><th>글내용</th></tr>';
	    $('table thead').html(tableHeader);
		
	    $.ajax({
	        url: '/api/allposts', 
	        type: 'GET',
	        dataType: 'json',
	        success: function(data) {
	            var tableContent = '';
	            for(var i = 0; i < data.length; i++) {
	                tableContent += '<tr><td>' + data[i].작성자이메일 + '</td>';
	                tableContent += '<td>' + data[i].글제목 + '</td>';
	                tableContent += '<td>' + data[i].글내용 + '</td></tr>';
	                tableContent += '<td><button class="withdrawBtn" data-id="' + data[i].memberIdx + '">탈퇴</button></td></tr>';
	            }
	            $('#postList').html(tableContent);
	        },
	        error: function(xhr, status) {
	            alert('오류가 발생했습니다: ' + status);
	        }
	    });
	});
    
    
    $('#memberlistBtn').click(function() {
    	$('span').text('회원 목록');
    	 var tableHeader = '<tr><th>이메일</th><th>닉네임</th><th>국적</th></tr>';
    	    $('table thead').html(tableHeader);
    	
	    $.ajax({
	        url: '/api/allmembers', 
	        type: 'GET',
	        dataType: 'json',
	        success: function(data) {
	            var tableContent = '';
	            for(var i = 0; i < data.length; i++) {
	                tableContent += '<tr><td>' + data[i].이메일 + '</td>';
	                tableContent += '<td>' + data[i].글제목 + '</td>';
	                tableContent += '<td>' + data[i].글내용 + '</td></tr>';
	                tableContent += '<td><button class="viewBtn" data-id="' + data[i].postIdx + '">보기</button></td>';
	                tableContent += '<td><button class="deleteBtn" data-id="' + data[i].postIdx + '">삭제</button></td></tr>';
	            }
	            $('#postList').html(tableContent);
	        },
	        error: function(xhr, status) {
	            alert('오류가 발생했습니다: ' + status);
	        }
	    });
	});

	

	$(document).on('click', '.viewBtn', function() {
	    var postIdx = $(this).data('id');
	    window.location.href = '/api/post/' + postIdx;
	});

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