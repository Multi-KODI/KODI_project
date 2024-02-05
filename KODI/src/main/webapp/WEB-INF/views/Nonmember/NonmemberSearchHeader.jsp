<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Nonmember/NonmemberSearchHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title></title>
</head>
<body>
<div class="main">

	<div class="headerbox">

		<div class="logo-box">
			<a href="/api/nonhome"><img id="logoicon"
				src="/image/icon/nonmemberlogo.png"></a>
		</div>

		<form action="" method="get" class="input-box">
			<div class="input-box">
				<div id="search-box">
					<select id="searchfilter" name="filter">
						<option value="게시글">Posts</option>
						<option value="사용자">Users</option>
					</select> <input id="searchinput" name="question" placeholder="Enter search term">

					<button id="searchbtn" type="submit">
						<img id="searchicon" src="/image/icon/search.png">
					</button>
				</div>
			</div>
		</form>

	</div>

</div>
<script>
$(document).ready(function(){
    $("#searchbtn").click(function(e){
        e.preventDefault(); 
        alert("You can use it after logging in");
    });
});
</script>



</body>
</html>