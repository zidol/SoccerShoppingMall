<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>JDBC드라이버 테스트</h2>

<%
Connection conn = null;

try {
	String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?useSSL=false";
	String dbId = "jspid";
	String dbPass = "jsppass";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	out.println("제대로 연결되었습니다.");
	
} catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>