<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*"%>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<html>
<head><title>비밀번호 찾기</title></head>


<% request.setCharacterEncoding("utf-8"); %>


<%

	String email = request.getParameter("email");
	String birthday = request.getParameter("birthday");
	
	
	LogonDBBean manager = LogonDBBean.getInstance();
	LogonDataBean c = manager.searchPw(email,birthday); 
	
	try
	{
%>

<body>
<center>
<form method = "post" >
<%
		if(c != null)
		{
%>
			<%= email %>님에 비밀번호는 <b><%= c.getPassword() %></b>입니다.<p>
			<input type = "submit" value = "메인으로">
<%
		}
		else
		{
%>
			이메일 또는 생일이 틀렸습니다.<p>
			<input type = "button" value = "다시 입력하기"  onclick = 
				"javascript:window.location='index.jsp'">
<%
		}
%>
</form>
</center>
</body>
<%
		}catch(Exception e) {}
%>
</html>