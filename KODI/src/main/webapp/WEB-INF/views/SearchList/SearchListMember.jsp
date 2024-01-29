<%@page import="java.util.regex.Pattern"%>
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
				
				<td>
					<button class="fBtn" type="button" data-member-idx="${member.memberIdx}"></button>
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
	
	
	
    $(".fBtn").each(function() {
        var friendStatus = $(this).text().trim();
        switch (friendStatus) {
            case "서로친구":
            case "내가 추가한 친구":
            case "나를 추가한 친구":
                $(this).text("삭제");
                break;
            case "유저":
                $(this).text("친구신청");
                break;
            default:
                break;
        }
    });

    $("#memberList").on("click", ".fBtn", function() {
        var memberId = $(this).data("member-idx");
        var friendStatus = $(this).text().trim();
        
        if (friendStatus === "유저") {
            // 친구신청
            if (confirm("친구신청 하시겠습니까?")) {
                $.ajax({
                    url: '/api/friendRequest/' + memberId,
                    type: 'POST',
                    success: function(response) {
                        $("#memberList").find("[data-member-idx='" + memberId + "']").text("삭제");
                    },
                    error: function(xhr, status, error) {
                    }
                });
            }
        } else {
            // 삭제
            if (confirm("친구삭제를 하시겠습니까?")) {
                $.ajax({
                    url: '/api/removeFriend/' + memberId,
                    type: 'POST',
                    success: function(response) {
                        $("#memberList").find("[data-member-idx='" + memberId + "']").text("친구신청");
                    },
                    error: function(xhr, status, error) {
                    }
                });
            }
        }
    }); //클릭

});
</script>



</body>
</html>
