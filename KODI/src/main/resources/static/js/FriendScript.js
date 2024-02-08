$(document).ready(function () {

	//닫기버튼
	$("#closebtn").on("click", function () {
		$(".modal_background2").fadeOut();
	});

	// 서로 친구 목록 요청
	$("#PairBtn").on("click", function () {
		$.ajax({
			url: '/api/pair',
			type: 'GET',
			dataType: 'html',
			success: function (response) {
				$('.modal_box2').html(response);
			},
			error: function (error) {
				console.log("Error:", error);
			}
		});
	});

	// 내가 추가한 친구 목록 요청
	$("#FollowingBtn").on("click", function () {
		$.ajax({
			url: '/api/following',
			type: 'GET',
			dataType: 'html',
			success: function (response) {
				$('.modal_box2').html(response);
			},
			error: function (error) {
				console.log("Error:", error);
			}
		});
	});

	// 나를 추가한 친구 목록 요청
	$("#FollowerBtn").on("click", function () {
		$.ajax({
			url: '/api/follower',
			type: 'GET',
			dataType: 'html',
			success: function (response) {
				$('.modal_box2').html(response);
			},
			error: function (error) {
				console.log("Error:", error);
			}
		});
	});




	//서로친구 삭제
	$("#friendList1").on('click', '#f-drawBtn', function (e) {
		e.preventDefault();
		if (confirm('해당 친구를 삭제하겠습니까?')) {
			$.ajax({
				url: '/api/pair/delete/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function (response) {
					$('#friendList1').html('');
					let result = "";
					for (let i = 0; i < response.length; i++) {
						result +=
							'<tr>' +
							'<td>' +
							'<div class="tdDiv">' +
							response[i].memberName +
							'</div>' +
							'</td>' +
							'<td>' +
							'<div class="tdDiv">' +
							response[i].country +
							'</div>' +
							'</td>' +
							'<td>' +
							'<button class="f-Btn" id="f-drawBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/pair/delete/' + response[i].memberIdx + '">친구삭제</a>' +
							'</td>' +
							'</tr>';
					}
					$('#friendList1').html(result);
				}
			});
		}
	});


	//친구요청 취소
	$("#friendList2").on('click', '#f-cancelBtn', function (e) {
		e.preventDefault();
		if (confirm('친구요청을 취소하시겠습니까?')) {
			$.ajax({
				url: '/api/following/delete/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function (response) {
					$('#friendList2').html('');
					let result = "";
					for (let i = 0; i < response.length; i++) {
						result +=
							'<tr>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].memberName +
							'</div>' +
							'</td>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].country +
							'</div>' +
							'</td>' +
							'<td>' +
							'<button class="f-Btn" id="f-cancelBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/following/delete/' + response[i].memberIdx + '">요청 취소</a>' +
							'</td>' +

							'</tr>';
					}
					$('#friendList2').html(result);
				}
			});
		}
	});


	// 나를 추가한 유저 삭제
	$("#friendList3").on('click', '#f-removeBtn', function (e) {
		if (confirm('친구요청을 거절하시겠습니까?')) {
			$.ajax({
				url: '/api/follower/delete/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function (response) {
					$('#friendList3').html('');
					let result = "";
					for (let i = 0; i < response.length; i++) {
						result +=
							'<tr>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].memberName +
							'</div>' +
							'</td>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].country +
							'</div>' +
							'</td>' +
							'<td>' +
							'<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/follower/accept/' + response[i].memberIdx + '">수락</a>' +
							'<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/follower/delete/' + response[i].memberIdx + '">삭제</a>' +
							'</td>' +
							'</tr>';
					}
					$('#friendList3').html(result); // 여기를 변경
				}
			});
		}
	});



	// 나를 추가한 유저 수락
	$("#friendList3").on('click', '#f-acceptBtn', function (e) {
		if (confirm('친구요청을 수락하시겠습니까?')) {
			$.ajax({
				url: '/api/follower/accept/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function (response) {
					$('#friendList3').html('');
					let result = "";
					for (let i = 0; i < response.length; i++) {
						result +=
							'<tr>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].memberName +
							'</div>' +
							'</td>' +
							'<td>' +
							'   <div class="tdDiv">' +
							response[i].country +
							'</div>' +
							'</td>' +
							'<td>' +
							'<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/follower/accept/' + response[i].memberIdx + '">수락</a>' +
							'<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/follower/delete/' + response[i].memberIdx + '">삭제</a>' +
							'</td>' +
							'</tr>';
					}
					$('#friendList3').html(result); // 여기를 변경
				}
			});
		}
	});
}); //ready