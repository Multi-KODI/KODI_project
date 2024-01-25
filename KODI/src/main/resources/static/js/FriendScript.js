$(document).ready(function() {

	//닫기버튼
	$("#closebtn").on("click", function() {
		$(".modal_background2").fadeOut();
	});

	// 서로 친구 목록 요청
	$("#PairBtn").on("click", function() {
		$.ajax({
			url: '/api/pair',
			type: 'GET',
			dataType: 'html',
			success: function(response) {
				$('.modal_box2').html(response);
			},
			error: function(error) {
				console.log("Error:", error);
			}
		});
	});

	// 내가 추가한 친구 목록 요청
	$("#FollowingBtn").on("click", function() {
		$.ajax({
			url: '/api/following',
			type: 'GET',
			dataType: 'html',
			success: function(response) {
				$('.modal_box2').html(response);
			},
			error: function(error) {
				console.log("Error:", error);
			}
		});
	});

	// 나를 추가한 친구 목록 요청
	$("#FollowerBtn").on("click", function() {
		$.ajax({
			url: '/api/follower',
			type: 'GET',
			dataType: 'html',
			success: function(response) {
				$('.modal_box2').html(response);
			},
			error: function(error) {
				console.log("Error:", error);
			}
		});
	});




	//서로친구 삭제
	$("#friendList").on('click', '#f-drawBtn', function(e) {
		e.preventDefault();
		if (confirm('이 친구를 삭제하겠습니까??')) {
			$.ajax({
				url: '/api/pair/delete/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function(response) {
					$('#friendList').html('');
					let result = "";
					for (let i = 0; i < response.memberDTO.length; i++) {
						for (let j = 0; j < response.flagDTO.length; j++) {
							if (response.memberDTO[i].flagIdx === response.flagDTO[j].flagIdx) {
								result +=
									'<tr>' +
									'<td>' +
									'<div class="tdDiv">' +
									response.memberDTO[i].email +
									'</div>' +
									'</td>' +
									'<td>' +
									'   <div class="tdDiv">' +
									response.memberDTO[i].memberName +
									'</div>' +
									'</td>' +
									'<td>' +
									'   <div class="tdDiv">' +
									response.flagDTO[j].country +
									'</div>' +
									'</td>' +
									'<td>' +
									'<button class="f-Btn" id="f-drawBtn" data-member-idx="' + response.memberDTO[i].memberIdx + '" href="/api/pair/delete/' + response.memberDTO[i].memberIdx + '">삭제</a>' +
									'</td>' +

									'</tr>';
							}
						}
					}
					$('#friendList').html(result);
				}
			});
		}
	});


	//내가 추가한 친구 요청 취소
	$("#friendList").on('click', '#f-cancelBtn', function(e) {
		e.preventDefault();
		if (confirm('친구신청을 취소하겠습니까?')) {
			$.ajax({
				url: '/api/following/delete/' + $(e.target).attr('data-member-idx'),
				dataType: 'json',
				type: "get",
				success: function(response) {
					$('#friendList').html('');
					let result = "";
					for (let i = 0; i < response.memberDTO.length; i++) {
						for (let j = 0; j < response.flagDTO.length; j++) {
							if (response.memberDTO[i].flagIdx === response.flagDTO[j].flagIdx) {
								result +=
									'<tr>' +
									'<td>' +
									'<div class="tdDiv">' +
									response.memberDTO[i].email +
									'</div>' +
									'</td>' +
									'<td>' +
									'   <div class="tdDiv">' +
									response.memberDTO[i].memberName +
									'</div>' +
									'</td>' +
									'<td>' +
									'   <div class="tdDiv">' +
									response.flagDTO[j].country +
									'</div>' +
									'<button class="f-Btn" id="f-cancelBtn" data-member-idx="' + response.memberDTO[i].memberIdx + '" href="/api/following/delete/' + response.memberDTO[i].memberIdx + '">요청취소</a>' +
									'</td>' +

									'</tr>';
							}
						}
					}
					$('#friendList').html(result);
				}
			});
		}
	});


	// 나를 추가한 유저 삭제
$("#friendList").on('click', '#f-removeBtn', function(e) {
    if (confirm('이 유저를 삭제하겠습니까?')) {
        $.ajax({
            url: '/api/follower/delete/' + $(e.target).attr('data-member-idx'),
            dataType: 'json',
            type: "get",
            success: function(response) {
                let result = "";
                for (let i = 0; i < response.memberDTO.length; i++) {
                    for (let j = 0; j < response.flagDTO.length; j++) {
                        if (response.memberDTO[i].flagIdx === response.flagDTO[j].flagIdx) {
                            result +=
                                '<tr>' +
                                '<td>' +
                                '<div class="tdDiv">' +
                                response.memberDTO[i].email +
                                '</div>' +
                                '</td>' +
                                '<td>' +
                                '   <div class="tdDiv">' +
                                response.memberDTO[i].memberName +
                                '</div>' +
                                '</td>' +
                                '<td>' +
                                '   <div class="tdDiv">' +
                                response.flagDTO[j].country +
                                '</div>' +
                                '</td>' +
                                '<td>' +
                                '<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response.memberDTO.memberIdx + '" href="/api/follower/accept/' + response.memberDTO.memberIdx + '">수락</a>' +
                                '<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response.memberDTO[i].memberIdx + '" href="/api/follower/delete/' + response.memberDTO[i].memberIdx + '">삭제</a>' +
                                '</td>' +
                                '</tr>';
                        }
                    }
                }
                $('#friendList tbody').html(result); // 여기를 변경
            }
        });
    }
});



	//친구 요청 수락  
	$("#friendList").on('click', '#f-acceptBtn', function() {
		var memberIdx = $(this).data("member-idx");
		$.ajax({
			url: '/api/follower/accept/' + memberIdx,
			dataType: 'json',
			type: "get",
			success: function(response) {
				var newRow = '<tr>' +
					'<td>' +
					'<div class="tdDiv">' + response.memberDTO.email + '</div>' +
					'</td>' +
					'<td>' +
					'<div class="tdDiv">' + response.memberDTO.memberName + '</div>' +
					'</td>' +
					'<td>' +
					'<div class="tdDiv">' + response.flagDTO.country + '</div>' +
					'</td>' +
					'<td>' +
					'<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response.memberDTO.memberIdx + '" href="/api/follower/accept/' + response.memberDTO.memberIdx + '">수락</a>' +
					'<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response.memberDTO.memberIdx + '" href="/api/follower/delete/' + response.memberDTO.memberIdx + '">삭제</a>' +
					'</td>' +
					'</tr>';

				$('#friendList').find('[data-member-idx="' + memberIdx + '"]').closest('tr').remove();
				$('#friendList').append(newRow);
			},
			error: function(error) {
				console.log("Error:", error);
			}
		});
	});









}); //ready