<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>KODI</title>

	<link href="/css/ReadPostOne.css"
		rel="stylesheet">
		
	<script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/ReadPostOne.js"></script>
</head>

<body>
	<div id="allElement">
		<!-- 게시물 정보 -->
		<div id="postAllInfo">
			<div class="moreHoriz">
				<button class="moreHorizBtn">
					<img class="moreHorizImg"
						src="/image/more_horiz.svg" width="24"
						height="24"></img>
				</button>
				<div class="option">
					<button class="optionBtn" id="updatePostBtn" value="update">게시글
						수정</button>
					<button class="optionBtn" id="deletePostBtn" value="delete">게시글
						삭제</button>
				</div>
			</div>
			
			<h2 id="postTitle">게시글 제목</h2>
			
			<div id="postInfo">
				<p id="grade" style="display: inline;">평점 3.5/5</p>
				<p id="memberName" style="display: inline;">작성자</p>
				<p id="date" style="display: inline;">2023.11.08. 15:48</p>
			</div>

			<hr width="300px" align="left" />
			
			<div id="postContent">
				<p>게시글 내용</p>
			</div>			
		</div>

		<!-- 좋아요, 마킹, 공유 -->

		<!-- 댓글 -->

	</div>
</body>
</html>