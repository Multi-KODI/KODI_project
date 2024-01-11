$(document).ready(function() {

	function updateMenuContentPosition() {
		var menuOffset = $(".menu").offset();
		$(".menu-content").css({ 'left': menuOffset.left });
	}

	//관리자 메뉴버튼
	$("#menubtn").on("click", function() {
		updateMenuContentPosition();
		$(".menu-content").slideToggle(); // 
	});

	$(window).on('resize', function() {
		if ($(".menu-content").is(":visible")) {
			updateMenuContentPosition();
		}
	});

	$("#logoutbtn").on("click", function() {
		if (confirm("로그아웃 하시겠습니까?")) {
			window.location.href = "/start";
		} else {
		}
	});

	var currentPage = 1;
	var itemsPerPage = 10;
	var pagesPerGroup = 10; // 한 그룹에 표시할 페이지 번호의 수
	var currentGroup = 1; // 현재 페이지 그룹
	var currentUrl = '/api/admin/allposts'; // 현재 URL
	var currentTableHeader = '<tr><th>작성자(이메일)</th><th>글제목</th><th>글내용</th></tr>'; // 현재 테이블 헤더

	function loadTableData(page, url, tableHeader) {
		$.ajax({
			url: url,
			type: 'GET',
			dataType: 'json',
			success: function(data) {
				var tableContent = '';
				var start = (page - 1) * itemsPerPage;
				var end = start + itemsPerPage;
				for (var i = start; i < end && i < data.length; i++) {
					if (url === '/api/admin/allposts') {
						tableContent += '<tr><td><div class="tdDiv">' + data[i].작성자이메일 + '</div></td>';
						tableContent += '<td><div class="tdDiv">' + data[i].글제목 + '</div></td>';
						tableContent += '<td><div class="tdDiv">' + data[i].글내용 + '</div></td>';
						tableContent += '<td><button class="withdrawBtn" data-id="' + data[i].memberIdx + '">탈퇴</button></td></tr>';
					} else if (url === '/api/admin/allmembers') {
						tableContent += '<tr><td><div class="tdDiv">' + data[i].이메일 + '</div></td>';
						tableContent += '<td><div class="tdDiv">' + data[i].닉네임 + '</div></td>';
						tableContent += '<td><div class="tdDiv">' + data[i].국적 + '</div></td>';
						tableContent += '<td><button class="viewBtn" data-id="' + data[i].postIdx + '">보기</button></td>';
						tableContent += '<td><button class="deleteBtn" data-id="' + data[i].postIdx + '">삭제</button></td></tr>';
					}
				}
				$('table thead').html(tableHeader);
				$('#postList').html(tableContent);
				$('#pagination').html('');

				var startPage = (currentGroup - 1) * pagesPerGroup + 1; // 현재 그룹의 시작 페이지 번호
				var endPage = startPage + pagesPerGroup; // 현재 그룹의 끝 페이지 번호


				if (currentGroup > 1) {
					$('#pagination').append('<button class="pageBtn" data-page="' + (startPage - 1) + '">이전</button>');
				}

				for (var i = startPage; i < endPage && i <= Math.ceil(data.length / itemsPerPage); i++) {

					if (i === currentPage) {
						$('#pagination').append('<button class="pageBtn selected" data-page="' + i + '">' + i + '</button>');
					} else {
						$('#pagination').append('<button class="pageBtn" data-page="' + i + '">' + i + '</button>');
					}
				}

				if (endPage <= Math.ceil(data.length / itemsPerPage)) {
					$('#pagination').append('<button class="pageBtn" data-page="' + endPage + '">다음</button>');
				}

			},
			error: function(xhr, status) {
				alert('오류가 발생했습니다: ' + status);
			}
		});
	}


	$(document).on('click', '.pageBtn', function() {
		currentPage = $(this).data('page');
		currentGroup = Math.ceil(currentPage / pagesPerGroup); // 현재 페이지 그룹 업데이트
		loadTableData(currentPage, currentUrl, currentTableHeader);
	});

	//전체 글 버튼
	$('#listallBtn').click(function() {
		$('span').text('전체글');
		currentUrl = '/api/admin/allposts'; // 현재 URL 업데이트
		currentTableHeader = '<tr><th>작성자(이메일)</th><th>글제목</th><th>글내용</th></tr>'; // 현재 테이블 헤더 업데이트
		loadTableData(currentPage, currentUrl, currentTableHeader);
	});

	//회원 목록 버튼
	$('#memberlistBtn').click(function() {
		$('span').text('회원 목록');
		currentUrl = '/api/admin/allmembers'; // 현재 URL 업데이트
		currentTableHeader = '<tr><th>이메일</th><th>닉네임</th><th>국적</th></tr>'; // 현재 테이블 헤더 업데이트
		loadTableData(currentPage, currentUrl, currentTableHeader);
	});

	//게시글 보기
	$(document).on('click', '.viewBtn', function() {
		var postIdx = $(this).data('id');
		window.location.href = '/api/post/' + postIdx;
	});

	//게시글 삭제
	$(document).on('click', '.deleteBtn', function() {
		var postIdx = $(this).data('id');
		if (confirm('이 게시글을 삭제하시겠습니까?')) {
			$.ajax({
				url: '/api/admin/deletepost',
				type: 'POST',
				data: JSON.stringify({ postIdx: postIdx }),
				contentType: "application/json", 
				success: function(result) {
					alert("삭제 되었습니다.");
				}
			});
		}
	});

	//회원 탈퇴
	$(document).on('click', '.withdrawBtn', function() {
		var memberIdx = $(this).data('id');
		if (confirm('이 회원을 탈퇴시키시겠습니까?')) {
			$.ajax({
				url: '/api/admin/deletemember',
				type: 'POST',
				data: JSON.stringify({ memberIdx: memberIdx }),
				contentType: "application/json",
				success: function(result) {
					alert("탈퇴 되었습니다.");
				}
			});
		}
	});

}); //ready