<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
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

<p><strong><span style="color: #6A7EFC;">${param.question}</span></strong>에 대한 검색결과 입니다.</p>



<c:forEach var="member" items="${readMemberAll}">
    <div>
        <div class="listBox">
            <div class="contentBox">
                <div id="title">
                    닉네임 : ${member.memberName}
                </div>
                
                <div id="content">
                    국적 : ${member.country}
                </div>
             
                <div id="content">
                    친구상태 : ${member.friendStatus}
                </div>
            </div>
            
        </div>
    </div>
</c:forEach>





</main>


</body>
</html>
