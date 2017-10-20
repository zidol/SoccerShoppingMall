<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.BuyDataBean" %>
<%@ page import="ch14.bookshop.shopping.BuyDBBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Shopping Mall</title>
<link href="../etc/main_list.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String buyer = (String)session.getAttribute("id");
String preAccount;
 %>
 <%
 List<BuyDataBean> buyLists = null;
 BuyDataBean buyList = null;
 int count = 0;
 int number= 0;
 int total = 0;
 long compareId = 0;
 long preId= 0;
 
 if(session.getAttribute("id") == null) {
	 response.sendRedirect("shopMain.jsp");
 } else {
	 BuyDBBean buyProcess = BuyDBBean.getInstance();
	 count = buyProcess.getListCount(buyer);
	 if(count == 0) {
 %>
 <h3 align="center"><b>구매 목록</b></h3>
 <table align="center">
 	<tr><td align="center">구매목록이 없습니다.<br>
 	<input type="button" value="매인으로"
 	onclick="javascript:window.location='shopMain.jsp'">
 	</td></tr>
 </table>
 	
<%
	 }else {
		 buyLists = buyProcess.getBuyList(buyer);
%>
<h3 align="center"><b>구매 목록</b></h3>
<table align="center" border="0"><tr><td>
<%
for(int i=0; i<buyLists.size(); i++) {
	buyList = buyLists.get(i);
	
	if(i<buyLists.size()-1){
		BuyDataBean compare = buyLists.get(i+1);
		compareId = compare.getBuy_id();
		
	/* 	BuyDataBean pre = buyLists.get(buyLists.size()-2);
		preId = pre.getBuy_id(); */
				
	}
%>
<table align="center">
	<tr>
		<td width="150">번호 </td>
		<td width="300">상품이름 </td>
		<td width="100">판매가격</td>
		<td width="50">수량 </td>
		<td width="150">금액 </td>
	</tr>
	<tr>
		<td align="center" width="150"> <%=buyList.getBuy_id() %> </td>
		<td width="300" align="left">
			<img src="../../imageFile/<%=buyList.getBook_image()%>"
			border="0" width="30" height="50" align="middle">
			<%=buyList.getBook_title()%>
		</td>
		<td width="100"
		>\<%=NumberFormat.getIntegerInstance().format(buyList.getBuy_price()) %></td>
		<td width="50"> <%=buyList.getBuy_count()%></td>
		<td width="150">
		<%total += buyList.getBuy_count()*buyList.getBuy_price(); %>
		\<%=NumberFormat.getInstance().format(buyList.getBuy_count()*buyList.getBuy_price()) %>
		</td>
	</tr>
	<%
		if(buyList.getBuy_id() != compareId || (i == buyLists.size()-1)/*  && preId != buyList.getBuy_id() */) {
	%>
	<tr> 
		<td colspan="5" align="right" style="padding-right: 45px" >
		<font color="red" size="3"><b>총 금액 : \<%=NumberFormat.getInstance().format(total) %></b></font></td>
	</tr></table>
	<%
		compareId = buyList.getBuy_id();
	total = 0;
		}else {
	%>
	</td></tr></table><br>
	<%
		}
}
	%>
	<input type="button" value="메인으로"
	onclick="javascript:window.location='shopMain.jsp'">
	<%
	 }
 }
	%>
</body>
</html>