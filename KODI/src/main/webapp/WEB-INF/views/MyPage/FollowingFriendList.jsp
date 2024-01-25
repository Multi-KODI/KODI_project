<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<link rel="stylesheet" href="/css/FriendList.css">
				<script src="/js/jquery-3.7.1.min.js"></script>

				<title></title>

				<style>

				</style>
			</head>

			<body>
				<div class="friendbox" id="friendModal" tabindex="-1" role="dialog" aria-labelledby="friendModalLabel"
					aria-hidden="true">

					<div class="mainBox">
						<div class="contentBox">

							<div class="logoBtn">
								<dlv id="friendheader">
									<img id="logo-icon" src="/image/icon/logo.png">
									<h2>친구목록</h2>
								</dlv>

								<div class="form-group">
									<button id="PairBtn">서로친구</button>
									<button id="FollowingBtn" style="background-color: #999999; color:#ffffff;">내가 추가한 친구</button>
									<button id="FollowerBtn">나를 추가한 친구</button>
								</div>

							</div>
							<div class="friendList">
								<div id="list">
									<!-- 내가 추가한 친구 -->
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

												<th>
													<div class="tdDiv"></div>
												</th>

											</tr>
										</thead>

										<tbody id="friendList2">
											<c:forEach var="friend" items="${mySideFriends}">
												<tr>
													<td>
														<div class="tdDiv">${friend.email}</div>
													</td>
													<td>
														<div class="tdDiv">${friend.memberName}</div>
													</td>
													<td>
														<div class="tdDiv">
															<c:forEach var="flag" items="${flags}">
																<c:if test="${friend.flagIdx eq flag.flagIdx}">
																	${flag.country}</c:if>
															</c:forEach>
														</div>
													</td>
													<td>
														<button class="f-Btn" id="f-cancelBtn" type="button"
															data-member-idx="${friend.memberIdx}">요청 취소</button>
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






				<script src="/js/FriendScript.js"></script>

			</body>

			</html>