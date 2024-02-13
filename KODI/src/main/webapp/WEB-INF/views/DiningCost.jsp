<%@page import="dto.DiningCostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KODI</title>
<script src="/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/DiningCost.css">
<script type="text/javascript">
$(document).ready(function(){
	if(${isSession} == false) {
		alert("로그인하세요");
		location.href = "/";
	} else {
		$("#searchBtn").on('click', function(){
			if($("#foodSelect").val() == "전체"){
				$("#resultTbody").empty();
				<c:forEach var="item" items="${list}">
					$("#resultTbody").append(
						"<tr><td>" + "${item.item}" + "</td>" +
						"<td>" + ${item.seoulCost} + "</td>" +
						"<td>" + ${item.busanCost} + "</td>" +
						"<td>" + ${item.daeguCost} + "</td>" +
						"<td>" + ${item.incheonCost} + "</td>" +
						"<td>" + ${item.gwangjuCost} + "</td>" +
						"<td>" + ${item.daejeonCost} + "</td>" +
						"<td>" + ${item.ulsanCost} + "</td>" +
						"<td>" + ${item.gyeonggiCost} + "</td>" +
						"<td>" + ${item.gangwonCost} + "</td>" +
						"<td>" + ${item.chungbukCost} + "</td>" +
						"<td>" + ${item.chungnamCost} + "</td>" +
						"<td>" + ${item.jeonbukCost} + "</td>" +
						"<td>" + ${item.jeonnamCost} + "</td>" +
						"<td>" + ${item.gyeongbukCost} + "</td>" +
						"<td>" + ${item.gyeongnamCost} + "</td>" +
						"<td>" + ${item.jejuCost} + "</td></tr>");
				</c:forEach>
			} else {
				$.ajax({
			        url: "/api/diningcost",
			        data: {
			            "item": $("#foodSelect").val()
			        },
			        type: "post",
			        success: function(response) {
			        	$("#resultTbody").html("<tr><td>"+ response.item + "</td><td>"+response.seoulCost+"</td><td>"+response.busanCost+"</td><td>"+response.daeguCost+"</td><td>"+ response.incheonCost+"</td><td>"+response.gwangjuCost+"</td><td>"+response.daejeonCost+"</td><td>"+response.ulsanCost+"</td><td>"+response.gyeonggiCost+"</td><td>"+response.gangwonCost+"</td><td>"+response.chungbukCost+"</td><td>"+response.chungnamCost+"</td><td>"+response.jeonbukCost+"</td><td>"+response.jeonnamCost+"</td><td>"+response.gyeongbukCost+"</td><td>"+response.gyeongnamCost+"</td><td>"+response.jejuCost+"</td></tr>");
			        },
			        error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
			    }); //ajax
			}
		});
	}
})
</script>
</head>
<body>
<main>
	<div id="categoryBox" style="display: block">
		<span id="category">
			<label>품목</label>&nbsp;&nbsp;
			<select name="foodSelect" id="foodSelect">
					<option value="카테고리" selected disabled>카테고리</option>
					<option value="전체">전체</option>
					<option value="김밥">김밥</option>
					<option value="자장면">자장면</option>
					<option value="칼국수">칼국수</option>
					<option value="냉면">냉면</option>
					<option value="삼겹살 (환산후)">삼겹살(환산후)</option>
					<option value="삼겹살 (환산전)">삼겹살(환산전)</option>
					<option value="삼계탕">삼계탕</option>
					<option value="비빔밥">비빔밥</option>
					<option value="김치찌개백반">김치찌개백반</option>
			</select>
		</span> &nbsp;&nbsp;
		<input type="button" name="searchBtn" id="searchBtn" value="조회">
	</div>
	<div id="result">
		<table id="resultTable">
			<thead>
				<tr>
					<th colspan="17">2023</th>
				</tr>
				<tr>
					<th>품목</th>
					<th>서울</th>
					<th>부산</th>
					<th>대구</th>
					<th>인천</th>
					<th>광주</th>
					<th>대전</th>
					<th>울산</th>
					<th>경기</th>
					<th>강원</th>
					<th>충북</th>
					<th>충남</th>
					<th>전북</th>
					<th>전남</th>
					<th>경북</th>
					<th>경남</th>
					<th>제주</th>
				</tr>
			</thead>
			<tbody id="resultTbody">
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.item}</td>
						<td>${item.seoulCost}</td>
						<td>${item.busanCost}</td>
						<td>${item.daeguCost}</td>
						<td>${item.incheonCost}</td>
						<td>${item.gwangjuCost}</td>
						<td>${item.daejeonCost}</td>
						<td>${item.ulsanCost}</td>
						<td>${item.gyeonggiCost}</td>
						<td>${item.gangwonCost}</td>
						<td>${item.chungbukCost}</td>
						<td>${item.chungnamCost}</td>
						<td>${item.jeonbukCost}</td>
						<td>${item.jeonnamCost}</td>
						<td>${item.gyeongbukCost}</td>
						<td>${item.gyeongnamCost}</td>
						<td>${item.jejuCost}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</main>
</body>

<%@ include file="/WEB-INF/views/Footer.jsp" %>

</html>
