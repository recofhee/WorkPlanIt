<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.PapersDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" scope="page" class="all.action.PapersDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
    article.setPapers_write_time(new Timestamp(System.currentTimeMillis()) );

    PapersDBBean dbPro = PapersDBBean.getInstance();
    dbPro.insertArticle(article); 

    response.sendRedirect("mypage.jsp"); 
%>

