<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="planet" scope="page" class="all.action.PlanetDataBean">
   <jsp:setProperty name="planet" property="*"/>
</jsp:useBean>


<%
	planet.setPlanet_make_date(new Timestamp(System.currentTimeMillis()));

    PlanetDBBean dbPro = PlanetDBBean.getInstance();
    dbPro.insertMetaPlanet(planet);

    response.sendRedirect("planet.jsp");
    //response.sendRedirect("cpPro2.jsp");
%>