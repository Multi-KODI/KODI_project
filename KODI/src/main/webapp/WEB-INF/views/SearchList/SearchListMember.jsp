<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/SearchList.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title></title>
<script>

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

<main>
<table border="1">
    <thead>
        <tr>
            <th>사용자 이름</th>
            <th>국가</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="member" items="${readMemberAll}">
            <tr>
                <td><div class="tdDiv">${member.memberName}</div></td>
                <td><div class="tdDiv">${member.country}</div></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</main>


</body>
</html>
