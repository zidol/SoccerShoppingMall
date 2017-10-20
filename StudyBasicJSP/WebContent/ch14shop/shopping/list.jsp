<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.master.ShopBookDataBean" %>
<%@ page import="ch14.bookshop.master.ShopBookDBBean" %>
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
<body bgcolor="<%=bodyback_c%>">
<%String book_kind =request.getParameter("book_kind"); %>
<table align="center" border="1">
<tr>
<td width="150" valign="top">
	<jsp:include page="../module/left.jsp" flush="false"/>
</td>
<td  align="center" width="700">
<%
List<ShopBookDataBean> bookLists = null;
ShopBookDataBean bookList = null;
String book_kindName= "";

ShopBookDBBean bookProcess = ShopBookDBBean.getInstance();
bookLists = bookProcess.getBooks(book_kind);   
if(book_kind.equals("100"))
	book_kindName="축구화";
else if (book_kind.equals("200"))
	book_kindName="유니폼";
else if (book_kind.equals("300"))
	book_kindName="트레이닝복";
else if (book_kind.equals("400"))
	book_kindName="축구공";
else if (book_kind.equals("500"))
	book_kindName="악세사리";
else if (book_kind.equals("all"))
	book_kindName="전체";
%>
<h3 ><b><%=book_kindName %> 분류목록</b></h3>
<a align="center" href="shopMain.jsp">메인으로</a>
<%
for(int i=0; i<bookLists.size(); i++) {
	bookList = (ShopBookDataBean)bookLists.get(i);%>
<table border="1">
	<tr height="30" <%-- bgcolor="<%=value_c%>" --%>>
		<td rowspan="4" width="100">
		<a 
		href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>">
		<img src="../../imageFile/<%=bookList.getBook_image()%>" border="0"
		width="60" height="90"></a></td>
		<td width="350"> <font size="+1"><b>
		<a
		href="bookContent.jsp?book_id=<%=bookList.getBook_id()%>&book_kind=<%=book_kind%>">
		<%=bookList.getBook_title() %></a></b></font></td>
		<td rowspan="4" width="100" align="center" valign="middle">
		<%if(bookList.getBook_count()==0) { %>
			<b>일시 품절</b>
			<%}else { %>
			&nbsp;
			<%} %>
		</td></tr>
		<tr height="30" <%-- bgcolor="<%=value_c%>" --%>>
			<td width="350">제조사 : <%=bookList.getPublishing_com() %></td>
		</tr> 
		<tr height="30" <%-- bgcolor="<%=value_c%>" --%>>
			<td width="350">생산지 : <%=bookList.getAuthor()%></td>
		</tr>
		<tr height="30" <%-- bgcolor="<%=value_c%>" --%>>
			<td width="350">정가 : 
			<%=NumberFormat.getInstance().format(bookList.getBook_price()) %><br>
			판매가 : <b><font color="red">
			<%=NumberFormat.getInstance().format((int)(bookList.getBook_price()*
					((double)(100-bookList.getDiscount_rate())/100))) %>
			</font></b></td>
		</tr>
</table>
<br>
<%} %>
</td>
</tr>
</table>
</body>
</html>