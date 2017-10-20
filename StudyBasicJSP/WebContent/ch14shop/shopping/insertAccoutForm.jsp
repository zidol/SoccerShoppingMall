<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제계좌 등록</title>
<link href="../etc/main_list.css?ver=1" rel="stylesheet" type="text/css"> 
</head>
<body>
<%//loginPro.jsp 세션 받아 옴..
String buyer = (String)session.getAttribute("id");
if(buyer == null) {
	response.sendRedirect("shopMain.jsp");
} else {
%>
<h3 align="center"><%=buyer %>님의 계좌등록</h3>
<form method="post" action="insertAccountPro.jsp">
<table align="center">
	<tr>
		<td width="70" align="center">결제 계좌</td>
		<td width="200">
			<input type="text" name = "account">
		</td>
	</tr>
	<tr>
		<td width="70" align="center">결제 은행</td>
		<td width="200">
			<input type="text" name = "bank">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="확인" >&nbsp;
			<input type="button" value="취소" 
			onclick="javascript:window.location='buyForm.jsp'">&nbsp;
		</td>
	</tr>
</table>
</form>
<%} %>
</body>
</html>