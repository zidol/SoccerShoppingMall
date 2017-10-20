<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="ch14.bookshop.shopping.BankDataBean"%>
<%@ page import="ch14.bookshop.shopping.BankDBBean" %>
<%@ page import="ch14.bookshop.shopping.CustomerDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 계좌 삭제 처리</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<%
String buyer = (String)session.getAttribute("id");
String accountList = request.getParameter("accountList");
String passwd = request.getParameter("passwd");

int index = accountList.indexOf(" ");
String account = accountList.substring(0, index);

CustomerDBBean memberProcess = CustomerDBBean.getInstance();
int checkNum = memberProcess.userCheck(buyer, passwd);

if(checkNum != 1){
%>
<script type="text/javascript">
	alert("비밀번호를 잘못 입력 하셨습니다.");
	history.go(-1);
</script>
<%} else {
BankDBBean bankProcess = BankDBBean.getInstnace();
bankProcess.deleteAccount(buyer, account);
%>
<script type="text/javascript">
	alert("계좌를 삭제하였습니다.");
	document.location.href="buyForm.jsp";
</script>
<%}

%>
</body>
</html>