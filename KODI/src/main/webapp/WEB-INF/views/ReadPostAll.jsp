<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/ReadPostAll.css">

</head>

<body>
<main>
<div class="categoryBox">
	<button class="categoryBtn" id="food">맛집</button>
	<button class="categoryBtn" id="cafe">카페</button>
	<button class="categoryBtn" id="play">놀거리</button>
	<button class="categoryBtn" id="hotel">숙소</button>
</div>
<div class="container">
<c:forEach var="post" items="${readPostAll}">
<div class="listBox">
 	<div class="contentBox">
		<div id="image">
			<a href="/api/post/${post.postInfo.postIdx}" class="post-link">
      			<img src="/image/db/${post.postImage}">
			</a>
     	</div>
     	<div class="firstLine">
     	<div id="title">
	 		<a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
		    	${post.postInfo.title}
		 	</a>
      	</div>
      	<div id="rightSide">
				<img id="flagImage" src="${post.flag}">
	   			<img id="likeCount" src="/image/icon/love.png">
	            <label id="likeCountNum">${post.likeCnt}</label>
	     
      	</div>
     	</div>
       	<div class="address">
			${post.postInfo.address}
        </div>
        <c:forEach items="${post.postTags}" var="tag">
			<div style=" display: inline; border: 2px solid #FF5656; background-color: #FF5656; border-radius: 10px; color: white; padding-left: 10px; padding-right: 10px; margin-left: 10px;">${tag}</div>
		</c:forEach>
	</div>
</div>
</c:forEach>
</div>
<script>

var category = "${category}";
if(category == "맛집"){
	$("#food").css("background-color", "#EDF2F6");
}else if(category == "카페"){
	$("#cafe").css("background-color", "#EDF2F6");
}else if(category == "놀거리"){
	$("#play").css("background-color", "#EDF2F6");
}else if(category == "숙소"){
	$("#hotel").css("background-color", "#EDF2F6");
}

$("#food").on("click", function(){
	location.href = "/api/posts/food";
});

$("#cafe").on("click", function(){
	location.href = "/api/posts/cafe";
});

$("#play").on("click", function(){
	location.href = "/api/posts/play";
});

$("#hotel").on("click", function(){
	location.href = "/api/posts/hotel";
	/* $.ajax({
		url:"post/category",
		data:{
			category:"숙소"
		},
		type:"post",
		success: function(){},
		error: function(){}
	}); */
});

</script>
</main>
</body>
</html>