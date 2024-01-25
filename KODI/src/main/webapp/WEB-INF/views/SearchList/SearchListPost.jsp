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
            <th>게시글 제목</th>
            <th>작성자</th>
        </tr>
    </thead>
    <tbody id="postList">
        <c:forEach var="post" items="${readPostAll}">
            <tr>
                <td><div class="tdDiv">${post.postInfo.title}</div></td>
                <td><div class="tdDiv">${post.memberName}</div></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</main>



</body>
</html>
