$(document).ready(function () {
	//전체 게시글
    // let language = "<%= session.getAttribute("language") %>";
    // let koLanguage = language === "ko";
    // $("#adminbtn").text(koLanguage ? "관리자" : "Admin");
    // $("#logoutbtn").text(koLanguage ? "로그아웃" : "Logout");
    // $("#listallBtn").text(koLanguage ? "전체글" : "Posts");
    // $("#memberlistBtn").text(koLanguage ? "회원목록" : "Users");
    // $("#memberTitle").text(koLanguage ? "전체회원" : "All Users");
    // $("#memberValue").text(koLanguage ? "사용자" : "User");
    // $("#email").text(koLanguage ? "이메일" : "Email");
    // $("#nickName").text(koLanguage ? "닉네임" : "Nickname");
    // $("#nationality").text(koLanguage ? "국적" : "Nationality");
    // $(".withdrawBtn").text(koLanguage ? "탈퇴" : "Withdraw");
    
    $("#postList").on('click', '.deleteBtn', function (e) {
        e.preventDefault();
        
        if(confirm('이 게시글을 삭제하시겠습니까?')){
			$.ajax({
            url: '/api/admin/deletepost/' + $(e.target).attr('data-post-idx'),
            dataType: 'json',
            type: "get",
            success: function (response) {// <- List<PostDTO>

                $('#postList').html();//<TBODY> 내부 내용 없앤다
                let result = "";
                for (let i = 0; i < response.postDTO.length; i++) {
                    for (let j = 0; j < response.memberDTO.length; j++) {
                        if (response.postDTO[i].memberIdx === response.memberDTO[j].memberIdx) {
                            result +=
                                '<tr>'+
                                '<td>' +
                                    '<div class="tdDiv">' + 
                                        response.memberDTO[j].email + 
                                    '</div>' +
                                '</td>' +
                                
                                '<td>' +
                                '   <div class="tdDiv">' + 
                                        response.postDTO[i].title + 
                                    '</div>' +
                                '</td>' +
                                
                                '<td>' +
								'   <div class="tdDiv">' + 
								        (response.postDTO[i].content.length > 20 ? response.postDTO[i].content.substring(0, 20) + '...' : response.postDTO[i].content) +
								'   </div>' +
								'</td>' +

                                
                                '<td>' +
								        '<a class="viewBtn" data-post-idx="' + response.postDTO[i].postIdx + '" href="/api/post/' + response.postDTO[i].postIdx + '">보기</a>' +
								'</td>' +
                                
                                
                                '<td>' +
                                        '<a class="deleteBtn" data-post-idx="' + response.postDTO[i].postIdx + '" href="/api/admin/deletepost/' + response.postDTO[i].postIdx + '">삭제</a>' +
                                '</td>' +
                                
                                '</tr>';
                        }
                    }
                }
                $('#postList').html(result);
            }//success
        });//ajax
	}
    });//on-click

	//전체 회원
    $("#memberList").on('click', '.withdrawBtn', function (e) {
        e.preventDefault();
        if(confirm('이 회원을 탈퇴 시키겠습니까??')){
        $.ajax({
            url: '/api/admin/deletemember/' + $(e.target).attr('data-member-idx'),
            dataType: 'json',
            type: "get",
            success: function (response) {

                $('#memberList').html(''); // Clear the content inside <TBODY>
                let result = "";
                for (let i = 0; i < response.memberDTO.length; i++) {
                    for (let j = 0; j < response.flagDTO.length; j++) {
                        if (response.memberDTO[i].flagIdx === response.flagDTO[j].flagIdx) {
                            result +=
                                '<tr>'+
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
                                '   <div class="tdDiv" style="display: flex; align-items: center;">' +      '<img style="width: 16px; height: 16px; margin-right: 3px;" src="'+response.flagDTO[j].src+'"></img>' + 
                                        response.flagDTO[j].country + 
                                    '</div>' +
                                '</td>' +
                                
                                '<td>' +
                                        '<a class="withdrawBtn" data-member-idx="' + response.memberDTO[i].memberIdx + '" href="/api/admin/deletemember/' + response.memberDTO[i].memberIdx + '">탈퇴</a>' +
                                '</td>' +
                                
                                '</tr>';
                        }
                    }
                }
                $('#memberList').html(result);
            }
        });
        }
    });
    
    
     function updateMenuContentPosition() {
     var menuOffset = $(".menu").offset();
     $(".menu-content").css({ 'left': menuOffset.left });
     }

     //관리자 메뉴버튼
     $("#menubtn").on("click", function () {
         updateMenuContentPosition();
         $(".menu-content").slideToggle(); // 
     });

     $(window).on('resize', function () {
         if ($(".menu-content").is(":visible")) {
             updateMenuContentPosition();
         }
     });

     $("#logoutbtn").on("click", function () {
         if (confirm("로그아웃 하시겠습니까?")) {
	        $.post("/api/logout", function(response) {
	            window.location.href = "/";
	        });
	    }
     });
     
     let topBtn = document.getElementById("topBtn");

    function topFunction() {
        document.body.scrollTop = 0; // Safari 용
        document.documentElement.scrollTop = 0; // Chrome, Firefox, IE 및 Opera 용
    }

    topBtn.addEventListener("click", topFunction);

    window.onscroll = function() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            topBtn.style.display = "block";
        } else {
            topBtn.style.display = "none";
        }
    };
    
    
    


});//ready