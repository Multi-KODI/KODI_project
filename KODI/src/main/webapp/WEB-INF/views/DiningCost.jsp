<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
window.onload = function() {
	
	let jsonList = ${list};
	
    /* var jsonData = [
        { "item": "칼국수", "seoulCost": 8895, "busanCost": 8855 },
        // 추가적인 데이터를 필요에 따라]; */
    
    $("#searchBtn").on('click', function(){ 
		$.ajax({ 
			url : "dinigcost",
			data : {'item' : $("#foodSelect").val()},
			type : 'post',
			dataType : 'json',
			success : function(response){
			jsonList = JSON.stringify(response));
			}
			error:fuction(){
			}
		});//ajax

    // 테이블의 tbody 엘리먼트 참조
    var tableBody = document.getElementById("resultTbody");

    // JSON 데이터를 테이블에 추가하는 반복문
    for (var i = 0; i < jsonList.length; i++) {
        // 행 추가
        var row = tableBody.insertRow(i);

        // 셀 추가
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);

        // 데이터 설정
        cell1.textContent = jsonList[i].item;
        cell2.textContent = jsonList[i].seoulCost;
        cell3.textContent = jsonLIst[i].busanCost;
    }
}
</script>
</head>
<body>
<h3>품목</h3>
<form>
<select name="foodSelect" id="foodSelect">
	<option value="" selected disabled>카테고리</option>
	<option value="김밥">김밥(환산전)</option>
	<option value="자장면">자장면(환산전)</option>
	<option value="칼국수">칼국수(환산전)</option>
	<option value="냉면">냉면(환산전)</option>
	<option value="삼겹살(환산후)">삼겹살(환산후)(환산후)</option>
	<option value="삼겹살(환산전)">김밥(환산전)(환산전)</option>
	<option value="삼계탕">삼계탕(환산전)</option>
	<option value="비빔밥">비빔밥(환산전)</option>
	<option value="김치찌개백반">김치찌개백반(환산전)</option>
</select>
<input type="button" name="searchBtn" id="searchBtn" value="조회">
</form>
<table id="resultTable">
    <thead>
        <tr>
            <th>2023</th>
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
    <tbody id="resultTbody"></tbody>
</table>
</body>
</html>
