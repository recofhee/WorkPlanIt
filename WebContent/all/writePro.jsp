<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "all.action.PlanetDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" scope="page" class="all.action.PlanetDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>


<%
    article.setPlanet_write_time(new Timestamp(System.currentTimeMillis()) );
	
	int planet_num = Integer.parseInt(request.getParameter("planet_num"));

    PlanetDBBean dbPro = PlanetDBBean.getInstance();
    dbPro.insertArticle(article); 

    response.sendRedirect("myplanet.jsp?planet_num="+planet_num);
%>