<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*"%>
<%@ page import="all.action.LogonDBBean" %>
<html> 
<% 
String email = request.getParameter("email"); 
LogonDBBean confirm = LogonDBBean.getInstance(); 
int check = confirm.confirmemail(email); 
if (check == 1) { 
%> 
<center> 
<br> <b><font color="red"><%=email%></font>는 이미 사용중인 아이디입니다.</b> 

<b>다른 아이디를 입력하세요.</b> <p> 

<% } else 
{ %> 
<center> <br> <b>입력하신 
<font color="red"><%=email%></font>는 사용 가능한 이메일입니다. </b> <p> 
<input type="button" value="닫기" onclick="setemail()"> </center> <% } %> <script language="javascript"> 

function setemail()
{ 
opener.document.inputMember.email.value="<%=email%>"; 
self.close(); 
} 
</script> 
</html>