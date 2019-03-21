<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="all.action.LogonDBBean"%>
<%@ page import="all.action.LogonDataBean"%>
<%@ page import="all.action.TodoDBBean"%>
<%@ page import="all.action.TodoDataBean"%>
<%@ page import="all.action.TodayDBBean"%>
<%@ page import="all.action.TodayDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<!-- 세션 -->
<%
  String pagefile = request.getParameter("page");
  if (pagefile == null) {
    pagefile = "main";
  }
  
  String email = "";
  int db_mem_num = 0;
  int mem_num = 0;
  
  try{
         email = (String)session.getAttribute("email");
         
         LogonDBBean dbPro = LogonDBBean.getInstance(); 
         LogonDataBean member = dbPro.getMember(email);
         db_mem_num = member.getMem_num();
         session.setAttribute("mem_num",db_mem_num);
         
         if(email==null || email.equals(""))
         response.sendRedirect("index.jsp");
         else{
%>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<link href="assets/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel='stylesheet prefetch' href='https://fonts.googleapis.com/css?family=Open+Sans'>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="assets/css/footer-distributed.css" rel="stylesheet">
<link href="assets/css/sitemap_style1.css" rel="stylesheet">
<link href="assets/css/sitemap_style2.css" rel="stylesheet">

<script src="assets/js/jquery-3.2.1.min.js"></script>
<script src="assets/bootstrap-3.3.7/js/bootstrap.min.js"></script>


<!-- 배너이미지 호버효과  css -->
<style>
#banner a img{
   -webkit-filter: grayscale(100%);
filter: gray;
}
 
#banner a:hover img{
-webkit-filter: grayscale(0%);
filter: none;
}

#sm::-webkit-scrollbar-track {
	background-color: #eee;
}

#sm::-webkit-scrollbar {
	width: 5px;
	background-color: #eee;
}

#sm::-webkit-scrollbar-thumb {
	background-color: rgba(94, 107, 146, 1);
}
</style>



<title>어바웃 3</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">
  

</head>

<body id="sm">

<nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
               data-target="#myNavbar">
               <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                  class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="../main.jsp">WORK PLAN IT</a>
         </div>
         <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
               <li>
               <a href="../main.jsp">HOME</a></li>  
               <li>
               <a href="../aboutus/aboutus.jsp">ABOUTUS</a></li>
              
               </ul>
         </div>
      </div>
   </nav>

<div class="container" style="margin-top:70px; padding-bottom: 40px;">
  <h1>Site Map</h1>

</div> 

<br>



<content>
  <div class="footer-wrap"  style="margin-top: 10px;  padding-bottom: 50px; margin-bottom: 30px;">
     
       <div class="one">
       <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;My Page</h2>
      <ul>
        <a href="../mypage.jsp">PROFILE</a>
        <a href="../mypage.jsp">PAPERS</a>
        <a href="../mypage.jsp">PLANET</a>
        <a href="../mypage.jsp">BOARD</a>
      <a href="../mypage.jsp">WORK</a>
    
    </div>
       <div class="two">
       <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMMUNITY</h2>
         <ul>
         <a href="../commu/commu.jsp">전체보기</a>
         <a href="../commu/commu.jsp?page=list_doc">서류</a>
         <a href="../commu/commu.jsp?page=list_written">필기</a>
         <a href="../commu/commu.jsp?page=list_prac">실기</a>
         <a href="../commu/commu.jsp?page=list_inter">면접</a>
         </ul>
         </div>
        <div class="two">
        <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PLANET</h2>
         <ul>
         <a href="../planet.jsp">PLANET</a>
         
        
         </ul>
         </div>
    </ul>
  </div>
</content>

<br>
<br>
<br>
<br>
<br>

  <footer class="footer-distributed" style="margin-top: 3px;">      
      <div class="row">
         <div class="footer-left col-md-6" style="margin-top: 10px; margin-bottom: 3px; padding-bottom: 5px; ">
            
            
            <p>
               made by PLANETARIUM <br>
               powered by SARAMIN <br>
               <br> Hanyang Woman's University Department of Computer
               Information <br> 서울시 성동구 살곶이길 200 한양여자대학교 정보문화관 5층 PC54실 <br>
            </p>
         </div>
         <div class="col-md-6" align="right">
            <img src="assets/img/LOGO_WHITE.png" width="22%" height="18%">
         </div>
      </div>
      <br>
      <div id="banner" style="margin-top: 10px;">   
    &emsp;&emsp;<a href="http://www.saramin.co.kr"><img src="./assets/img/saramin.png" style="height:40px;"></a>
      &emsp;&emsp;<a href="http://www.jobkorea.co.kr"><img src="./assets/img/jobkorea.png" style="height:40px;"></a>
      
     &emsp;&emsp;<a href="http://www.incruit.com"><img src="./assets/img/incruit.png" style="height:40px;"></a>
       </div>
       </footer>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
  
</body>
</html>


<% 
     }
    }catch(Exception e){
    e.printStackTrace();
  }
%>