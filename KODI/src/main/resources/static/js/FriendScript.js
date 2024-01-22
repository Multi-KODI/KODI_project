$(document).ready(function() {
	
	//닫기버튼
	$("#closebtn").on("click", function() {
		$(".modal_background").fadeOut();
	});
	
	//국적
	function getCountryByFlagIdx(flagIdx) {
	    var country;
	    $.ajax({
	        url: '/getCountry', // 국적 데이터 api
	        type: 'GET',
	        data: { flagIdx: flagIdx },
	        async: false, 
	        success: function(data) {
	            country = data.country;
	        }
	    });
	    return country;
	}
	
	
	// 내가 추가한 친구 보기
	$('#show-my-friends').click(function() {
	    var memberIdx = sessionStorage.getItem('memberIdx'); 
	    $.ajax({
	        url: '/chatlist/search',
	        type: 'POST',
	        data: JSON.stringify({ memberIdx: memberIdx }),
	        contentType: 'application/json',
	        success: function(data) {
	            $('#postList').empty();
	            for (var i = 0; i < data.length; i++) {
	                var friendCountry = getCountryByFlagIdx(data[i].flagIdx); 
	                if (data[i].isFriend) { // 서로 친구인 경우
	                    $('#postList').append(
	                    		'<tr><td><div class="tdDiv">' 
	                    		+ data[i].friendMemberName 
	                    		+ '</div></td><td><div class="tdDiv">' 
	                    		+ friendCountry 
	                    		+ '</div></td><td><div class="tdDiv">서로친구</div></td><td><button class="deleteBtn" data-id="' + data[i].friendMemberIdx + '">삭제</button></td></tr>');
	                } else { // 나만 친구 추가한 경우
	                    $('#postList').append(
	                    		'<tr><td><div class="tdDiv">' 
	                    		+ data[i].friendMemberName 
	                    		+ '</div></td><td><div class="tdDiv">' 
	                    		+ friendCountry 
	                    		+ '</div></td><td><div class="tdDiv">친구</div></td><td><button class="deleteBtn" data-id="' + data[i].friendMemberIdx + '">삭제</button></td></tr>');
	                }
	            }
	        }
	    });
	});



	// 나를 추가한 친구 보기
	$('#show-added-me').click(function() {
	    var memberIdx = sessionStorage.getItem('memberIdx'); 
	    $.ajax({
	        url: '/chatlist/search',
	        type: 'POST',
	        data: JSON.stringify({ memberIdx: memberIdx }),
	        contentType: 'application/json',
	        success: function(data) {
	            $('#postList').empty(); 
	            for (var i = 0; i < data.length; i++) {
	                var friendCountry = getCountryByFlagIdx(data[i].flagIdx); 
	                if (data[i].isFriend) { // 서로 친구인 경우
	                    $('#postList').append(
	                    		'<tr><td><div class="tdDiv">' 
	                    		+ data[i].friendMemberName 
	                    		+ '</div></td><td><div class="tdDiv">' 
	                    		+ friendCountry 
	                    		+ '</div></td><td><div class="tdDiv">서로친구</div></td><td><button class="deleteBtn" data-id="' 
	                    		+ data[i].friendMemberIdx 
	                    		+ '">삭제</button></td></tr>');
	                } else { // 나를 추가한 경우
	                    $('#postList').append(
	                    		'<tr><td><div class="tdDiv">' 
	                    		+ data[i].friendMemberName 
	                    		+ '</div></td><td><div class="tdDiv">' 
	                    		+ friendCountry 
	                    		+ '</div></td><td><div class="tdDiv">나를 추가한 친구</div></td><td><button class="deleteBtn" data-id="' 
	                    		+ data[i].friendMemberIdx 
	                    		+ '">삭제</button></td></tr>');
	                }
	            }
	        }
	    });
	});

	// 친구 신청 보기
	$('#show-requests').click(function() {
	    var memberIdx = sessionStorage.getItem('memberIdx'); 
	    $.ajax({
	        url: '/chatlist/search',
	        type: 'POST',
	        data: JSON.stringify({ memberIdx: memberIdx }),
	        contentType: 'application/json',
	        success: function(data) {
	            $('#postList').empty(); 
	            for (var i = 0; i < data.length; i++) {
	                var friendCountry = getCountryByFlagIdx(data[i].flagIdx); 
	                if (!data[i].isFriend) { // 친구 신청한 경우
	                    $('#postList').append(
	                    		'<tr><td><div class="tdDiv">' 
	                    		+ data[i].friendMemberName 
	                    		+ '</div></td><td><div class="tdDiv">' 
	                    		+ friendCountry 
	                    		+ '</div></td><td><div class="tdDiv">친구 신청</div></td><td><button class="deleteBtn" data-id="' 
	                    		+ data[i].friendMemberIdx 
	                    		+ '">삭제</button></td></tr>');
	                }
	            }
	        }
	    });
	});




	

}); //ready