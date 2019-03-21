<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="reply" scope="page" class="all.action.ReplyDataBean">
   <jsp:setProperty name="reply" property="*"/>
</jsp:useBean>
 
<%
	int num=reply.getBoard_num();
	String pageNum = request.getParameter("pageNum");
	
	reply.setRe_write_time(new Timestamp(System.currentTimeMillis()));

    ReplyDBBean dbPro = ReplyDBBean.getInstance();
    dbPro.insertReply(reply); 

    response.sendRedirect("commu.jsp?page=contents&num="+num+"&pageNum="+pageNum);
%>
