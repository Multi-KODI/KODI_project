<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/SearchHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="js/jquery-3.7.1.min.js"></script>
<title></title>
</head>
<body>
<div class="main">

	<div class="headerbox">

		<div class="logo-box">
			<a href="/home"><img id="logoicon" src="/image/icon/logo.png" ></a>
		</div>

		<div class="input-box">
			<div id="search-box">
				<select id="searchfilter" name="search">
					<option>게시글</option>
					<option>태그</option>
					<option>사용자</option>
				</select>
				<input id="searchinput" placeholder="검색어 입력">

				<button id="searchbtn" type="submit">
					<img id="searchicon" src="/image/icon/search.png" >
				</button>
			</div>
		</div>

	</div>

</div>
<!-- main -->



</body>
</html>