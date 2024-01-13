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

<main>
<div class="modal_background">
	<div class="modal_box"></div>
	<div class="modal_box2"></div>
</div>


<main>
		<div class="mypagebtn-box">
			<button class="mypagebtn" id="friendbtn">친구목록</button>
			<div>
			<button class="mypagebtn" id="writebtn">글작성</button>
			<button class="mypagebtn" id="modifybtn">정보수정</button>
			</div>
			
		</div>

	<div id="mypage-box">
			<div id="album">

				<!-- 썸네일이미지 -->
			<div class="album-item">
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGeLvmPVRJ4qW3e7LYtcLV4lL5WTPwsXJFRQ&usqp=CAU">
			</div>
			<div class="album-item">
				<img src="https://static.ffx.io/images/$zoom_0.2395%2C$multiply_0.5855%2C$ratio_1%2C$width_1059%2C$x_412%2C$y_111/t_crop_custom/q_86%2Cf_auto/4ff5c85c953517ed77f99d414bd968cd35149982">
			</div>
			<div class="album-item">
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSceREFrbL87nsKQxJerouKhgKFcYVCaqEFw&usqp=CAU">
			</div>
			<div class="album-item">
				<img src="https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D">

			</div>
						<div class="album-item">
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGeLvmPVRJ4qW3e7LYtcLV4lL5WTPwsXJFRQ&usqp=CAU">
			</div>
			<div class="album-item">
				<img src="https://static.ffx.io/images/$zoom_0.2395%2C$multiply_0.5855%2C$ratio_1%2C$width_1059%2C$x_412%2C$y_111/t_crop_custom/q_86%2Cf_auto/4ff5c85c953517ed77f99d414bd968cd35149982">
			</div>
			<div class="album-item">
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSceREFrbL87nsKQxJerouKhgKFcYVCaqEFw&usqp=CAU">
			</div>
			<div class="album-item">
				<img src="https://images.unsplash.com/photo-1608848461950-0fe51dfc41cb?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D">

			</div>
			
		</div>
	</div>

</main>





<script>
$(document).ready(function() {
	  
$.ajax({
    url: '/api/myPage',
    type: 'GET',
    success: function(posts) {
        var album = $('#album');
        posts.forEach(function(post) {
            $.ajax({
                url: '/api/????/' + post.postIdx, //이미지 데이터 받기
                type: 'GET',
                success: function(images) {
                    images.forEach(function(image) {
                        if (image.postIdx === post.postIdx) {
                            var albumItem = $('<div class="album-item"><img src="' + image.src + '" data-id="' + post.postIdx + '"></div>');
                            albumItem.on('click', function() { //썸네일클릭
                                var postIdx = $(this).find('img').data('id');
                                window.location.href = '/api/post/' + postIdx;
                            });
                            album.append(albumItem);
                        }
                    });
                },
                error: function(error) {
                    console.error("게시물 이미지를 가져오는 데 실패했습니다.", error);
                }
            });
        });
    },
    error: function(error) {
        console.error("내 게시물을 가져오는 데 실패했습니다.", error);
    }
});

	  
	//글작성 버튼>글작성페이지
    $("#writebtn").on("click", function () {
      window.location.href=("/api/post/write");
    });
    

    //정보수정 버튼
    $("#modifybtn").on("click", function () {
        var userInput = prompt("정보수정을 하려면 비밀번호를 입력하세요");
        
        //검증부분
        $.ajax({
            url: '/api/????',  //비밀번호 데이터 받기
            type: 'POST',
            data: { password: userInput },
            success: function(isValid) {
                if (isValid) {
                    $(".modal_box").load("/modifyModal", function() {
                        $(".modal_background").fadeIn();
                    });
                } else {
                    alert("비밀번호가 틀렸습니다.");
                }
            },
            error: function(error) {
                console.error("error : 비밀번호를 검증하는 데 실패했습니다.", error);
            }
        });
    });
    
    
	//친구목록
    $("#friendbtn").on("click", function () {
        $(".modal_box2").load("/friendList", function() {
            $(".modal_background").fadeIn();
        });
    });
	
	
	
    
    
  });//ready
</script>






</body>
</html>