<!--mp_profile.jsp에다가 탈퇴 버튼 추가 후 기능 넣기-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%
 String email = "";
 email = (String) session.getAttribute("email");
 if (email == null || email.equals("")) {
  response.sendRedirect("mp_profile.jsp");   //sendRedirect는 외부 내부 상관없이 이동할 수 있습니다. 즉 다른 도메인의 주소로도 이동이 가능
 } else {
%>

 <body onload="begin()">
  <b><font size="10" color="gray">회원탈퇴</font></b>
  <hr>
  <br>
  <form name="deleteform" action="deletePro.jsp" method="post" onSubmit="return checkIt()">
   <table border="3" bordercolor="skyblue">
    <tr>
     <td width = "80" align = "center">비밀번호</td>
     <td>
      <input type="password" name="passwd" style="text-align: right;">
     </td>
    </tr>
   </table>
   <br>
   <input type="submit" value="회원탈퇴">
   <input type="button" value="취소" onclick="javascript:window.location='mp_profile.jsp'">
  </form>
 </body>
<%
 }
%>
<script language="javascript">
 function begin() {
  document.deleteform.password.focus();
 }
 function checkIt() {
  if (!document.deleteform.password.value) {
   alert("비밀번호를 입력해주세요");
   document.deleteform.password.focus();
   return false;
  }
 }
</script>
</html> 