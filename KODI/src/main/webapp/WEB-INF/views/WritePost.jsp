<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writepost</title>
<link rel="stylesheet" href="/css/WritePost.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29b72f9b60c9876e854ca883b07bc82d"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<script>
    /* if (${isSession}==false){
        alert("로그인하세요");
        location.href = "/";
  }
     */
    </script>
    

</head>
<body>
	<div class="post">
			<form action="/api/post/issave" method="post" enctype="multipart/form-data">
				<select name="categoryPost" id="categoryPost" required>
				    <option value="" selected disabled>카테고리</option>
				    <option value="food">맛집</option>
				    <option value="cafe">카페</option>
				    <option value="hotel">숙소</option>
				    <option value="play">놀거리</option>
				</select>
				&nbsp;&nbsp;
				<select name="point" id="point" required>
				    <option value="" selected disabled>평점</option>
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
					<hr><br>
					<textarea id="writePostContent" name="writePostContent" rows="7" placeholder="내용" required></textarea>
				
					<br><br>
				    <input type="text" id="tagInput" placeholder="#해시태그#입력" onkeypress="handleKeyPress(event)">&nbsp;
				    <button type="button" id="tagAddBtn" onclick="addTag()">추가</button>
				
				    <div id="tagList"></div>
					<br>
					
					
					<input type="text" id="selectedAddress" name="address" value="" placeholder="가게주소" readonly>&nbsp;
					<input type="button" id="addressBtn" onclick="openModal()" value="주소검색">
					
					<div id="modal">
						<div class="pop">
							<div class=modal-header>
								<input id="inputStoreName" placeholder="장소, 주소" type="text" >&nbsp;
								<button id ="searchAddressBtn" type="button" onclick="searchAddress()">검색</button>&nbsp;
								<button id ="closeModalBtn" type="button" onclick="closeModal()">창닫기</button>
								<div class="labels"></div>
							</div>
						</div>
					</div>
					
					<br><br>
					
					<button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="/image/icon/fileupload.png">&nbsp;사진추가</button>
					
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


									/* 주소검색 api */
									
function searchAddress(){
	var parentElement = $('.labels')[0];
	parentElement.innerHTML='';
	let key = "29b72f9b60c9876e854ca883b07bc82d";
	
	var searching = $("#inputStoreName").val();
	
	headers = {
	  "Authorization": "KakaoAK d6dfd391f52c1cbae3bcea85ff0057ef"
	}


	$.ajax({
	    url: 'https://dapi.kakao.com/v2/local/search/keyword.json?query='+searching,
	    headers: headers,
	    type: 'get',
	    dataType: 'json',
	    success: function (places) {
	    	console.log(places);
	    	
	        for(var i=0; i < places.documents.length; i++){
	        	var label = document.createElement('label');
	        	
	            // 라벨의 id를 설정합니다.
	            label.id = 'label' + i;
	            label.className = 'label';
	            
	            
	            // 라벨의 내용을 설정합니다.
	            label.innerHTML = places.documents[i].address_name+'   '+'( '+places.documents[i].place_name+' )';
	        	
	            // 라벨 누를 때 이벤트 추가
	            label.onclick = function (place) {
	                return function () {
	                    $('#selectedAddress').val(place.address_name);
	               
	                    closeModal();
	                };
	            }(places.documents[i]); // 클로저를 이용하여 현재 반복된 항목의 정보를 전달합니다.
	            
	            parentElement.appendChild(document.createElement('br'));
	            parentElement.appendChild(label);
	            parentElement.appendChild(document.createElement('br'));

	            // 줄 바꿈을 추가하여 가독성을 높입니다.
	        }
	    }
	});


}
									
function openModal(){
	$("#modal").show();
}
function closeModal(){
	$("#modal").hide();
}

							/* 파일첨부 */
function addImage() {
            var container = document.getElementById("photoBoxs");
            // 새로운 파일 첨부 input 태그 생성
            var newInput = document.createElement("input");
            newInput.type = "file";
            newInput.name = "imagePost";	//변경 PGH
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
            
            var newBr = document.createElement("br");
            
            // 이미지와 버튼을 컨테이너에 추가
            
         
            containerDiv.appendChild(newInput);
            containerDiv.appendChild(newIcon);

            // 클릭한 이미지를 포함한 부모 요소를 삭제
            newIcon.onclick = function () {
                container.removeChild(containerDiv);
                container.removeChild(newBr);
            };

            // 줄 바꿈 태그 생성

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
	        var inputHidden = document.createElement('input');
	        inputHidden.name = "postTags";
	        inputHidden.value = tagValue;

	        var tagElement = document.createElement('div');
	        tagElement.className = 'tag';
	        tagElement.textContent = tagValue;

	        // 태그를 클릭하면 지워지도록 이벤트 핸들러 추가
	        tagElement.onclick = function (tagDiv, tagInput) {
	            return function () {
	                tagListElement.removeChild(tagDiv);
	                tagInput.parentNode.removeChild(tagInput); // 숨겨진 input 요소도 함께 제거
	            };
	        }(tagElement, inputHidden);

	        // 태그를 목록에 추가
	        tagListElement.appendChild(tagElement);
	        tagListElement.appendChild(inputHidden); // 숨겨진 input 요소도 함께 추가
	    }

	    // 입력창 초기화
	    inputElement.value = '';
	}

	
	
     
</script>
</html>