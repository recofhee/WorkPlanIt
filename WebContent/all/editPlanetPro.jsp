<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="planet" scope="page" class="all.action.PlanetDataBean">
   <jsp:setProperty name="planet" property="*"/>
</jsp:useBean>

<%
	PlanetDBBean dbPro = PlanetDBBean.getInstance();
    int check = dbPro.editPlanet(planet); 

    if (check == 1) {
%>		
		<meta http-equiv="Refresh" content="0;url=myplanet.jsp?planet_num=<%=planet.getPlanet_num()%>" >
<%
	}
%>