<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<spring:eval var="googleKey" expression="@environment.getProperty('google.api.key')" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/Map.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
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
        <div class="titleBox">
            🗺️
        </div>

        <div class="btnBox">
            <button class="mapBtn" id="myMark">나의 마커</button>
            <button class="mapBtn" id="friendMark">친구의 마커</button>
        </div>

        <div id="googleMap" style="width: 100%; height: 600px;"></div>

        <code id="snippet" class="snippet"></code>
    </div>
</main>

<script>
// 지도 옵션
function initMap(addresses, zoomLevel) {
	// Geocoder 객체를 선언
    let geocoder = new google.maps.Geocoder();
    let korea = {lat: 35.9078, lng: 127.7669};
    
	// 지도 옵션
    let mapOptions = {
        center: korea,
        zoom: zoomLevel || 7,
        disableDefaultUI: true,
        zoomControl: true
    };
	
 // 지도를 보여줄 div 영역의 id 값과 위에서 지정한 옵션을 map에 등록
    let map = new google.maps.Map(document.getElementById("googleMap"), mapOptions);
    let bounds = new google.maps.LatLngBounds();

    addresses.forEach(function(address) {
        geocoder.geocode({ address: address }, function(results, status) {
            if (status === 'OK') {
            	// 해당 장소의 위도와 경도 가져오기
                let location = results[0].geometry.location;
            	
             	// 지도에 표시할 마커를 생성
                let marker = new google.maps.Marker({ position: location, map: map });
                bounds.extend(marker.getPosition());
                
          		// 마커를 클릭했을 때 보여주고 싶은 문구가 있을 경우 추가
                marker.addListener('click', function() {
                    let infoWindow = new google.maps.InfoWindow({
                        content: 
                        `
                        <div style="font-family: 'NanumSquareNeo';  ">
                        ` + address + `
                        <a href="https://google.com/maps/place/` + address + `" target="_blank">구글 지도에서 보기</a>
                        `
                    });
                    infoWindow.open(map, marker);
                });
                map.fitBounds(bounds);
            } else {
                console.error('지오코딩 실패:', status);
            }
        });
    });
};



$(document).ready(function() {
     if (${isSession} == false) {
            alert("로그인하세요");
            location.href = "/";
        } else {
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
            initMap(markList, 10);
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
            initMap(markList,10);
        },
        error: function(error){
            console.log(error)
        }
    });
});


}
     
}); //ready
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=${googleKey}&callback=initMap"></script>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>
