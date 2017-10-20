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
<%request.setCharacterEncoding("utf-8"); %>

<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");
Timestamp register = new Timestamp(System.currentTimeMillis());

Connection conn = null;
PreparedStatement pstmt =null;
String str="";

try {
	String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp?useSSL=false";
	String dbId = "jspid";
	String dbPass = "jsppass";
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	
	String sql = "insert into member values(?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, passwd);
	pstmt.setString(3, name);
	pstmt.setTimestamp(4, register);
	pstmt.executeUpdate();
	
	str="member 테이블에 새로운 레코드를 추가하였습니다.";
} catch(Exception e) {
	e.printStackTrace();
	str="member 테이블에 새로운 레코드 추가를 실패했습니다.";
} finally {
	if(pstmt != null)
		try{
			pstmt.close();
		}catch(SQLException sqle) {}
	if(conn != null)
		try{
			conn.close();
		}catch(SQLException sqle){}
}
%>
<%=str%>
</body>
</html>