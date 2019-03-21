<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" scope="page" class="all.action.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
	int board_num = article.getBoard_num();
    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertSave(article); 

    response.sendRedirect("commu.jsp?page=contents&num="+board_num);
%>