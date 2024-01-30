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
<link rel="stylesheet" href="/css/Planner.css">
</head>
<body>

<div class="categoryBox">
	<button class="categoryBtn" id="food">맛집</button>
	<button class="categoryBtn" id="cafe">카페</button>
	<button class="categoryBtn" id="play">놀거리</button>
	<button class="categoryBtn" id="hotel">숙소</button>
</div>

<c:forEach var="post" items="${readPostAll}">
<div class="listBox">
 	<div class="contentBox">
		<div id="image">
			<a href="/api/post/${post.postInfo.postIdx}" class="post-link">
      			<img src="/image/db/${post.postImage}">
			</a>
     	</div>
     	<div id="title">
	 		<a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
		    	${post.postInfo.title}
		 	</a>
      	</div>
      	<div id="flagImage">
			<img src="/image/db/${post.flag}">
  		</div>
      	<div class="likeCount">
   			<img src="/image/icon/love.png">
            ${post.likeCnt}
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
<script>

var category = getAttribute(category);
if(category == "food"){
	$("#food").css("background-color", "#EDF2F6");
}else if(category == "cafe"){
	$("#cafe").css("background-color", "#EDF2F6");
}else if(category == "play"){
	$("#play").css("background-color", "#EDF2F6");
}else if(category == "hotel"){
	$("#hotel").css("background-color", "#EDF2F6");
}

$("#food").onclick(function(){
	$.ajax({
		url:"api/post",
		data:{
			category:"food"
		},
		type:"post",
		success: function(){},
		error: function(){}
	});
});

$("#cafe").onclick(function(){
	$.ajax({
		url:"api/post",
		data:{
			category:"cafe"
		},
		type:"post",
		success: function(){},
		error: function(){}
	});
});

$("#play").onclick(function(){
	$.ajax({
		url:"api/post",
		data:{
			category:"play"
		},
		type:"post",
		success: function(){},
		error: function(){}
	});
});

$("#hotel").onclick(function(){
	$.ajax({
		url:"api/post",
		data:{
			category:"hotel"
		},
		type:"post",
		success: function(){},
		error: function(){}
	});
});

</script>
</body>
</html>