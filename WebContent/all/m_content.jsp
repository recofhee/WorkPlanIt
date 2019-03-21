<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "all.action.PapersDBBean" %>
<%@ page import = "all.action.PapersDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*"%>  

<%


int mem_num = (Integer)session.getAttribute("mem_num");
int papers_num = Integer.parseInt(request.getParameter("num"));

try{
PapersDBBean dbPro = PapersDBBean.getInstance(); 

PapersDataBean papers = dbPro.getPapers(papers_num);


%>




<!DOCTYPE HTML>
<head>
	<title>m_content</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link href="assets/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <link href="assets/css/mypagecss.css" rel="stylesheet">
  <link href="assets/css/mpheader.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/mypage.css" />
  <link rel="stylesheet" href="assets/css/mypage_w.css" />
  <link href="assets/css/footer-distributed.css" rel="stylesheet">
  <script src="assets/js/move.js" type="text/javascript" charset="utf-8"></script>
</head>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
</style>

<body class="single">

  <nav id="header" class="navbar navbar-default navbar-fixed-top bg transition">
    <div class="hcontainer">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
        </button>
        <a class="navbar-brand" href="javascript:goHome()">WORK PLAN IT</a>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
          <li><a href="javascript:goHome()">HOME</a></li>
          <li><a href="javascript:goCommu()">COMMUNITY</a></li>

        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
          </a>
          <ul class="dropdown-menu dropdown-alerts">
            <li>
              <a href="#">
                <div>
                  <i class="fa fa-comment fa-fw"></i> New Comment
                  <span class="pull-right small">4분 전</span>
                </div>
              </a>
            </li>
            <li>
              <a href="#">
                <div>
                  <i class="fa fa-envelope fa-fw"></i> Message Sent
                  <span class="pull-right small">4분 전</span>
                </div>
              </a>
            </li>
            <li>
              <a href="#">
                <div>
                  <i class="fa fa-tasks fa-fw"></i> New Task
                  <span class="pull-right small">4분 전</span>
                </div>
              </a>
            </li>
            <li class="divider"></li>
            <li>
              <a class="text-center" href="#">
                <strong>See All Alerts ></strong>
              </a>
            </li>
          </ul>

        </li>

        <li class="dropdown userdd">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
          </a>
          <ul class="dropdown-menu dropdown-user">
            <li><a href="javascript:goMypage()"><div><i class="fa fa-user fa-fw"></i> My Page</div></a>
            </li>
            <li><a href="#"><div><i class="fa fa-gear fa-fw"></i> Settings</div></a>
            </li>
            <li class="divider"></li>
            <li><a href="javascript:goLogin()"><div><i class="fa fa-sign-out fa-fw"></i> Logout</div></a>
            </li>
          </ul>
      
        </li>
  
      </ul>
    </div>
  </div>
</nav>

<!-- Wrapper -->
<div id="wrapper">

  <!-- Header -->
  <h2 align="center">PAPERS</h2><br>
  <!-- Menu -->
  <section id="menu">

   <!-- Search -->
   <section>
    <form class="search" method="get" action="#">
     <input type="text" name="query" placeholder="Search" />
   </form>
 </section>
</section>

<!-- Main -->
<div id="main">

 <!-- Post -->
 <article class="post">
  <header>
   <div class="title">
    <h4><a href="#"><%=papers.getPapers_title()%></a></h4>


  </div>

</header>
<textarea style="height:40em; font-size:20px;"> <%=papers.getPapers_contents() %></textarea> 
</article>
<a href="mypage.jsp" class="button alt" style="font-size: 15px; float:right; align: center">List</a>
</div>

<!-- Footer -->



</div>

</form>     
<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>

<script src="assets/js/main.js"></script>



</body>
</html> 
<%
}
catch(Exception e) { 
e.printStackTrace();
} 
%>