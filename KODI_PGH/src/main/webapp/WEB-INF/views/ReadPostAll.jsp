<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.7.1.min.js"></script>
</head>

<script>
	$(document).ready(function(){
		showPost();
	});
	
	function showPost() {
		$(".postIdx").attr("value", "${readPostAll.get(7).postInfo.postIdx}");
		$(".postImage").attr("src", "/image/db/"+"${readPostAll.get(7).postImage}");
		$(".postTitle").html("${readPostAll.get(7).postInfo.title}");
		$(".likeCnt").html("${readPostAll.get(7).likeCnt}");   
		$(".flagCountry").attr("value", "${readPostAll.get(7).country}");
		$(".flag").attr("src", "${readPostAll.get(7).flag}");
		$(".tags").html("${readPostAll.get(7).postTags}");
	};
</script>

<body>
	<h1>test</h1>
	<div id="allpost">
		<div class="postIdx">
			<img class="postImage">
			<div class="postTitle"></div>
			
			<div class="likeCnt"></div>
			
			<div class="flagCountry">
				<img class="flag">
			</div>
			<div class="tags"></div>
		</div>
	</div>	
	
	<%-- <h1>test2</h1>
	<div id="postBody">
		<c:forEach var="readPostAll" items="${readPostAll}" varStatus="status">
			<div class="postIdx" value="${readPostAll.postInfo.postIdx}">
				<img class="postImage" src="${readPostAll.postImage}">
				<div class="postTitle">${readPostAll.postInfo.title}</div>
				<div class="likeCnt">${readPostAll.likeCnt}</div>
				<div class="flagCountry" value="${readPostAll.country}">
					<img class="flag" src="${readPostAll.flag}">
				</div>
				<div class="tags">${readPostAll.postTags}</div>
			</div>
		</c:forEach>
	</div> --%>
</body>

</html>