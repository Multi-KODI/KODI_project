<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:eval var="googleKey" expression="@environment.getProperty('google.api.key')" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/Map.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ao70uqkz7f"></script>
<title>map</title>
</head>
<body>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>

<main>
	<div id="wrap" class="section">
		<h2>My Map</h2>
		<p>Google Maps</p>
		<div>
			<button id="myMark">My Marker</button>
			<button id="friendMark">Friend's Marker</button>
		</div>
	  
		<div id="googleMap" style="width:100%;height:600px;"></div>
		
		<code id="snippet" class="snippet"></code>
	</div>
	
</main>

<script>
//지도 옵션
function initMap(address) {
	
    // Geocoder 객체를 선언
    let geocoder = new google.maps.Geocoder();
    let korea = {lat: 35.9078, lng: 127.7669};
    
 	// 지도 옵션
    var mapOptions = {
        center: korea, // 지도의 중심에 표시할 장소
        zoom: 7, // 몇 배 확대해서 보여줄 것인지
        disableDefaultUI:true,
        zoomControl: true // 지도 확대/축소 가능 여부
    };
 	
 	// 지도를 보여줄 div 영역의 id 값과 위에서 지정한 옵션을 map에 등록
    var map = new google.maps.Map(
        document.getElementById("googleMap"), mapOptions );
	
 	if(address.length != 0){
 		for(let i=0; i<address.length; i++){
 	    	geocoder.geocode({ address: address[i] }, (results, status) => {
 	            if (status === 'OK') {
 	                // 해당 장소의 위도와 경도 가져오기
 	                const latitude = results[0].geometry.location.lat();
 	                const longitude = results[0].geometry.location.lng();
 	                console.log('위도:', latitude);
 	                console.log('경도:', longitude);

 	                // 장소의 위도와 경도 정보를 담은 객체 선언
 	                let mylocation = {lat: latitude, lng: longitude};
 	     
 	                // 지도에 표시할 마커를 생성
 	                var marker = new google.maps.Marker({position: mylocation, map: map});

 	              	// 마커를 클릭했을 때 보여주고 싶은 문구가 있을 경우 추가
 	                var infoWindow = new google.maps.InfoWindow({
 	                    content: `
 	                        <h6>${address}</h6>
 	                        <a href="https://google.com/maps/place/${address[i]}" target="_blank">View on Google Maps</a>
 	                    `
 	            	});

 	              	// 마커 클릭 이벤트 등록
 	                marker.addListener('click', () => {
 	                    infoWindow.open(map, marker);
 	                });
 	         	} else {
 	                  console.error('지오코딩 실패:', status);
 	            }
 	        });
 	    }
 	}
}

$("#myMark").on("click", function() {
	var temp = "myMark";
	$.ajax({
		url: 'map/marking', 
		type: 'POST',
		data:{
			marking: temp
		},
		success: function(markList){
			console.log("성공");
			initMap(markList);
		},
		error: function(error){
			console.log(error)
		}
	});
});

$("#friendMark").on("click", function() {
	var temp = "friendMark";
	$.ajax({
		url: 'map/marking', 
		type: 'POST',
		data:{
			marking: temp
		},
		success: function(markList){
			console.log("성공");
			initMap(markList);
		},
		error: function(error){
			console.log(error)
		}
	});
});


</script>
<script src="https://maps.googleapis.com/maps/api/js?key=${googleKey}&callback=initMap"></script>

</body>
</html>