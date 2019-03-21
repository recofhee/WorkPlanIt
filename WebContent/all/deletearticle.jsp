<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<!-- <link href="./assets/css/sweetalert.css" rel="stylesheet">
<script src="./assets/js/sweetalert.min.js"></script> -->
<% request.setCharacterEncoding("utf-8");%>

<%
  	int num = Integer.parseInt(request.getParameter("num"));
  	String pageNum = request.getParameter("pageNum");
  	String email = (String)session.getAttribute("email");
  	int planet_num = Integer.parseInt(request.getParameter("planet_num"));

  	PlanetDBBean dbPro = PlanetDBBean.getInstance(); 
  	int check = dbPro.deleteArticle(num, email);

  	if (check == 1) {
%>
	<meta http-equiv="Refresh" content="0;url=myplanet.jsp?planet_num=<%=planet_num%>">
<%
	} else {
%>
		<script>        
         	alert("작성자만 삭제 가능합니다.");
         	/* $(document).on(function () {
			  swal({
			    title: '작성자만 삭제 가능합니다.',
			    type: 'error',
			    timer: 1500,
			    showCloseButton: false,
			    showCancelButton: false,
			    showConfirmButton: false
			    // onOpen: function() {
			    //   swal.showLoading()
			    // }
			  })
			});  */
         	history.go(-1);
   		</script>
<%} %>