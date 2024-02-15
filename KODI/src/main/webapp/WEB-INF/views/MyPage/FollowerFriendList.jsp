<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>

                <title></title>

            </head>

            <body>
                <div class="friendbox" id="friendModal" tabindex="-1" role="dialog" aria-labelledby="friendModalLabel"
                    aria-hidden="true">

                    <div class="mainBox">
                        <div class="contentBox">

                            <div class="logoBtn">
                                <dlv id="friendheader">
                                    <img id="logo-icon" src="<%=request.getContextPath()%>/image/icon/logo.png">
                                    <h2 id="listTitle">친구목록</h2>
                                </dlv>

                                <div class="form-group">
                                    <button id="PairBtn">서로친구</button>
                                    <button id="FollowingBtn">내가 추가한 친구</button>
                                    <button id="FollowerBtn" style="background-color: #999999; color:#ffffff;">나를 추가한
                                        친구</button>
                                </div>

                            </div>
                            <div class="friendList">
                                <div id="list">
                                    <!-- 나를 추가한 친구 -->
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>
                                                    <div class="tdDiv" id="nickName">닉네임</div>
                                                </th>
                                                <th>
                                                    <div class="tdDiv" id="nationality">국적</div>
                                                </th>

                                                <th>
                                                    <div class="tdDiv"></div>
                                                </th>

                                            </tr>
                                        </thead>

                                        <tbody id="friendList3">
                                            <c:forEach var="friend" items="${members}">
                                                <tr>
                                                    <td>
                                                        <div class="tdDiv">${friend.memberName}</div>
                                                    </td>
                                                    <td>
                                                        <div class="tdDiv">
                                                            ${friend.country}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <button class="f-Btn f-acceptBtn" id="f-acceptBtn" type="button"
                                                            data-member-idx="${friend.memberIdx}">수락</button>
                                                        <button class="f-Btn f-removeBtn" id="f-removeBtn" type="button"
                                                            data-member-idx="${friend.memberIdx}">삭제</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>

                                    </table>
                                </div>



                            </div>

                        </div>
                        <div class="friend-btn"><button type="button" id="closebtn">닫기</button></div>

                    </div>


                </div>
                <script>
                    $(document).ready(function () {
                        let language = "<%= session.getAttribute("language") %>";
                        let koLanguage = language === "ko";

                        $("#listTitle").html(koLanguage ? "친구목록" : "Friends List");
                        $("#nickName").html(koLanguage ? "닉네임" : "Nickname");
                        $("#nationality").html(koLanguage ? "국적" : "Nationality");
                        $("#closebtn").html(koLanguage ? "닫기" : "close");
                        $("#PairBtn").html(koLanguage ? "서로친구" : "Friends");
                        $("#FollowingBtn").html(koLanguage ? "내가 추가한 친구" : "Followings");
                        $("#FollowerBtn").html(koLanguage ? "나를 추가한 친구" : "Followers");
                        $(".f-acceptBtn").html(koLanguage ? "수락" : "Accept");
                        $(".f-removeBtn").html(koLanguage ? "삭제" : "Delete");

                        // 나를 추가한 유저 삭제
                        $("#friendList3").on('click', '#f-removeBtn', function (e) {
                            if (confirm(koLanguage ? "해당 친구요청을 삭제하시겠습니까?" : "Would you like to delete this friend request?")) {
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/api/follower/delete/' + $(e.target).attr('data-member-idx'),
                                    dataType: 'json',
                                    type: "get",
                                    success: function (response) {
                                        $('#friendList3').html('');
                                        let result = "";
                                        for (let i = 0; i < response.length; i++) {
                                            result +=
                                                '<tr>' +
                                                '<td>' +
                                                '   <div class="tdDiv">' +
                                                response[i].memberName +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '   <div class="tdDiv">' +
                                                response[i].country +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response[i].memberIdx + '" href="<%=request.getContextPath()%>/api/follower/accept/' + response[i].memberIdx + '">'+(koLanguage ? "수락" : "Accept")+'</a>' +
                                                '<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response[i].memberIdx + '" href="<%=request.getContextPath()%>/api/follower/delete/' + response[i].memberIdx + '">'+(koLanguage ? "삭제" : "Delete")+'</a>' +
                                                '</td>' +
                                                '</tr>';
                                        }
                                        $('#friendList3').html(result); // 여기를 변경
                                    }
                                });
                            }
                        });



                        // 나를 추가한 유저 수락
                        $("#friendList3").on('click', '#f-acceptBtn', function (e) {
                            if (confirm(koLanguage ? "친구요청을 수락하시겠습니까?" : "Would you like to accept this friend request?")) {
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/api/follower/accept/' + $(e.target).attr('data-member-idx'),
                                    dataType: 'json',
                                    type: "get",
                                    success: function (response) {
                                        $('#friendList3').html('');
                                        let result = "";
                                        for (let i = 0; i < response.length; i++) {
                                            result +=
                                                '<tr>' +
                                                '<td>' +
                                                '   <div class="tdDiv">' +
                                                response[i].memberName +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '   <div class="tdDiv">' +
                                                response[i].country +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '<button class="f-Btn" id="f-acceptBtn" data-member-idx="' + response[i].memberIdx + '" href="<%=request.getContextPath()%>/api/follower/accept/' + response[i].memberIdx + '">'+(koLanguage ? "수락" : "Accept")+'</a>' +
                                                '<button class="f-Btn" id="f-removeBtn" data-member-idx="' + response[i].memberIdx + '" href="<%=request.getContextPath()%>/api/follower/delete/' + response[i].memberIdx + '">'+(koLanguage ? "삭제" : "Delete")+'</a>' +
                                                '</td>' +
                                                '</tr>';
                                        }
                                        $('#friendList3').html(result); // 여기를 변경
                                    }
                                });
                            }
                        });
                        
                      	//닫기버튼
	                	$("#closebtn").on("click", function () {
	                		$(".modal_background2").fadeOut();
	                	});
	
	                	// 서로 친구 목록 요청
	                	$("#PairBtn").on("click", function () {
	                		$.ajax({
	                			url: '<%=request.getContextPath()%>/api/pair',
	                			type: 'GET',
	                			dataType: 'html',
	                			success: function (response) {
	                				$('.modal_box2').html(response);
	                			},
	                			error: function (error) {
	                				console.log("Error:", error);
	                			}
	                		});
	                	});
	
	                	// 내가 추가한 친구 목록 요청
	                	$("#FollowingBtn").on("click", function () {
	                		$.ajax({
	                			url: '<%=request.getContextPath()%>/api/following',
	                			type: 'GET',
	                			dataType: 'html',
	                			success: function (response) {
	                				$('.modal_box2').html(response);
	                			},
	                			error: function (error) {
	                				console.log("Error:", error);
	                			}
	                		});
	                	});
	
	                	// 나를 추가한 친구 목록 요청
	                	$("#FollowerBtn").on("click", function () {
	                		$.ajax({
	                			url: '<%=request.getContextPath()%>/api/follower',
	                			type: 'GET',
	                			dataType: 'html',
	                			success: function (response) {
	                				$('.modal_box2').html(response);
	                			},
	                			error: function (error) {
	                				console.log("Error:", error);
	                			}
	                		});
	                	});
                    });//ready
                </script>
            </body>

            </html>