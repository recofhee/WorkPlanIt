<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ page import="java.sql.*"%>  
<% 
int mem_num = (Integer)session.getAttribute("mem_num");
String email = (String)session.getAttribute("email");

Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
ResultSet rs = null;


int papers_num = 0;


try{




if(request.getParameter("papers_num")!=null) {
papers_num=Integer.parseInt(request.getParameter("papers_num"));

}	



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
  <!-- <link rel="stylesheet" href="assets/css/mypage.css" /> -->
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
          <!-- /.dropdown-alerts -->
        </li>
        <!-- /.dropdown -->
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
          <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
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

 </section>

 <!-- Main -->
 <div id="main">

   <!-- Post -->
   <article class="post">
     <header>
      <form method="post" name="write" action="m_writePro.jsp" style="width: 100%;">
        <input type="hidden" name="mem_num" value="<%=mem_num%>">


        <div class="title">
          <h4><input type="text" name="papers_title" placeholder="제목을 입력하세요." style="    font-size: 40px;"><h4>
          </div>
        </header>



        <div class="row">
         <div class="col-md-6 mb-3" style="padding-left: 50px;">
          <div class="form-group row">
            <p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">서류 분야</p>
            <div class="col-sm-10">
             <select name="papers_cate_num" class="form-control" style="border-radius: 0px; width: 20%">
               <option value="1">자소서</option>
               <option value="2">이력서</option>
               <option value="3">에세이</option>
               <option value="4">메 모</option>
             </select>
           </div>
         </div>

       </div></div>



       <pre><textarea name="papers_contents" placeholder="내용을 입력하세요."></textarea></pre>
       <%-- <%=papers.getPapers_contents() %> --%>

     </article>





     <ul class="media-date text-uppercase reviews list-inline" style=" float:right;
     color: #636363 !important; ">
     <li><button type="button" class="button" value="List" OnClick="document.location.href='mypage.jsp'" style=" box-shadow: inset 0 0 0 1px #dddddd;" >취소</button></li>
     <li><button type="submit" class="button" value="작성완료" style=" box-shadow: inset 0 0 0 1px #dddddd;">Save</button></li>
   </ul> 
 </article>
</div>
</article>


</form>
</body>
</html> 



<%
} catch(Exception e) { 
e.printStackTrace();
} finally {
if(rs != null) try{rs.close();}catch(SQLException sqle){}
if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
if(conn != null) try{conn.close();}catch(SQLException sqle){}
}
%>

