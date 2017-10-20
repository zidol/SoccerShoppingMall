<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="ch12.member.LogonDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>회원가입 확인!!</h2>
<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="ch12.member.LogonDataBean">
	<jsp:setProperty name="member" property="*" />	
</jsp:useBean>
<%
member.setReg_date(new Timestamp(System.currentTimeMillis()));
LogonDBBean update = LogonDBBean.getInstance();
update.updateMember(member);
%>
<jsp:getProperty  name="member" property="id"/> 님 정보를 변경 하였습니다.
</body>
</html>