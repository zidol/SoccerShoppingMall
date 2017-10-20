<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 생성</title>
</head>
<body>
<%
String cookieName = "id";
Cookie cookie = new Cookie(cookieName, "hongkd");
cookie.setMaxAge(60/12);
response.addCookie(cookie);
%>
<h2>쿠키를 생성하는 페이지</h2>
"<%=cookieName %>"쿠키가 생성되었습니다.<hr>
<form method="post" action="useCookie.jsp">
	<input type="submit" value="생성된 쿠키 확인">
</form>
</body>
</html>