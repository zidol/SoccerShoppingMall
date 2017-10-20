<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

ShopBookDBBean manager = ShopBookDBBean.getInstance();
int check = manager.mangaerCheck(id, passwd);

if(check == 1) {
	session.setAttribute("managerId", id);
	response.sendRedirect("../managerMain.jsp");
} else if(check==0){%>
<script type="text/javascript">
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
<%} else { %>
<script type="text/javascript">
	alert("아이디가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
</body>
</html>