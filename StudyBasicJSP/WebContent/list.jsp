<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="student.info.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>한국IT교육원 학생 조회 프로그램</h1>
<hr>
<h2>학생정보 리스트 </h2>
<%

String id = request.getParameter("id");
StudentDBBean dbProcess = StudentDBBean.getInstance();
StudentDataBean member = dbProcess.getStudentList(id);
dbProcess.getStudentList(id);
%>
<table>
<tr>
	<td>아이디</td>
	<td>비밀번호</td>
	<td>이름</td>
	<td>학번</td>
	<td>입학년도</td>
	<td>전공</td>
	<td>전화번호</td>
	<td>주소</td>
	<td>이메일</td>
</tr>
<tr>
	<td><%=member.getId() %></td>
	<td><%=member.getPasswd() %></td>
	<td><%=member.getName() %></td>
	<td><%=member.getSnum() %></td>
	<td><%=member.getEnt_year() %></td>
	<td><%=member.getMajor() %></td>
	<td><%=member.getTel() %></td>
	<td><%=member.getAddr() %></td>
	<td><%=member.getEmail() %></td>
</tr>
</table>
</body>
</html>