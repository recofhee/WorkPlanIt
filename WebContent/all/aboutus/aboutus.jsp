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
<link href="assets/css/aboutus_style_1.css" rel="stylesheet">
<link href="assets/css/aboutus_style_2.css" rel="stylesheet">

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
</style>




<title>About Us</title>

  
</head>

<body>

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
               <a href="../sitemap/sitemap.jsp">SITEMAP</a></li>
              
               </ul>
         </div>
      </div>
   </nav>




  <div class="slider-container">
  <div class="slider-control left inactive"></div>
  <div class="slider-control right"></div>
  <ul class="slider-pagi"></ul>
  <div class="slider">
    <div class="slide slide-0 active">
      <div class="slide__bg"></div>
      <div class="slide__content">
        <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
          <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
        </svg>
        <div class="slide__text">
          <h2 class="slide__text-heading">PLANETARIUM</h2>
          <p class="slide__text-desc">Hello
I have something to say to you.
This site is a graduate work of computer information department of Hanyang Women's University in 2017.
There is only one site for everyone to get ready for work.<br><br>
There are five people who made it.
First,<br> 
<b>Kim Su-Jeong</b> is the root hero leader of this site.<br>
<b>Choi Hee-Ju</b> is the most sincere and has great ability in the database.<br>
<b>Kim Hee-Soo</b> was very talented in design and she did everything she could.<br>
<b>Ryu Hye-Bin</b> has created the best paper storage.<br>
<b>Joh Yun-A</b> encouraged all the staff and performed her job faithfully.<br><br>
I hope that everyone will be happy as I finish my long and long graduation work in 2017.</p>


          
        </div>
      </div>
    </div>
    <div class="slide slide-1 ">
      <div class="slide__bg"></div>
      <div class="slide__content">
        <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
          <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
        </svg>
        <div class="slide__text">
          <h2 class="slide__text-heading">채용 일정 관리</h2>
          <p class="slide__text-desc">채용 일정을 달력에 추가시켜 일정관리를 할 수 있습니다.</p>
          
        </div>
      </div>
    </div>
    <div class="slide slide-2">
      <div class="slide__bg"></div>
      <div class="slide__content">
        <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
          <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
        </svg>
        <div class="slide__text">
          <h2 class="slide__text-heading">채용정보검색</h2>
          <p class="slide__text-desc">사람인 사이트와 연동하여 관심있는 채용정보를 검색할 수 있습니다.</p>
          
        </div>
      </div>
    </div>
    <div class="slide slide-3">
      <div class="slide__bg"></div>
      <div class="slide__content">
        <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
          <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
        </svg>
        <div class="slide__text">
          <h2 class="slide__text-heading">Planet</h2>
          <p class="slide__text-desc">비공개형 소규모 게시판으로 같은 목표를 가진 회원끼리 정보공유를 
          할 수있습니다.</p>
          
        </div>
      </div>
    </div>
     <div class="slide slide-4">
      <div class="slide__bg"></div>
      <div class="slide__content">
        <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
          <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
        </svg>
        <div class="slide__text">
          <h2 class="slide__text-heading">Community</h2>
          <p class="slide__text-desc">개방형 게시판으로 모든 사용자들과 소통을 할 수있습니다.</p>
          
        </div>
      </div>
    </div>
  </div>
</div>





   
   
   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script  src="assets/js/index.js"></script>



</body>
</html>

<% 
     }
    }catch(Exception e){
    e.printStackTrace();
  }
%>