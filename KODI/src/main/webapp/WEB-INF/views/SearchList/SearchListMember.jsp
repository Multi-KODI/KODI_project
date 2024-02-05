<%@page import="java.util.regex.Matcher"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/SearchList.css">
<link
    href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
    rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title></title>
<script>

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

<main>
<div id="hBox">
    <p><strong><span style="color: #6A7EFC;">Search results for "${param.question}"</span></strong>.</p>
    <div class="hBox2">
        <div id="hBox3" style="color: #E5E1DA">Posts</div>
        <div id="hBox4" style="color: #494953">Users</div>
    </div>
</div>

<div class="listBox2">
<table>
	<thead>
		<tr>
			<th>
				<div class="tdDiv">Nickname</div>
			</th>
			<th>
				<div class="tdDiv">Nationality</div>
			</th>
			<th>
				<div class="tdDiv"></div>
			</th>
		</tr>
	</thead>

	<tbody id="memberList">
		<c:forEach var="member" items="${readMemberAll}">
			<tr>
				<td>
					<div class="tdDiv" id="nameBox">${member.memberName}</div>
				</td>
				
				<td>
				<div class="tdDiv" style="display: flex; align-items: center; ">
                 <img style="width: 16px; height: 16px; margin-right: 3px;" src="${member.flag}">
				${member.country}
				</div>
				</td>
				
				<td class="tdButton">
					<button class="fBtn" type="button" data-member-idx="${member.memberIdx}">
						<c:if test="${member.friendState eq '서로 친구'}"> 
                        Delete friend
						</c:if>
						<c:if test="${member.friendState eq '내가 추가한 친구'}"> 
                        Cancel request
						</c:if>
						<c:if test="${member.friendState eq '나를 추가한 친구'}"> 
						Accept
						</c:if>
						<c:if test="${member.friendState eq '친구 신청 가능'}"> 
                        Friend request
						</c:if>
					</button>
					<c:if test="${member.friendState eq '나를 추가한 친구'}">
						<button class="fBtn" type="button" data-member-idx="${member.memberIdx}">Decline</button>
					</c:if>
				</td>
			</tr>
			
		</c:forEach>
			
		</tbody>
	</table>
</div>


</main>

<script>
const emojis = [ '😀', '😆', '😍', '🥰', '😘', '😙', '☺️', '🤗' ];

function getRandomEmoji() {
	return emojis[Math.floor(Math.random() * emojis.length)];
}


$(document).ready(function() {
	$("#memberList .tdDiv#nameBox").each(function() {
        var memberNameDiv = $(this);
        var memberName = memberNameDiv.text().trim();
        var randomEmoji = getRandomEmoji();
        memberNameDiv.html(randomEmoji + ' ' + memberName);
    });
	
    $("#memberList").on("click", ".fBtn", function() {
        var memberId = $(this).data("member-idx");
        var friendState = $(this).text().trim();
        console.log(memberId);
        console.log(friendState);
        
        if(friendState === "친구 신청") {
            // 친구신청
            if(confirm("Would you like to send a friend request?")) {
                $.ajax({
                    url: '/api/search/isClickBtn',
                    type: 'POST',
                    data:{
                    	clickState: friendState,
                    	friendMemberIdx: memberId
                    },
                    error: function(xhr, status, error) {
                    }
                });
            }
        }
        else if(friendState === "요청 취소") {
        	//요청 취소
        	if(confirm("Would you like to cancel the friend request?")) {
        		$.ajax({
        			url: '/api/search/isClickBtn',
                    type: 'POST',
                    data:{
                    	clickState: friendState,
                    	friendMemberIdx: memberId
                    },
                    error: function(xhr, status, error) {
                    }
        		});
        	}
        }
        else if(friendState === "수락") {
        	//요청 수락
        	if(confirm("Would you like to accept the friend request?")) {
        		$.ajax({
        			url: '/api/search/isClickBtn',
                    type: 'POST',
                    data:{
                    	clickState: friendState,
                    	friendMemberIdx: memberId
                    },
                    error: function(xhr, status, error) {
                    }
        		});
        	}
        }
        else if(friendState === "거절") {
        	//요청 거절
			if(confirm("Would you like to decline the friend request?")) {
        		$.ajax({
        			url: '/api/search/isClickBtn',
                    type: 'POST',
                    data:{
                    	clickState: friendState,
                    	friendMemberIdx: memberId
                    },
                    error: function(xhr, status, error) {
                    }
        		});
        	}
        }
        else if(friendState === "친구 삭제") {
            // 삭제
            if(confirm("Would you like to delete the friend?")) {
                $.ajax({
                	url: '/api/search/isClickBtn',
                    type: 'POST',
                    data:{
                    	friendMemberIdx: memberId,
                    	clickState: friendState
                    },
                    error: function(xhr, status, error) {
                    }
                });
            }
        }
		location.reload(true); //새로고침
    }); //클릭
    
    $(".fBtn").hover(function() {
        var friendState = $(this).text().trim();
        if(friendState === "친구 신청" || friendState === "수락") {
            $(this).css({"background-color": "#6A7EFC", "color": "#ffffff"});
        } else if(friendState === "요청 취소" || friendState === "친구 삭제" || friendState === "거절") {
            $(this).css({"background-color": "#FF5656", "color": "#ffffff"});
        }
    }, function() {
        $(this).css({"background-color": "", "color": ""});
    });
    
    // 게시글
    $("#hBox3").on("click", function() {
        var question = encodeURIComponent("${param.question}");
        window.location.href = '/api/search?filter=%EA%B2%8C%EC%8B%9C%EA%B8%80&question=' + question;
    });

    // 사용자
    $("#hBox4").on("click", function() {
        var question = encodeURIComponent("${param.question}");
        window.location.href = '/api/search?filter=%EC%82%AC%EC%9A%A9%EC%9E%90&question=' + question;
    });

});
</script>



</body>
</html>
