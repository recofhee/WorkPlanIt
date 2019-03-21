<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  	int re_num = Integer.parseInt(request.getParameter("re_num"));
	int num = Integer.parseInt(request.getParameter("num"));
	
	String pageNum = request.getParameter("pageNum");
  	int mem_num = (Integer)session.getAttribute("mem_num");

  	ReplyDBBean dbPro = ReplyDBBean.getInstance(); 
  	int check = dbPro.deleteReply(re_num, mem_num);

  	if (check == 1) {
%>
		<meta http-equiv="Refresh" content="0;url=commu.jsp?page=contents&num=<%=num%>&pageNum=<%=pageNum%>">
<%
	} else {
%>
		<script>        
         	alert("작성자만 삭제 가능합니다.");
         	history.go(-1);
   		</script>
<%} %>
