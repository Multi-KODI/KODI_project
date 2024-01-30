<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/WritePost.css">
<style>

</style>
<script>


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
	
	function clickFileBtn() {
		
	}
     
</script>
</head>
<body>
	<div class="post">
			<form action="/api/post/issave" method="post" enctype="multipart/form-data">
				<select name="categoryPost" id="categoryPost" required>
				    <option value="" selected disabled hidden>카테고리</option>
				    <option value="food">맛집</option>
				    <option value="cafe">카페</option>
				    <option value="hotel">숙소</option>
				    <option value="play">놀거리</option>
				</select>
				&nbsp;&nbsp;
				<select name="point" id="point" required>
				    <option value="" selected disabled hidden>평점</option>
				    <option value="one">1</option>
				    <option value="onePointFive">1.5</option>
				    <option value="two">2</option>
				    <option value="twoPointFive">2.5</option>
				    <option value="three">3</option>
				    <option value="threePointFive">3.5</option>
				    <option value="four">4</option>
				    <option value="fourPointFive">4.5</option>
				    <option value="five">5</option>
				</select>
				<br><br>
				<div>
					<input type="text" id="writePostTitle" name="writePostTitle" placeholder="제목" required><br><br>
					<textarea id="writePostContent" name="writePostContent" rows="4" placeholder="내용" required></textarea>
				
					<br><br>
				    <input type="text" id="tagInput" placeholder="#해시태그#입력" onkeypress="handleKeyPress(event)">
				    <button type="button" id="tagAddBtn" onclick="addTag()">추가</button>
				
				    <div id="tagList"></div>
					<br>
					
				    <input type="text" id="addressInput" placeholder="주소" onkeypress="handleKeyPress(event)">
				    <button type="button" id="addressSearchBtn" onclick="serchAddress()">주소 검색</button>
					<br><br>
					
					<button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="resources/images/search.png">&nbsp;사진첨부</button>
					
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