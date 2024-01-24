<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   <h2>컨트롤 위치 설정하기</h2>
    <p>{@link naver.maps.Position Position}과 스타일({@link naver.maps.MapTypeControl~MapTypeControlStyle MapTypeControlStyle}, {@link naver.maps.ZoomControl~ZoomControlStyle ZoomControlStyle})을 이용하여 컨트롤의 위치와 스타일을 설정하는 예제입니다. </p>
  
    <div id="map" style="width:100%;height:400px;"></div>
    
    <code id="snippet" class="snippet"></code>
</div>
</main>





<script id="code">
//지도 옵션
var mapOptions = {
		mapDataControl: false,
        zoomControl: true,
        zoomControlOptions: {
            style: naver.maps.ZoomControlStyle.LARGE,
            position: naver.maps.Position.TOP_RIGHT
        },
    };
var map = new naver.maps.Map(document.getElementById('map'), mapOptions);


//마커
var markerList = [];
var menuLayer = $('<div style="position:absolute;z-index:10000;background-color:#fff;border:solid 1px #333;padding:10px;display:none;"></div>');

map.getPanes().floatPane.appendChild(menuLayer[0]);


naver.maps.Event.addListener(map, 'click', function(e) {
    var marker = new naver.maps.Marker({
        position: e.coord,
        map: map
    });

    markerList.push(marker);
});

//마커지우기
naver.maps.Event.addListener(map, 'keydown', function(e) {
    var keyboardEvent = e.keyboardEvent,
        keyCode = keyboardEvent.keyCode || keyboardEvent.which;

    var ESC = 27;

    if (keyCode === ESC) {
        keyboardEvent.preventDefault();

        for (var i=0, ii=markerList.length; i<ii; i++) {
            markerList[i].setMap(null);
        }

        markerList = [];
        menuLayer.hide();
    }
});



    

</script>






</body>
</html>