<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/FriendList.css">
<title></title>

<style>

</style>
</head>

<body>
<div class="friendbox" id="friendModal" tabindex="-1" role="dialog"
	aria-labelledby="friendModalLabel" aria-hidden="true">
		
<div class="mainBox">
	<div class="contentBox">
		
	<div class="logoBtn">
		<dlv id="friendheader"> 
			<img id="logo-icon" src="/image/icon/logo.png"> <h2>친구목록</h2>
		</dlv>
		
		<div class="form-group" >
			<button id="PairBtn"style="background-color: #999999;">서로친구</button>
			<button id="FollowingBtn">내가 추가한 친구</button>
			<button id="FollowerBtn">나를 추가한 친구</button>
		</div>
		
	</div>
<div class="friendList">
    <div id="list">
     <!-- 서로친구 -->
        <table>
            <thead>
                <tr>
                    <th>
                        <div class="tdDiv">닉네임</div>
                    </th>
                    <th>
                        <div class="tdDiv">국적</div>
                    </th>
                    <th>
                        <div class="tdDiv">친구여부</div>
                    </th>
                    <th>
                        <div class="tdDiv"></div>
                    </th>

                </tr>
            </thead>

            <tbody id="friendList">
                <c:forEach var="member" items="${allFriends}">
                    <tr>
                        <td>
                            <div class="tdDiv">${member.nickname}</div>
                        </td>
                        <td>
                            <div class="tdDiv">${member.nationality}</div>
                        </td>
                        <td>
                            <div class="tdDiv">${친구상태}</div>
                        </td>
                        <td>
                            <button class="f-Btn" id="f-drawBtn" type="button" data-member-idx="${친구번호}">친구삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        
    </div>
</div>

		
</div>
		<div class="friend-btn"><button type="button"  id="closebtn">닫기</button></div>
		
</div>
	
	
</div>


			

	

<script>
$(document).ready(function() {

	//닫기버튼
	$("#closebtn").on("click", function() {
		$(".modal_background2").fadeOut();
	});
	
	// 서로친구 버튼
	$("#PairBtn").on("click", function() {
	});
	
	// 내가 추가한 친구 버튼
	$("#FollowingBtn").on("click", function() {
	});

	// 나를 추가한 친구 버튼
	$("#FollowerBtn").on("click", function() {
	});

	


	

}); //ready
</script>

</body>
</html>