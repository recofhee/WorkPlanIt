<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="all.action.PapersDBBean" %>
<%@ page import="all.action.PapersDataBean" %>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="all.action.PlanetDataBean" %>
<%@ page import="all.action.Job_infoDBBean" %>
<%@ page import="all.action.Job_infoDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
int db_mem_num= 0;

try{
int pageSize = 5;
String pageNum = request.getParameter("pageNum");


if (pageNum == null) {
pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
String currentPageString = Integer.toString(currentPage);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
List<BoardDataBean> saveList = null; 
	List<BoardDataBean> myartList = null; 
		List<PlanetDataBean> planetList = null; 
			List<PapersDataBean> papersList = null; 
				
				String email = (String)session.getAttribute("email");
				
				int mem_num = 0;
				
				if(email==null || email.equals(""))
				response.sendRedirect("../index.jsp");
				else{
				/* int mem_num = (Integer)session.getAttribute("mem_num"); */
				
				LogonDBBean dbPro = LogonDBBean.getInstance(); 
				LogonDataBean member = dbPro.getMember(email);
				
				db_mem_num = member.getMem_num();
				session.setAttribute("mem_num",db_mem_num);
				mem_num = (Integer)session.getAttribute("mem_num");
				
				PapersDBBean dbPro2 = PapersDBBean.getInstance(); 
				int paperscount = dbPro2.getPapers_Count(mem_num);
				
				BoardDBBean dbPro1 = BoardDBBean.getInstance();
				int savecount = dbPro1.getSave_Count(mem_num);
				int myartcount = dbPro1.getMyart_Count(mem_num);
				
				PlanetDBBean dbPro3 = PlanetDBBean.getInstance(); 
				int planetcount = dbPro3.getPlanetCount(mem_num);
				
				if (savecount > 0) {
				saveList = dbPro1.getSave_Articles(startRow, pageSize, mem_num);
			}
			if (myartcount > 0) {
			myartList = dbPro1.getMy_Articles(startRow, pageSize, mem_num);
		}
		if (planetcount > 0) {
		planetList = dbPro3.getMyPlanets(startRow, pageSize, mem_num);
	}
	if (paperscount > 0) {
	papersList = dbPro2.getPapers(startRow, pageSize, mem_num);
}

		    // session.setAttribute("mem_num",db_mem_num);
		    %>

		    <!DOCTYPE html>
		    <html lang="ko">
		    <head>
		    	<title>WORK PLAN IT</title>
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
		    	<link href="assets/css/footer-distributed.css" rel="stylesheet">
		    	<script src="assets/js/move.js" type="text/javascript" charset="utf-8"></script>
		    </head>

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

		<style type="text/css">
		@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	</style>

	<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

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
        		<li><a href="javascript:goMypage()"><div><i class="fa fa-user fa-fw"></i> My Page</div></a>
        		</li>
        		<li><a href="#"><div><i class="fa fa-gear fa-fw"></i> Settings</div></a>
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

<!-- Wrapper -->
<div id="wrapper" style="padding-top:4em;">
	<h2 align="center">MY PAGE</h2><br>



	<!-- Nav -->
	<nav id="nav">
		<ul>
			<li><a href="#one" class="active">PROFILE</a></li>
			<li><a href="#two">PAPERS</a></li>
			<li><a href="#three">PLANET</a></li>
			<li><a href="#four">BOARD</a></li>
			<li><a href="#five">WORK</a></li>
		</ul>
	</nav> 



	<!-- Main -->
	<div id="main">
		
		<!-- Introduction -->
		<section id="one" class="main special">
			<div class="spotlight">
				
				<div class="content">
					<header class="major">
						<h2>PROFILE</h2>
						<p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">나의 개인정보 입니다. 비밀번호를 수정 할 수 있습니다.</p>
					</header>
					
					<div class="row">
						<div class="col-md-6 mb-3" style="padding-left: 50px;">
							<div class="form-group row">
								<label for="inputEmail3" class="col-sm-2 col-form-label">Name</label>
								<div class="col-sm-10">
									<%=member.getName()%>
								</div>
							</div>
							<div class="form-group row">
								<label for="inputEmail3" class="col-sm-2 col-form-label">Email</label>
								<div class="col-sm-10">
									<%=email%>
								</div>
							</div>
							<div class="form-group row">
								<label for="inputEmail3" class="col-sm-2 col-form-label">Password</label>
								<div class="col-sm-10">
									<input type="password" class="inputbox" placeholder="현재 비밀번호 입력" style="padding-left:180px;">
								</div>
							</div>
							<div class="form-group row">
								<label for="inputEmail3" class="col-sm-2 col-form-label">Password Repeat</label>
								<div class="col-sm-10">
									<input type="password" class="inputbox" placeholder="변경 비밀번호 입력" style="padding-left:180px;">
								</div>
							</div>
							<div class="form-group row">
								<label for="inputEmail3" class="col-sm-2 col-form-label">Birthday</label>
								<div class="col-sm-10">
									<%=member.getBirthday()%>
								</div>
							</div>
							
							
						</div>
						<div class="col-md-6 mb-3">
							<a href="#" style="font-size: 20px;"><i class="fa fa-camera" aria-hidden="true" color="#5e6b92;"></i></a>				
							<span class="image avatar"><img src="assets/img/avatar.jpg" alt="" style="width:10em"; align="center"/></span>
						</div>

					</div>
					<div  align="right"  style="padding-right:1.8em">
						<a href="#" class="button alt" style="min-width: 8em;">save</a>
					</div>
					
				</div>
			</section>


			<!-- First Section -->
			<section id="two" class="main special">
				<header class="major">
					<p><h2>PAPERS</h2>
						<p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">나의 포트폴리오/ 자기소개서 / 입사지원서 등 다양한 서류를 작성 및 관리(수정,삭제) 합니다.</p>
					</header>
					<div class="container">
						
<!-- 					     <div  align="right">
							<a href="writeform.jsp" class="button alt">작성하기</a>
						</div> -->
						
						<section class="tiles">
							<% if (paperscount == 0) { %>
						<!-- <article class="feature" style="margin-top:20px;">
							<div class="content">
								<h4>작성한 서류가 없습니다.</h4>
							</div>
						</article> -->
						<% } else {
						for (int i = 0 ; i < papersList.size() ; i++) {
						PapersDataBean papers = papersList.get(i);
						%>
						
						<article class="style4">
							<span class="image">
								<img src="assets/img/pic01.png" alt="" />
							</span>
							<a href="m_content.jsp?num=<%=papers.getPapers_num()%>"><%=papers.getPapers_title()%> </a> 
						</article>   
						
						<%}} %>	
						
						<article class="style4">
							<span class="image">
								<img src="assets/img/pic02.png" alt="" />
							</span>
							<a href="m_writeform.jsp" style="color:#d7d7d7"> <i class="fa fa-plus" aria-hidden="true" style="font-size:50px; color:#d7d7d7; padding:20px;"></a></i></a> 
						</article>  
						<!-- <button class="btn_w"><a href="writeform3.jsp"> <i class="fa fa-plus" aria-hidden="true" style="font-size:50px; color:#eee; padding:20px;"></a></i></button> -->
					</section>	
					
				</div>
			</section>

			<!-- Second Section -->
			<section id="three" class="main special">
				<header class="major">
					<p><h2>PLANET</h2>
						<p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">가입한 플래닛 목록입니다.</p>
					</header>
					
					<div class="inner">
						<div class="inner"> 
							<section class="tiles" >
								<% if (planetcount == 0) { %>
								<article class="feature">
									<div class="content" style="text-align: center;">
										<h4 style="font-size: 20px; color: #000; font-family: 'Jeju Gothic', serif;">가입한 플래닛이 없습니다.</h4>
									</div>
								</article>
								<% } else {
								for (int i = 0 ; i < planetList.size() ; i++) {
								PlanetDataBean myplanet = planetList.get(i);
								%>
								<article class="feature" > 
									<div class="content" >
										<article class="style4" >
											<span class="image-circle">
												<img src="assets/img/pic08.png"class="image-circle">
											</span>

<a href="m_content.jsp?" style="color:#fff;"><%=myplanet.getPlanet_name()%></a> 
</article> 
</div>
</article>

<%}}%>
</section>	
</div>
</div>
</section>

<!-- Get Started -->
<section id="four" class="main special">
	<header class="major">
		<p><h2>BOARD</h2>
			<p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">커뮤니티에 작성한 글 / 관심글을 관리 합니다.</p>
		</header>
		
		<div class="row"  style="padding-top:40px;">
			<div class="col-sm-6">
				<header class="major" style="text-align:left;">
					<h3>작성글<i class="fa fa-pencil-square-o" aria-hidden="true" style="color:#5e6b92; "></i></h3>
				</header>
				<div class="inner" style="padding-top:40px;"> 
					
					<% if (myartcount == 0) { %>
					<article class="feature">
						<div class="content">
							<h4 style="font-size: 20px; color: #000; font-family: 'Jeju Gothic', serif;">작성하신 글이 없습니다.</h4>
						</div>
					</article>
					<% } else {
					for (int i = 0 ; i < myartList.size() ; i++) {
					BoardDataBean myart = myartList.get(i);
					%>
					
					<article class="feature">
						<div class="content">
							<div class="row" style="font-size: 20px; color: #000; font-family: 'Jeju Gothic', serif; align:cetner;">
								<div class="col-md-6 mb-3" style="width:100%">
									<div class="form-group row" >
										<label class="col-sm-2 col-form-label" style="padding-left:0px;"><%=myart.getBoard_cate_name()%></label>
										<div class="col-sm-10">
											<%=myart.getBoard_title()%><!-- <a href="#" class="button alt" style="font-size: 15px; float:right;">delete</a> -->
											
										</div>
									</div>
									
									
								</div>
							</article>
							
							<%}}%>
						</div>
						
					</div>
					
					<div class="col-sm-6">
						<header class="major"  style="text-align:left;">
							<h3>관심글 <i class="fa fa-heart" aria-hidden="true" style="color:#5e6b92; padding-left:5px;"></i> </h3>
						</header>
						<div class="inner"> 
							<% if (savecount == 0) { %>
							<article class="feature">
								<div class="content">
									<h4 style="font-size: 20px; color: #000; font-family: 'Jeju Gothic', serif; padding-top: 40px;">관심있는 글이 없습니다.</h4>
								</div>
							</article>
							<% } else {
							for (int i = 0 ; i < saveList.size() ; i++) {
							BoardDataBean save = saveList.get(i);
							%>
							<article class="feature">
								<div class="content">
									<div class="row" style="font-size: 20px; color: #000; font-family: 'Jeju Gothic', serif; align:cetner;">
										<div class="col-md-6 mb-3" style="width:100%">
											<div class="form-group row" >
												<label class="col-sm-2 col-form-label" style="padding-left:0px;"><%=save.getWriter()%></label>
												<div class="col-sm-10">
													<%=save.getBoard_title()%>

												</div>
											</div>


										</div>
									</article>

						
							<%}}%>
						</div>
					</div>
				</div>
			</section>
			
			<section id="five" class="main special">
				<header class="major">
					<p><h2>WORK</h2>
						<p style="font-size: 16px; color: #000; font-family: 'Jeju Gothic', serif;">관심있는 채용 정보 입니다.</p>
						<li><a href="http://www.saramin.co.kr">한국 국제 무역 사무소 사무직</a></li>
						
					
				</p>	
			</header>


		</section>
	</div>
	<!-- Footer -->
	<hr> 
	<footer class="footer-mypage" style="margin-top: 10px; padding-bottom: 30px;">  
		<div class="row">
			<div class="footer-left col-md-6" style="margin-top: 10px;">
				<p class="footer-links">
					<a href="./aboutus/aboutus.jsp">ABOUT US</a> &nbsp;&nbsp;|&nbsp;&nbsp; <a href="./sitemap/sitemap.jsp">SITE MAP</a>
				</p>
				<br><br>
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
			<a href="http://www.saramin.co.kr"><img src="assets/img/saramin.png" style="height:40px;"></a>
			&emsp;&emsp;<a href="http://www.jobkorea.co.kr"><img src="assets/img/jobkorea.png" style="height:40px;"></a>
			&emsp;&emsp;<a href="http://www.incruit.com"><img src="assets/img/incruit.png" style="height:40px;"></a>
		</div>
	</footer>



	<!-- Scripts -->
	<script src="assets/js/m_jquery.min.js"></script>
	<script src="assets/js/m_jquery.scrollex.min.js"></script>
	<script src="assets/js/m_jquery.scrolly.min.js"></script>
	<script src="assets/js/m_skel.min.js"></script>
	<script src="assets/js/m_util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="assets/js/m_main.js"></script>

</body>
<script>

	$(window).scroll(function(){
					// 100 = The point you would like to fade the nav in.
					if ($(window).scrollTop() > 100 ){
						$('.navbar').addClass('active');
					} else {
						$('.navbar').removeClass('active');
					};
				});


			</script>
			
			</html>
			
			<% 
		}
	}catch(Exception e){
	e.printStackTrace();
}
%>