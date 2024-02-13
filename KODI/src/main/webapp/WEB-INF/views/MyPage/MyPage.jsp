<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/MyPage.css">
    <link rel="stylesheet" href="/css/FriendList.css">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
    <script src="/js/jquery-3.7.1.min.js"></script>
    <title>mypage</title>
</head>
<body>
    <%@ include file="/WEB-INF/views/Header.jsp" %>
    <%@ include file="/WEB-INF/views/SearchHeader.jsp" %>

    <main>
        <div class="modal_background1"></div>
        <div class="modal_background2"></div>

        <div class="mypagebtn-box">
            <button class="mypagebtn" id="friendbtn">친구목록</button>
            <div>
                <button class="mypagebtn" id="writebtn">글작성</button>
                <button class="mypagebtn" id="modifybtn">정보수정</button>
            </div>
        </div>

        <div id="mypage-box">
            <div id="album">
                <c:forEach var="post" items="${posts}">
                    <div class="album-item" data-post-idx="${post.postIdx}">
                        <c:set var="hasImage" value="false" />
                        <c:forEach var="image" items="${images}">
                            <c:if test="${post.postIdx eq image.postIdx}">
                                <c:set var="hasImage" value="true" />
                                <div class="image-container">
                                    <div class="image-title">${post.title}</div>
                                    <img src="${path}/image/db/${image.src}">
                                    <p class="title">${post.title}</p>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not hasImage}">
                            <div class="image-container">
                                <div class="second-title">${post.title}</div>
                                <img class="random-image" src="/image/ex.jpg">
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <script>
        $(document).ready(function () {
            let language = "<%= session.getAttribute("language") %>";
            let koLanguage = language === "ko";

            $("#friendbtn").text(koLanguage ? "친구목록" : "Friends");
            $("#writebtn").text(koLanguage ? "글작성" : "Post");
            $("#modifybtn").text(koLanguage ? "정보수정" : "Modify");

            var randomImages = ["/image/db/ex.jpg", "/image/db/ex2.jpg", "/image/db/ex3.jpg"];
            $(".album-item .random-image").attr("src", function () {
                return randomImages[Math.floor(Math.random() * randomImages.length)];
            });

            $("#writebtn").on("click", function () {
                window.location.href = "/api/post/write";
            });

            $("#friendbtn").on("click", function () {
                $(".modal_box2").load("/api/pair", function () {
                    $(".modal_background2").fadeIn();
                });
            });

            $("#modifybtn").on("click", function () {
                var userInput = prompt(koLanguage ? "정보수정을 하려면 비밀번호를 입력하세요" : "To modify your information, enter your password.");

                if (userInput === null) {
                    return;
                }

                $.ajax({
                    url: '/api/verifyPw',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ pw: userInput }),
                    success: function (response) {
                        if (response === "회원정보 확인 완료") {
                            $(".modal_box").load("/api/update", function () {
                                $(".modal_background1").fadeIn();
                            });
                        } else {
                            alert(koLanguage ? response : "Please type the correct password.");
                        }
                    },
                    error: function (xhr, status, error) {
                        if (xhr.status === 401) {
                            alert(koLanguage ? "비밀번호가 일치하지 않습니다." : "Password does not match.");
                        } else {
                            console.error("error: " + error);
                            alert(koLanguage ? "서버 오류가 발생했습니다." : "There's an error in the server.");
                        }
                    }
                });
            });

            $(".album-item").on("click", function () {
                var postIdx = $(this).data("post-idx");
                if (postIdx !== undefined) {
                    window.location.href = "/api/post/" + postIdx;
                }
            });
        });
    </script>

    <%@ include file="/WEB-INF/views/Footer.jsp" %>
</body>
</html>
