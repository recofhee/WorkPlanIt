<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="reply" scope="page" class="all.action.ReplyDataBean">
   <jsp:setProperty name="reply" property="*"/>
</jsp:useBean>
 
<%
    String pageNum = request.getParameter("pageNum");
	int mem_num = (Integer)session.getAttribute("mem_num");
	
	ReplyDBBean dbPro = ReplyDBBean.getInstance();
    int check = dbPro.updateReply(reply); 

    if (check == 1) {
%>
		<meta http-equiv="Refresh" content="0;url=commu.jsp?page=contents&num=<%=reply.getBoard_num()%>&pageNum=<%=pageNum%>" >
<%

	} else {
%>
		<script>        
	    	alert("작성자만 수정 가능합니다.");
	    	history.go(-1);
		</script>
<%} %>
