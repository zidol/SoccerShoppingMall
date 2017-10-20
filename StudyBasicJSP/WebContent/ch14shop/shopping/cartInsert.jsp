<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.CartDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CartInsertPage</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");%>
<%
String book_kind = request.getParameter("book_kind");
String buy_count = request.getParameter("buy_count");
String book_id = request.getParameter("book_id");
String book_title = request.getParameter("book_title");
String book_image = request.getParameter("book_image");
String buy_price = request.getParameter("buy_price");
String buyer = (String)session.getAttribute("id");
%>
<jsp:useBean id="cart" scope="page" class="ch14.bookshop.shopping.CartDataBean">
</jsp:useBean>
<%
cart.setBuyer(buyer);
cart.setBook_id(Integer.parseInt(book_id));
cart.setBook_title(book_title);
cart.setBuy_price(Integer.parseInt(buy_price));
cart.setBuy_count(Byte.parseByte(buy_count));
cart.setBook_image(book_image);

CartDBBean bookProcess = CartDBBean.getInstance();
bookProcess.insertCart(cart);
response.sendRedirect("cartList.jsp?book_kind="+book_kind);
%>
</body>
</html>

