<%@page import="dto.DiningCostDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KODI</title>
<script src="/resources/js/jquery-3.7.1.min.js"></script>
</head>

<script>

</script>

<body>
	<%
		List<DiningCostDTO> list = (List<DiningCostDTO>)request.getAttribute("list");
		
		for(DiningCostDTO dto : list){
			out.print(dto.getItem() + ", ");
		}
	%>
</body>
</html>