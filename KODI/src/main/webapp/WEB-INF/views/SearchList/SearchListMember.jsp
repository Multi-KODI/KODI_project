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

<p><strong><span style="color: #6A7EFC;">${param.question}</span></strong>에 대한 검색결과 입니다.</p>
<div class="listBox2">
<table>
	<thead>
		<tr>
			<th>
				<div class="tdDiv">닉네임</div>
			</th>
			<th>
				<div class="tdDiv">국적</div>
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
					<div class="tdDiv">${member.country}</div>
				</td>
				
				<td class="tdButton">
					<button class="fBtn" type="button" data-member-idx="${member.memberIdx}">
						<c:if test="${member.friendState eq '서로 친구'}"> 
						친구 삭제하기
						</c:if>
						<c:if test="${member.friendState eq '내가 추가한 친구'}"> 
						친구 요청 취소
						</c:if>
						<c:if test="${member.friendState eq '나를 추가한 친구'}"> 
						친구 수락
						</c:if>
						<c:if test="${member.friendState eq '친구 신청 가능'}"> 
						친구 요청 보내기
						</c:if>
					</button>
					<c:if test="${member.friendState eq '나를 추가한 친구'}">
						<button class="fBtn" type="button" data-member-idx="${member.memberIdx}">친구 거절</button>
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
        
        if(friendState === "친구 요청 보내기") {
            // 친구신청
            if(confirm("친구신청 하시겠습니까?")) {
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
        else if(friendState === "친구 요청 취소") {
        	//요청 취소
        	if(confirm("친구신청을 취소하시겠습니까?")) {
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
        else if(friendState === "친구 수락") {
        	//요청 수락
        	if(confirm("친구요청을 수락하시겠습니까?")) {
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
        else if(friendState === "친구 거절") {
        	//요청 거절
			if(confirm("친구요청을 거절하시겠습니까?")) {
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
        else if(friendState === "친구 삭제하기") {
            // 삭제
            if(confirm("친구삭제를 하시겠습니까?")) {
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

});
</script>



</body>
</html>
