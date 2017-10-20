<%@page import="java.sql.Time"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ include file="../../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
<p>상품 등록</p>
<br>
<%
String managerId = "";
try {
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} else {
%>		
<form method="post" name ="writeform" action="bookRegisterPro.jsp"
enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c%>">
			<a href="../managerMain.jsp">관리자 메인으로</a>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">분류 선택</td>
			<td width="400" align="left">
				<select name="book_kind">
					<option value="100">축구화</option>
					<option value="200">유니폼</option>
					<option value="300">트레이닝복</option>
					<option value="400">축구공</option>
					<option value="500">악세사리</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">상품명</td>
			<td width="400" align="left">
				<input type="text" size="50" maxlength="50" name="book_title"> </td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">가격</td>
			<td width="400" align="left">
				<input type="text" size="10" maxlength="9" name="book_price">원</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">수량</td>
			<td width="400" align="left">
				<input type="text" size="10" maxlength="5" name="book_count">개</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">생산지</td>
			<td width="400" align="left">
				<input type="text" size="20" maxlength="30" name="author"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">제조사</td>
			<td width="400" align="left">
				<input type="text" size="20" maxlength="30" name="publishing_com"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">출시일</td>
			<td width="400" align="left">
			<select name="publishing_year">
			<%
				Timestamp nowTime = new Timestamp(System.currentTimeMillis());
				int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
				for(int i=lastYear; i>=2000; i--){
			%>
				<option value="<%=i%>"><%=i %></option>
				<%} %>
			</select>년
			
			<select name="publishing_month">
			<%
				for(int i=1; i<=12; i++){
			%>
				<option value="<%=i%>"><%=i %></option>
				<%} %>
			</select>월
			
			<select name="publishing_day">
			<%
				for(int i=1; i<=31; i++){
			%>
				<option value="<%=i%>"><%=i %></option>
				<%} %>
			</select>일
			</td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">이미지</td>
			<td width="400" align="left">
				<input type="file" name="book_image"></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">상품설명</td>
			<td width="400" align="left">
			<textarea name="book_content" rows="13" cols="40"></textarea></td>
		</tr>
		<tr>
			<td width="100" bgcolor="<%=value_c%>">할인율</td>
			<td width="100" align="left">
				<input type="text" size="5" maxlength="2" name="discount_rate">%</td>
		</tr>
		<tr>
			<td colspan="2" bgcolor="<%=value_c%>" align="center">
				<input type="button" value="상품등록" onclick="checkForm(this.form)">
				<input type="reset" value="다시 작성">
			</td>
		</tr>
	</table>
</form>
<%
	}
}catch (Exception e) {
	e.printStackTrace();
}
	%>

</body>
</html>