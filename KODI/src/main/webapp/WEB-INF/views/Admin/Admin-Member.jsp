<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<link rel="stylesheet" href="/css/Admin.css">
				<link rel="stylesheet" href="/css/AdminHeader.css">
				<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
				<script src="/js/jquery-3.7.1.min.js"></script>
				<title>administrator</title>
			</head>

			<body>

				<header>
					<div class="header-container">
						<div class="menu">
							<img src="/image/icon/menu.png" class="icon" id="menubtn">
						</div>

						<div class="end-btn">
							<button class="btn" id="adminbtn">관리자</button>
							<button class="btn" id="logoutbtn">로그아웃</button>
							<div class="language-selection">
								<select>
									<option value="ko">한국어</option>
									<option value="en">English</option>
								</select>
							</div>
						</div>
					</div>
				</header>

				<div class="menu-content">
					<a href="/api/admin/allposts" id="listallBtn">전체글</a>
					<a href="/api/admin/allmembers" id="memberlistBtn">회원목록</a>
				</div>

				<div class="main">

					<div class="logo-container">
						<img src="/image/icon/logo.png" id="KoDi">
					</div>

					<div class="board-box">
						<div class="title">

							<div id="title">
								<span style="margin-left: 10px;">전체 회원</span>
								<form action="/api/adminsearch">
									<select id="searchselect" name="filter">
										<option value="사용자">사용자</option>
									</select> <input id="searchinput" name="question">
									<button type="submit" style="border: none; background: none; cursor: pointer;">
										<img src="/image/icon/search.png" style="margin-right: 10px; height: 20px; width: 20px;">
									</button>
								</form>
							</div>
						</div>

						<div id="board">
							<table>
								<thead>
									<tr>
										<th>
											<div class="tdDiv">이메일</div>
										</th>
										<th>
											<div class="tdDiv">닉네임</div>
										</th>
										<th>
											<div class="tdDiv">국적</div>
										</th>
									</tr>
								</thead>

								<tbody id="memberList">
									<c:forEach var="member" items="${members}">
										<tr>
											<td>
												<div class="tdDiv">${member.email}</div>
											</td>

											<td>
												<div class="tdDiv" id="nameBox">${member.memberName}</div>
											</td>

											<td>
												<div class="tdDiv" style="display: flex; align-items: center;">
													<c:forEach var="flag" items="${flags}">
														<c:if test="${member.flagIdx eq flag.flagIdx}">
															<img style="width: 16px; height: 16px; margin-right: 3px;" src="${flag.src}">
															${flag.country}
														</c:if>
													</c:forEach>
												</div>
											</td>

											<td>
												<button class="withdrawBtn" type="button" data-member-idx="${member.memberIdx}">탈퇴</button>
											</td>
										</tr>

									</c:forEach>

								</tbody>
							</table>

							<button id="topBtn">
								<img src="/image/icon/topicon.png">
							</button>


							<!--<div id="pagination">
			<div id="pagination">
			    <c:if test="${currentPage > 1}">
			        <button class="pageBtn" onclick="loadPage(${currentPage - 1})">이전</button>
			    </c:if>
			
			    <c:forEach var="pageNum" begin="1" end="${totalPages}">
			        <button class="pageBtn ${pageNum == currentPage ? 'selected' : ''}" onclick="loadPage(${pageNum})">${pageNum}</button>
			    </c:forEach>
			
			    <c:if test="${currentPage < totalPages}">
			        <button class="pageBtn" onclick="loadPage(${currentPage + 1})">다음</button>
		    </c:if>
			</div>
		</div> -->

						</div>


					</div>
				</div>


				<script src="/js/AdminScript.js"></script>



			</body>
<%@ include file="/WEB-INF/views/Footer.jsp" %>
			</html>