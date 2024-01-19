// $(document).ready(function () {

//     var deleteButtons = document.querySelectorAll('.deletebtn');

//     deleteButtons.forEach(function (deleteButton) {
//         deleteButton.addEventListener('click', function () {
//             var postIdx = parseInt(deleteButton.dataset.postIdx); // 문자열을 숫자로 변환
//             location.href="/api/admin/deletepost?postIdx=" + postIdx;
//             // postList
//         });
//     });

//     var withdrawButtons = document.querySelectorAll('.withdrawbtn');

//     withdrawButtons.forEach(function (withdrawButton) {
//         withdrawButton.addEventListener('click', function () {
//             var memberIdx = parseInt(withdrawButton.dataset.memberIdx); // 문자열을 숫자로 변환
//             var data = {
//                 memberIdx: memberIdx
//             };

//             fetch('http://localhost:7777/api/admin/deletemember', {
//                 method: 'POST',
//                 headers: {
//                     'Content-Type': 'application/json',
//                     // You can add more headers if needed
//                 },
//                 body: JSON.stringify(data) // 데이터를 JSON 문자열로 변환하여 전송
//             })
//                 .then(() => {
//                     location.href = 'http://localhost:7777/api/admin/allmembers';
//                 })
//                 .catch(error => console.error('Error:', error));
//         });
//     });

//     var viewButtons = document.querySelectorAll('.viewbtn');

//     viewButtons.forEach(function (viewButton) {
//         viewButton.addEventListener('click', function () {
//             var postIdx = parseInt(viewButton.dataset.postIdx); // Convert string to number
//             var url = 'http://localhost:7777/api/post/' + postIdx; // Fix the URL

//             fetch(url, {
//                 method: 'GET',
//                 headers: {
//                     'Content-Type': 'application/json',
//                     // You can add more headers if needed
//                 },
//                 // No need for a request body in a GET request
//             })
//                 .then(response => {
//                     if (!response.ok) {
//                         throw new Error('Network response was not ok');
//                     }
//                     return response.json(); // Parse the JSON from the response
//                 })
//                 .then(data => {
//                     // Do something with the data if needed
//                     console.log('Data:', data);
//                     // Redirect to the appropriate page
//                     window.location.href = 'http://localhost:7777/api/post/' + postIdx;
//                 })
//                 .catch(error => console.error('Error:', error));
//         });
//     });



//     function updateMenuContentPosition() {
//         var menuOffset = $(".menu").offset();
//         $(".menu-content").css({ 'left': menuOffset.left });
//     }

//     //관리자 메뉴버튼
//     $("#menubtn").on("click", function () {
//         updateMenuContentPosition();
//         $(".menu-content").slideToggle(); // 
//     });

//     $(window).on('resize', function () {
//         if ($(".menu-content").is(":visible")) {
//             updateMenuContentPosition();
//         }
//     });

//     $("#logoutbtn").on("click", function () {
//         if (confirm("로그아웃 하시겠습니까?")) {
//             window.location.href = "/start";
//         } else {
//         }
//     });

// }); //ready
$(document).ready(function(){
	$("#postList").on('click', $(".deleteBtn"), function(e){
		e.preventDefault();
		$.ajax({
			url :'/api/admin/deletepost/'+$(e.target).attr('data-post-idx'),
			dataType:'json',
			type:"get",
			success : function(response){// <- List<PostDTO>
			
                $('#postList').html();//<TBODY> 내부 내용 없앤다
			let result = "";
			for(let i = 0; i < response.length; i++){
				result += 
					'<tr><td>'
					+ '<div class="tdDiv">' +response[i].title + '</div>'
					+ '</td>'
					+ '<td>'
					+ '	<div class="tdDiv">' + response[i].content.substr(0, 20) + '</div>'
					+ '</td>'
					+ '<td>'
					+	'<div class="tdDiv">'
					+	'		<button class="viewBtn" type="button" data-post-idx="${post.postIdx}">보기</button>'
					+	'		<a class="deleteBtn" data-post-idx="' + response[i].postIdx + '" href="/api/admin/deletepost/${post.postIdx}">삭제</a>'
					+	'	</div>'
					+	'</td>'
					+	'</tr>'
			}//for
			$('#postList').html(result);
			}//success
		});//ajax
	});//on-click

    $("#memberList").on('click', $(".withdrawBtn"), function(e){
		e.preventDefault();
		$.ajax({
			url :'/api/admin/deletemember/'+$(e.target).attr('data-member-idx'),
			dataType:'json',
			type:"get",
			success : function(response){// <- List<PostDTO>
			
            $('#memberList').html();//<TBODY> 내부 내용 없앤다
			let result = "";
			for(let i = 0; i < response.length; i++){
				result += 
					'<tr><td>'
					+ '<div class="tdDiv">' +response[i].flagDTO + '</div>'
					+ '</td>'
					+ '<td>'
					+ '	<div class="tdDiv">' + response[i].memberName + '</div>'
					+ '</td>'
					+ '<td>'
					+	'<div class="tdDiv">'
					+	'		<button class="viewBtn" type="button" data-post-idx="${member.memberIdx}">보기</button>'
					+	'		<a class="withdrawBtn" data-member-idx="' + response[i].memberIdx + '" href="/api/admin/deletemember/${member.memberIdx}">탈퇴</a>'
					+	'	</div>'
					+	'</td>'
					+	'</tr>'
			}//for
			$('#memberList').html(result);
			}//success
		});//ajax
	});//on-click
	
});//ready