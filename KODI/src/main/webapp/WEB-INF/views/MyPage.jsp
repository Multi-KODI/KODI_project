<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <c:set var="path" value="${pageContext.request.contextPath}" />
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="/css/MyPage.css">
                <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
                <script src="/js/jquery-3.7.1.min.js"></script>
                <title>mypage</title>
            </head>

            <body>
                <%@ include file="/WEB-INF/views/Header.jsp" %>
                    <%@ include file="/WEB-INF/views/SearchHeader.jsp" %>

                        <main>
                            <div class="modal_background">
                                <div class="modal_box"></div>
                                <div class="modal_box2"></div>
                            </div>


                            <main>
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
                                            <div class="album-item">
                                                <c:choose>
                                                    <c:when
                                                        test="${not empty images and post.postIdx eq images[0].postIdx}">
                                                        <!-- 이미지 태그를 생성하는 부분 -->
                                                        <img src="${path}/image/db/${images[0].src}"
                                                            alt="Image description">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 이미지 태그가 안 만들어진 경우에만 post.title을 출력 -->
                                                        <p>${post.title}</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </main>





                         <script>
                        $(document).ready(function () {

                            //글작성
                            $("#writebtn").on("click", function () {
                                window.location.href = ("/api/post/write");
                            });


                            //정보수정 버튼
                            $("#modifybtn").on("click", function () {
                                var userInput = prompt("정보수정을 하려면 비밀번호를 입력하세요");

                                //검증부분
                                $.ajax({
                                    url: '/api/????',  //비밀번호 데이터 받기
                                    type: 'POST',
                                    data: { password: userInput },
                                    success: function (isValid) {
                                        if (isValid) {
                                            $(".modal_box").load("/modifyModal", function () {
                                                $(".modal_background").fadeIn();
                                            });
                                        } else {
                                            alert("비밀번호가 틀렸습니다.");
                                        }
                                    },
                                    error: function (error) {
                                        console.error("error : 비밀번호를 검증하는 데 실패했습니다.", error);
                                    }
                                });
                            });


                            //친구목록
                            $("#friendbtn").on("click", function () {
                                $(".modal_box2").load("/friendList", function () {
                                    $(".modal_background").fadeIn();
                                });
                            });





                        });
                    </script> 






            </body>

            </html>