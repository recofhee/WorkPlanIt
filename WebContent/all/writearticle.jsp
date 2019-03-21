<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="all.action.PlanetDataBean" %>

<% 
	String email = (String)session.getAttribute("email");
	int mem_num = (Integer)session.getAttribute("mem_num");
	int planet_cont_num = 0, ref = 1, re_step = 0, re_level = 0;
	int planet_num = Integer.parseInt(request.getParameter("planet_num"));
	
	LogonDBBean dbPro = LogonDBBean.getInstance(); 
	LogonDataBean member = dbPro.getMember(email);
	
	String name = member.getName();
	
	try{
		if(request.getParameter("planet_cont_num")!=null){
	    	planet_cont_num=Integer.parseInt(request.getParameter("planet_cont_num"));
	    	//planet_num=Integer.parseInt(request.getParameter("planet_num"));
	    	ref=Integer.parseInt(request.getParameter("ref"));
		    re_step=Integer.parseInt(request.getParameter("re_step"));
		    re_level=Integer.parseInt(request.getParameter("re_level"));
    	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<link href="./assets/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="./assets/css/pmain.css" rel="stylesheet">
<link href="./assets/css/mpstyle.css" rel="stylesheet">
<link href="./assets/css/iEdit.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./assets/slick-1.6.0/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="./assets/slick-1.6.0/slick/slick-theme.css"/>
<script src="./assets/js/modernizr.js"></script> <!-- Modernizr -->

<title>WORK PLAN IT</title>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#myPage">WORK PLAN IT</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./main.jsp">HOME</a></li>
        <li><a href="./commu/commu.jsp">COMMUNITY</a></li>
        <!-- <li><a href="#portfolio">PORTFOLIO</a></li>
        <li><a href="#pricing">PRICING</a></li>
        <li><a href="#contact">CONTACT</a></li> --> 
        <!-- /.dropdown -->
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
                <li><a href="./mypage.jsp"><div><i class="fa fa-user fa-fw"></i> My Page</div></a>
                </li>
                <li><a href="./mypage.jsp"><div><i class="fa fa-gear fa-fw"></i> Settings</div></a>
                </li>
                <li class="divider"></li>
                <li><a href="./index.jsp"><div><i class="fa fa-sign-out fa-fw"></i> Logout</div></a>
                </li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
      </ul>
    </div>

  </div>
</nav>

<div id="content" class="site-content">
    <main id="writearticle" class="site-main" role="writearticle">    
        <article class="hentry">
            <div class="shape-bottom">
                <div class="bg-secondary block-title">
                    <h2>글 작성</h2>
                </div>
            </div>

            <form action="writePro.jsp?planet_num=<%=planet_num%>" method="post" name="writearticle" id="writearticleform" class="writearticle-form" onsubmit="return writeSave()">
            	<input type="hidden" name="planet_num" value="<%=planet_num%>">
            	<input type="hidden" name="mem_num" value="<%=mem_num%>">
                <input type="hidden" name="writer" value="<%=name%>">
                <input type="hidden" name="ref" value="<%=ref%>">
				<input type="hidden" name="re_step" value="<%=re_step%>">
				<input type="hidden" name="re_level" value="<%=re_level%>">
				<input type="hidden" name="email" value="<%=email%>">

                <p class="writearticle-form-title"><label for="writearticle"></label><textarea name="planet_title" rows="1" aria-required="true" placeholder="제목" required></textarea></p>

                <p class="writearticle-form-content"><label for="writearticle"></label><textarea name="planet_contents" rows="13" aria-required="true" placeholder="내용을 입력하세요." required></textarea></p>

				<!--
                <label for="upload">Upload</label>
                <input type="file" id="upload">
                -->

                <p class="form-submit" style="float: left;"><input type="button" id="list" value="목록" onclick="document.location.href='myplanet.jsp?planet_num=<%=planet_num%>'"></p>

                <p class="form-submit" style="float: right;"><input type="submit" id="submit" class="submit" value="확인"></p>
            </form>

        </article><!-- #post-## -->
    </main><!-- #main --> 
</div>

<a href="#top" id="toTop" class="visible"><i class="fa fa-angle-up fa-lg"></i></a>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

</body>
</html>
<%
} catch(Exception e) { 
	e.printStackTrace();
}
%>