<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
window.onload = function() {
    var jsonData = [
        { "memberName": "id1", "country": "seoul", "isFriend": true },
        { "memberName": "id2", "country": "USA", "isFriend": true },
        { "memberName": "id3", "country": "japan", "isFriend": false },
        // 추가적인 데이터를 필요에 따라
    ];

    // 테이블의 tbody 엘리먼트 참조
    var tableBody = document.getElementById("resultTbody");

    // JSON 데이터를 테이블에 추가하는 반복문
    for (var i = 0; i < jsonData.length; i++) {
        // 행 추가
        var row = tableBody.insertRow(i);

        // 셀 추가
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);

        // 데이터 설정
        cell1.textContent = jsonData[i].memberName;
        cell2.textContent = jsonData[i].country;

        // 버튼 추가
        var button = document.createElement("button");
        button.textContent = jsonData[i].isFriend ? "친구신청" : "취소";
        button.addEventListener("click", createAlert.bind(null, jsonData[i].memberName, jsonData[i].isFriend));
        cell3.appendChild(button);
    }

    function createAlert(memberName, isFriend) {
        var message = isFriend ? memberName + "에게 친구신청 되었습니다." : memberName + "와 친구취소했습니다.";
        alert(message);
    }
}
</script>
</head>
<body>
<hr>
<h4>검색 결과</h4>
<hr><br>
    <table>
        <thead>
            <tr>
                <th>닉네임</th>
                <th>국적</th>
                <th> </th>
            </tr>
        </thead>
        <tbody id="resultTbody"></tbody>
    </table>
</body>
</html>
