<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Admin.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="js/jquery-3.7.1.min.js"></script>
<title>administrator</title>
</head>

<body>
	<%@ include file="/WEB-INF/views/AdminHeader.jsp"%>


	<div class="main">

		<div class="logo-container">
			<img src="/image/icon/logo.png" alt="KoDi" style="width:170px; height:150px;">
		</div>


		<div class="board-box">
			<div class="title">

				<div id="title">
					<span style="margin-left: 10px;">전체글</span>
					<form action="boardsearchlist">
						<select name="search">
							<option>제목</option>
							<option>내용</option>
							<option>작성자</option>
							<option>모두</option>
						</select>
							<input id="search" name="word" >
						<button type="submit"
							style="border: none; background: none; cursor: pointer;">
							<img src="/image/icon/search.png" style="margin-right: 10px; height: 20px; width: 20px;">
						</button>
						
					

					</form>
				</div>
			</div>


			<div id="board">
				<table>
					<thead>
						<tr>
							<th>작성자(이메일)</th>
							<th>글제목</th>
							<th>글내용</th>
						</tr>
					</thead>
					<tbody id="postList">

					</tbody>
				</table>

			</div>


		</div>
	</div>








</body>
</html>