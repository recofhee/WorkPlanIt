<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="all.action.LogonDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String email=request.getParameter("email");
	String password=request.getParameter("password"); 
	
	LogonDBBean logon=LogonDBBean.getInstance();
    int check=logon.userCheck(email,password);
    

	if(check==1){
		session.setAttribute("email", email);
		session.setAttribute("password",password);
		//response.sendRedirect("cal_index.jsp");
		response.sendRedirect("main.jsp");
	}else if(check==0){
%>
<script> 
	  alert("비밀번호가 맞지 않습니다.");
	     history.go(-1);
	</script>
<%}else{ %>
<script>
	  alert("이메일이 맞지 않습니다.");
	  history.go(-1);
	</script>
<%}%>