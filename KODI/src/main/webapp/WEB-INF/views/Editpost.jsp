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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29b72f9b60c9876e854ca883b07bc82d"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
<script>
    /* if (${isSession}==false){
        alert("Please log in");
        location.href = "/";
  } */
    
    </script>
</head>

<body>
	<div class="post">
		<!-- 수정0 action속성 추가, name 속성 추가 및 변경 PGH -->
			<form action="/api/post/isupdate" id="wirtePostForm" method="post" enctype="multipart/form-data">
			<input type="number" name="postIdx" value="${readPostOne.postInfo.postIdx}" style="display:none">
				<select name="category" id="categoryPost" required>
					<option value="" selected disabled>Category</option>
					<!-- Edit 1 (Modified value) PGH-->
					<option value="맛집">Restaurant</option>
					<option value="카페">Cafe</option>
					<option value="숙소">Accommodation</option>
					<option value="놀거리리">Activities</option>
					<!-- Edit 1 (End) PGH-->
				</select>
				&nbsp;&nbsp;
				<select name="grade" id="point" required>
				    <option value="" selected disabled>Ratings</option>
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
					<input type="text" id="writePostTitle" name="title" placeholder="Title" value="" required><br><br>
					<hr><br>
					<textarea id="writePostContent" name="content" rows="4" placeholder="Content" value="" required></textarea>
					<!-- 수정3 종료 PGH-->
				
					<br><br>
					<!-- 수정4 시작(value 속성 추가) PGH -->
				    <input type="text" id="tagInput" placeholder="Hash Tags" value="" onkeypress="handleKeyPress(event)">
					<!-- 수정4 종료 PGH -->
				    <button type="button" id="tagAddBtn" onclick="addTag()">Add</button>
				
				    <div id="tagList"></div>
					<br>
					
					<!-- 주소검색창 display: none;인 입력창 추가 -->	
					<input type="text" id="selectedAddressShow" value="" placeholder="Shop address" readonly >&nbsp;
					<input type="text" id="selectedAddressReal" name="address" value="" placeholder="Shop address" required>&nbsp;
					<input type="button" id="addressBtn" onclick="openModal()" value="Search an address">

					<br><br>
			<!-- 수정0 종료 PGH -->
					<div id="modal">
						<div class="pop">
							<div class=modal-header>
								<input id="inputStoreName" placeholder="Place, Address" type="text" >&nbsp;
								<button id ="searchAddressBtn" type="button" onclick="searchAddress()">Search</button>&nbsp;
								<button id ="closeModalBtn" type="button" onclick="closeModal()">Close</button>
								<div class="labels"></div>
							</div>
						</div>
					</div>
					
					<button type="button" id="imageAddBtn" class="btn" onclick="addImage()"><img id="addImageIcon" src="/image/icon/fileupload.png">&nbsp;Add a picture</button><br>
					
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
	
	function showPostData(){
		$("#categoryPost").val("${readPostOne.postInfo.category}").attr("selected", "selected");
		$("#point").val("${readPostOne.postInfo.grade}").attr("selected", "selected");
		$("#writePostTitle").attr("value", "${readPostOne.postInfo.title}");
		$("#writePostContent").val("${readPostOne.postInfo.content}");
		/* 은선 수정 id */
		$("#selectedAddress").val("${readPostOne.postInfo.address}");
		var tagListElement = document.getElementById('tagList');
		var tagValue = "${readPostOne.postTags}";
		tagValue = tagValue.substring(1);
	    tagValue = tagValue.substring(0, tagValue.length-1);
		if(tagValue!==""){
	      /* 검증 */console.log(tagValue);
	      /* 검증 */console.log(tagValue.split(", "));
	      var tagValues = tagValue.split(", ");

			for (var i = 0; i < tagValues.length; i++) {
			    var tagValue = tagValues[i];
			    // 새로운 태그를 생성
			    var inputHidden = document.createElement('input');
			    inputHidden.name = "postTags";
			    inputHidden.value = tagValue;
			    inputHidden.hidden=true;
			
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
		}
	}
		var container = document.getElementById("photoBoxs");
		var imageSrc = "${readPostOne.postImages}";
		imageSrc = imageSrc.substring(1);
		imageSrc = imageSrc.substring(0, imageSrc.length-1);
		/* 검증 */console.log(imageSrc);
		var imageSrcs = imageSrc.split(", ");
		/* 검증 */console.log(imageSrcs);
		
		for(var i=0; i<imageSrcs.length; i++) {
			var imageSrc = "/image/db/" + imageSrcs[i];
			// 새로운 이미지 태그를 생성(db에 저장되어 있는 이미지를 보여주기 위해)
			var inputImage = document.createElement("img");
			inputImage.type = "image";
			inputImage.name = "alreadySaveImage";
			inputImage.id = "myImage";
			inputImage.src = imageSrc;
			inputImage.width = "200";
			inputImage.height = "200";
			
			// 이미지 태그를 사진 추가 밑에 추가
			container.appendChild(inputImage);
		}
		container.appendChild(document.createElement('br'));
	
	

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
			}//for 종료
		}//success 종료
	});//ajax 종료
} 
	
function openModal(){
	$("#modal").show();
}
function closeModal(){
	$("#modal").hide();
}

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
			/* 태그 구현 */
	
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
		    inputHidden.hidden = true;
		
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
