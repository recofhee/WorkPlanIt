<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.sql.*"%>
<%@ page import="all.action.LogonDBBean" %>
<%
 request.setCharacterEncoding("utf-8");
%>
<html>
<%
 String email = (String) session.getAttribute("email");
 String password = request.getParameter("password");
 LogonDBBean delete = LogonDBBean.getInstance();
 int check = delete.deleteMember(email, password);
 if (check == 1) {
  session.invalidate();
%>
<center>
 <form action="index.jsp" method="post">
  <b><h2>회원정보가 삭제되었습니다.</h2></b>
  <input type="submit" value="확인">
 </form>
 <%
  } else {
 %>
 <script language="javascript">
  alert("비밀번호가 맞지 않습니다.");
  history.go(-1);
 <%}%>
  
 </script>
</center>
</html> 