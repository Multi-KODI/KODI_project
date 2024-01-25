<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 오류로 인한 임시 주석처리 PGH -->
<!-- <link rel="stylesheet" href="resources/css/WritePost.css"> -->
<script src="/js/jquery-3.7.1.min.js"></script>
<style>

</style>
</head>
<script>
window.onload = function(){
	
	showPostData();
	
	//추가------------------------------------------------------------------------ PGH
	function showPostData(){
		$("#categoryPost").val("${readPostOne.postInfo.category}").attr("selected", "selected");
		$("#point").val("${readPostOne.postInfo.grade}").attr("selected", "selected");
		$("#writePostTitle").attr("value", "${readPostOne.postInfo.title}");
		$("#writePostContent").val("${readPostOne.postInfo.content}");
		$("#tagInput").val("${readPostOne.postTags}");
		$("#addressInput").val("${readPostOne.postInfo.address}");
	}	
	//---------------------------------------------------------------------------

	function addImage() {
	    var container = document.getElementById("photoBoxs");
	    var newInput = document.createElement("input");
	    newInput.type = "file";
	    newInput.name = "imagePost";
	    newInput.accept = "image/*";
	    container.appendChild(newInput);
	}
	
	function handleKeyPress(event) {
	    if (event.key === 'Enter') {
	        event.preventDefault();
	        addTag();
	    }
	}
	
	function addTag() {
	    var inputElement = document.getElementById('tagInput');
	    var tagListElement = document.getElementById('tagList');

	    var tagValues = inputElement.value.trim().split(/#| /).filter(Boolean);

	    for (var i = 0; i < tagValues.length; i++) {
	        var tagValue = tagValues[i];

	        // 새로운 태그를 생성
	        var tagElement = document.createElement('div');
	        tagElement.className = 'tag';
	        tagElement.textContent = tagValue;

	        // 태그를 클릭하면 지워지도록 이벤트 핸들러 추가
	        tagElement.onclick = function (element) {
	            return function () {
	                tagListElement.removeChild(element);
	            };
	        }(tagElement);

	        // 태그를 목록에 추가
	        tagListElement.appendChild(tagElement);
	    }

	    // 입력창 초기화
	    inputElement.value = '';
	}
	
	function addressSearch(){
	    var inputElement = document.getElementById('tagInput');
	}
	
	//오류가 나서 임시로 주석처리 함 ------------------------------------ PGH
	/* $("#clickFileBtn").on('click', function(e){
		let data = new FormData($("#imageForm").get(0));
		$.ajax({
			url:"uploadfile",
			type="post"
			encType="multipart/form-data",
			processData:false,
			contentType:false,
			dataType="json"
			success:function(response){
		
			}
			error:function(e){
				
			}
			
			
		});//ajax
	}); *///btn
	//임시 주석 끝 -------------------------------------------------	
}

</script>
<body>
	<div class="post">
			<form id="wirtePostForm">
				<select name="categoryPost" id="categoryPost" required>
				    <option value="" selected disabled hidden>카테고리</option>
				    <!-- 수정1 시작(value값 수정) PGH-->
				    <option value="맛집">맛집</option>
				    <option value="카페">카페</option>
				    <option value="숙소">숙소</option>
				    <option value="놀거리">놀거리</option>
				    <!-- 수정1 종료 PGH-->
				    
				</select>
				&nbsp;&nbsp;
				<select name="point" id="point" required>
				    <option value="" selected disabled hidden>평점</option>
				    <!-- 수정2 시작(value값 수정) PGH-->
				    <option value="1.0">1</option>
				    <option value="1.5">1.5</option>
				    <option value="2.0">2</option>
				    <option value="2.5">2.5</option>
				    <option value="3.0">3</option>
				    <option value="3.5">3.5</option>
				    <option value="4.0">4</option>
				    <option value="4.5">4.5</option>
				    <option value="5.0">5</option>
				    <!-- 수정2 종료 PGH-->
				</select>
				<br><br>
				<div>
					<!-- 수정3 시작(value 속성 추가) PGH -->
					<input type="text" id="writePostTitle" name="writePostTitle" placeholder="제목" value="" required><br><br>
					<textarea id="writePostContent" name="writePostContent" rows="4" placeholder="내용" value="" required></textarea>
					<!-- 수정3 종료 PGH-->
				
					<br><br>
					<!-- 수정4 시작(value 속성 추가) PGH -->
				    <input type="text" id="tagInput" placeholder="#해시태그#입력" value="" onkeypress="handleKeyPress(event)">
					<!-- 수정4 종료 PGH -->
				    <button type="button" id="tagAddBtn" onclick="addTag()">추가</button>
				
				    <div id="tagList"></div>
					<br>
					
					<!-- 수정5 시작(value 속성 추가) PGH -->
				    <input type="text" id="addressInput" placeholder="주소" value="" onkeypress="handleKeyPress(event)">
					<!-- 수정5 종료 PGH -->
				    <button type="button" id="addressSearchBtn" onclick="serchAddress()">주소 검색</button>
					<br><br>
					
					<!-- 오류로 인한 임시 주석처리 PGH -->
					<!-- <button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="resources/images/search.png">&nbsp;사진첨부</button> -->
					
					<span class="photoBoxs" id= "photoBoxs">	
						<input type="file" id="photoBox" name="imagePost" accept="image/*" >
					</span>
					
					<br><br>
					<div id="garo_btns">
			    		<input type="submit" id="finishBtn" class="btn" value="작성완료">
			    		&nbsp;&nbsp;&nbsp;&nbsp;
			    		<input type="button" id="cancelBtn" class="btn" value="취소">

					</div>

				</div>
			</form>
		</div>
</body>
</html>