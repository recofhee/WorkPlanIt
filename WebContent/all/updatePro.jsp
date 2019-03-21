<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" scope="page" class="all.action.PlanetDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
	String pageNum = request.getParameter("pageNum");
	
	PlanetDBBean dbPro = PlanetDBBean.getInstance();
    int check = dbPro.updateArticle(article); 

    if (check == 1) {
%>		
		<meta http-equiv="Refresh" content="0;url=myplanetarticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=pageNum%>" >
<%
	}
%>