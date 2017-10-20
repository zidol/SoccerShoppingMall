<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="ch13.board.BoardDataBean"%>
<%@ page import="ch13.board.BoardDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../etc/color.jspf"%>
<!DOCTYPE html>
<html>
<head>

<link href="../etc/style_list.css?ver=1" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../etc/script.js"></script>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body <%-- bgcolor="<%=bodyback_c%>" --%>>
	
 
 	<div class="banner"><img  alt="" src="../images/manubanner.jpg" width="880"></div>
	<!-- <div ><img class="sidebanner"  id="leftside" src="../images/externalFile.png" ></div>
	<div ><img class="sidebanner" id="rightside" src="../images/externalFile.png"></div> -->
 	<%!int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
	<%
		String pageNum = request.getParameter("pageNum");

		if (pageNum == null) {
			pageNum = "1";
		}

		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		List<BoardDataBean> articleList = null;

		BoardDBBean dbPro = BoardDBBean.getInstance();
		count = dbPro.getArticleCount();
		if (count > 0) {
			articleList = dbPro.getArticles(startRow, endRow);
		}

		number = count - (currentPage - 1) * pageSize;
	%>
	<p>글목록(전체 글:<%=count%>)</p>
	<%if (count == 0) {%>
	<table class="noboard">
		<tr>
			<td align="center">게시판에 저장된 글이 없습니다.</td>
		</tr>
	</table>
	<%} else {%>
	
	<table class="list">
		<tr height="30" bgcolor="<%=value_c%>">
			<td align="center" width="50">번호</td>
			<td align="center" width="350">제목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="150">작성일</td>
			<td align="center" width="50">조회</td>
			<td align="center" width="100">IP</td>
		</tr>
		<%
			for (int i = 0; i < articleList.size(); i++) {
					BoardDataBean article = articleList.get(i);
		%>
		<tr height="30">
			<td width="50"><%=number--%></td>
			<td width="250" align="left">
				<%
					int wid = 0;
					if (article.getRe_level() > 0) {
						wid = 5 * (article.getRe_level());
				%> 
				<img src="../images/level1.png" width="<%=wid%>" height="16"> 
				<img class="reple1"src="../images/reple1.png"> <%
					} else {
 				%> <%-- <img src="../images/level1.png"width="<%=wid%>" height="16"> --%> <%
 					}
				 %> 
				 <a class="sb" href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
				 <%=article.getSubject()%></a> <%
				 	if (article.getReadcount() >= 20) {
				 %> 
				 <blink><img class="hot" src="../images/hot1.png" border="0" height="16"></blink>
				<%
					}
				%>
			</td>
			<td width="100" align="center">
				<a href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a>
			</td>
			<td width="150"><%=sdf.format(article.getReg_date())%></td>
			<td width="50"><%=article.getReadcount()%></td>
			<td width="100"><%=article.getIp()%></td>
		</tr>
		<%  }  %>
	</table>
	<%  }  %>
	
	<table class="writebutton">
		<tr>
			<td id="writebtn" align="right" bgcolor="<%=value_c%>"><a href="writeForm.jsp">글쓰기</a>
			</td>
		</tr>
	</table>
	<div class="pagei">
		<%
		if (count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = 1;
			// 시작페이지 번호 설정, pageblock이 10이면	 1, 11, 21
			if (currentPage % 10 != 0)
				startPage = (int) (currentPage / 10) * 10 + 1;
			else
				startPage = ((int) (currentPage / 10) - 1) * 10 + 1;

			int pageBlock = 10;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > 10) {
			%>
			<a  href="list.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
			<%
				}
					for (int i = startPage; i <= endPage; i++) {
			%>
			<a  href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
				}
					if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
			<%
					}
				}
			%>
			</div>

</body>
</html>