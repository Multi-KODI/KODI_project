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
}); //ready