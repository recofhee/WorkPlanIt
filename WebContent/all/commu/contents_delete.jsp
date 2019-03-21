<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  	int board_num = Integer.parseInt(request.getParameter("num"));
  	String pageNum = request.getParameter("pageNum");
  	/* String email = (String)session.getAttribute("email"); */
  	int mem_num = (Integer)session.getAttribute("mem_num");

  	BoardDBBean dbPro = BoardDBBean.getInstance(); 
  	int check = dbPro.deleteArticle(board_num, mem_num);

  	if (check == 1) {
%>
		<meta http-equiv="Refresh" content="0;url=commu.jsp?pageNum=<%=pageNum%>">
<%
	} else {
%>
	<script>        
     	alert("작성자만 삭제 가능합니다.");
     	history.go(-1);
	</script>
<%} %>
