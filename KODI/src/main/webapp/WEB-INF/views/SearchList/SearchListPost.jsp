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



<c:forEach var="post" items="${readPostAll}">
    <div>
        <div class="listBox">
            <div class="contentBox">
                <div id="title">
                    <a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
                       ${post.postInfo.title}
                    </a>
                </div>
                <div id="content">
                    <a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
                        ${post.postInfo.content}
                    </a>
                </div>
                <div class="tagBox">
                    ${post.postTags}
                </div>
                <div class="nameBox">
                    <div id="memberName">
                        ${post.memberName}
                    </div>
                    <div id="date">
                        ${post.postInfo.regdate}
                    </div>
                </div>
            </div>
            <div id="imageBox">
                <a href="${path}/api/post/${post.postInfo.postIdx}">
        			<img src="${path}/image/db/${post.postImage}">
   				</a>
            </div>
        </div>
    </div>
</c:forEach>





</main>

<script>
const emojis = [ '😀', '😆', '😍', '🥰', '😘', '😙', '☺️', '🤗' ];

function getRandomEmoji() {
	return emojis[Math.floor(Math.random() * emojis.length)];
}

$(document).ready(
function() {
	$(".nameBox").each(function() {
        var memberNameDiv = $(this).find("#memberName");
        var memberName = memberNameDiv.text().trim();
        var randomEmoji = getRandomEmoji();
        memberNameDiv.html(randomEmoji + ' ' + memberName);
    });
	
	$(".tagBox").each(
			function() {
				var tags = $(this).text();
				var updatedTags = tags.replace(/\[(.*?)\]/g,
						'<span class="tag">$1</span>');
				$(this).html(updatedTags);
			});
});
</script>

</body>
</html>
