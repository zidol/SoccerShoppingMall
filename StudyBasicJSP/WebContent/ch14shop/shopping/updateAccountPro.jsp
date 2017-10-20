<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch14.bookshop.shopping.BankDataBean" %>
<%@ page import="ch14.bookshop.shopping.BankDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계좌수정 처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String buyer = (String)session.getAttribute("id");
String accountList = request.getParameter("accountList");
int index = accountList.indexOf(" ");
String account = accountList.substring(0,index);//계좌만 짜르기

String update_account = request.getParameter("update_account");
String update_bank = request.getParameter("update_bank");


BankDBBean bankProcess = BankDBBean.getInstnace();
BankDataBean member = new BankDataBean();//인스턴스 생성
member.setId(buyer);
member.setAccount(update_account);
member.setBank(update_bank);
member.setReg_date(new Timestamp(System.currentTimeMillis()));
bankProcess.updateAccount(member, account);
response.sendRedirect("buyForm.jsp");
%>
</body>
</html>