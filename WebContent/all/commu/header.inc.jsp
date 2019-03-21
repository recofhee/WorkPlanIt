<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String pagefile = request.getParameter("page");
	if (pagefile == null) {
    	pagefile = "commu";
  	}
	
	String email ="";
	try{
		email = (String)session.getAttribute("email");
		if(email==null || email.equals(""))
			response.sendRedirect("../index.jsp");
		else{
%>

<header id="header">
	<h1><a href="../main.jsp">WORK PLAN IT</a></h1>

	<nav class="links">
	<ul>
		<li><a href="commu.jsp">전체</a></li>
		<li><a href="commu.jsp?page=list_doc">서류</a></li>
		<li><a href="commu.jsp?page=list_written">필기</a></li>
		<li><a href="commu.jsp?page=list_prac">실기</a></li>
		<li><a href="commu.jsp?page=list_inter">면접</a></li>
	</ul>
	</nav>
	<nav class="rlinks">
	<ul>
		<li><a href="../main.jsp">HOME</a></li>
		<li><a href="../planet.jsp">PLANET</a></li>
		<li><a href="../mypage.jsp">MYPAGE</a></li>
	</ul>
	</nav>
</header>

<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>