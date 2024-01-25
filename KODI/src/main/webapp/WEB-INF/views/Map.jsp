<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>map</title>
<link rel="stylesheet" href="/css/Map.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAJoAXcA093tF-9xOvr7PgJgcRbYkV31u8&callback=myMap"></script>
</head>

<script>
	$(document).ready(function(){
		myMap();
	});

	function myMap(){
	    var mapOptions = { 
	          center:new google.maps.LatLng(36.5519, 127.5918),
	          zoom:7
	    };
	
	    var map = new google.maps.Map( 
	           document.getElementById("googleMap") 
	          , mapOptions );
	 }
</script> 
<body>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>

<div id="googleMap" style="width:70%; height:500px;"></div>


</body>
</html>