<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>editpost</title>
<link rel="stylesheet" href="/css/WritePost.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    /* if (${isSession}==false){
        alert("로그인하세요");
        location.href = "/";
  } */
    
    </script>
</head>

<body>
	<div class="post">
			<form id="wirtePostForm" method="post" enctype="multipart/form-data">
				<select name="categoryPost" id="categoryPost" required>
				    <option value="" selected disabled hidden>카테고리</option>
				    <!-- 수정1 시작(value값 수정) PGH-->
				    <option value="" selected disabled>카테고리</option>
				    <option value="맛집">맛집</option>
				    <option value="카페">카페</option>
				    <option value="숙소">숙소</option>
				    <option value="놀거리">놀거리</option>
				    <!-- 수정1 종료 PGH-->
				    
				</select>
				&nbsp;&nbsp;
				<select name="point" id="point" required>
				    <option value="" selected disabled>평점</option>
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
				    <input type="text" id="sample6_address" placeholder="주소" value="" onkeypress="handleKeyPress(event)">
					<!-- 수정5 종료 PGH -->
				    <input type="button" id="addressBtn" onclick="sample6_execDaumPostcode()" value="주소검색">
					<br><br>
					
					<button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="resources/images/search.png">사진추가</button><br>
					
					<span class="photoBoxs" id= "photoBoxs">	
						<input type="file" id="photoBox" name="files" accept="image/*" >
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
<script>

	showPostData();
	
	//추가------------------------------------------------------------------------ PGH
	function showPostData(){
		$("#categoryPost").val("${readPostOne.postInfo.category}").attr("selected", "selected");
		$("#point").val("${readPostOne.postInfo.grade}").attr("selected", "selected");
		$("#writePostTitle").attr("value", "${readPostOne.postInfo.title}");
		$("#writePostContent").val("${readPostOne.postInfo.content}");
		$("#addressInput").val("${readPostOne.postInfo.address}");
		var tagListElement = document.getElementById('tagList');
		var tagValue = "${readPostOne.postTags}";
		
	      tagValue = tagValue.substring(1);
	      tagValue = tagValue.substring(0, tagValue.length-1);
	      console.log(tagValue);
	      console.log(tagValue.split(", "));
	      var tagValues = tagValue.split(", ");

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

	}
	//---------------------------------------------------------------------------

 function addImage() {
            var container = document.getElementById("photoBoxs");
            // 새로운 파일 첨부 input 태그 생성
            var newInput = document.createElement("input");
            newInput.type = "file";
            newInput.name = "files";
            newInput.id = "files";
            newInput.accept = "image/*";

            // 새로운 이미지 아이콘 생성
            var newIcon = document.createElement("img");
            newIcon.src = "/image/icon/x.png";  // 이미지 소스 경로에 실제 이미지 파일 경로를 지정해야 합니다.
            newIcon.alt = "Delete";
            newIcon.style.cursor = "pointer";

            // 이미지와 버튼을 감싸는 컨테이너 생성
            var containerDiv = document.createElement("div");
            containerDiv.id="image-container";
            containerDiv.classList.add("image-container");
            
            // 이미지와 버튼을 컨테이너에 추가
            containerDiv.appendChild(newInput);
            containerDiv.appendChild(newIcon);

            // 클릭한 이미지를 포함한 부모 요소를 삭제
            newIcon.onclick = function () {
                container.removeChild(containerDiv);
                container.removeChild(newBr);
            };

            // 줄 바꿈 태그 생성
            var newBr = document.createElement("br");

            // input과 이미지, br 태그를 컨테이너에 추가
            container.appendChild(containerDiv);
            container.appendChild(newBr);
        
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
	
	
	/* 주소검색 api */
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            } 
	          
	            document.getElementById("sample6_address").value = addr;
	      
	        }
	    }).open();
	}

</script>
</html>