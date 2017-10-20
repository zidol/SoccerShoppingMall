<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h2>회원 가입 폼</h2>
<form method="post" action="insertMemberPro.jsp">
	아이디 : <input type="text" name="id" maxlength="50"><br>
	패스워드 : <input type="password" name="passwd" maxlength="16"><br>
	이름 : <input type="text" name = "name" maxlength="10"><br>
	주소 : <input type="text" name="addr" maxlength="20"><br>
	전화번호 : <input type="text" name="tel" maxlength="15"><br>
	
	<input type="submit" value="회원가입">
	<input type="reset" value="다시 입력">
</form>
</body>
</html>