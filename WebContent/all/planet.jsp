<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="all.action.PlanetDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>
<%
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
	    pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int pcount = 0, newcount = 0, hotcount = 0;
	int number = 0;
	
	

	number = pcount-(currentPage-1)*pageSize;
    //response.sendRedirect("planet.jsp");
%>
<!-- 세션 -->
<%
	String name = null;
	String email = (String)session.getAttribute("email");
	Integer planet_num = (Integer)session.getAttribute("planet_num"); // int여야 하는데 왜 int로 하면 안 되고 Integer로 하면 들어가지는 거지 =ㅅ= 뭐가 문제지
	/* int planet_num = Integer.parseInt(request.getParameter("planet_num"));
	session.setAttribute("planet_num", planet_num); */
	
	try {
		if(email==null || email.equals(""))
			response.sendRedirect("./index.jsp");
		else{
				int mem_num = (Integer)session.getAttribute("mem_num");
				int db_planet_num = 0;
				
				PlanetDBBean dbPro2 = PlanetDBBean.getInstance(); 
				pcount = dbPro2.getPlanetCount(mem_num);
				newcount = dbPro2.getArticleCount();
				hotcount = dbPro2.getArticleCount();
				
				PlanetDataBean member = dbPro2.getMyPlanet(mem_num);
				db_planet_num = member.getPlanet_num(); 
			    session.setAttribute("planet_num",db_planet_num);
			    
				/* String keyword = request.getParameter("keyword");
				List<PlanetDataBean> planetList = dbPro.searchPlanet(keyword); */
				List<PlanetDataBean> myplanetList = null;
				List<PlanetDataBean> newarticleList = null;
				List<PlanetDataBean> hotarticleList = null;
				
				if (pcount > 0) {
			    	myplanetList = dbPro2.getMyPlanets(startRow, pageSize, mem_num);
			    }
				
				if (newcount > 0) {
			        newarticleList = dbPro2.getNewArticles(startRow, pageSize, planet_num);
			    }
				
				if (hotcount > 0) {
			        hotarticleList = dbPro2.getHotArticles(startRow, pageSize);
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://demo.itsolutionstuff.com/plugin/croppie.js"></script>
<link href="./assets/css/pmain.css" rel="stylesheet">

<link href="./assets/css/style.css" rel="stylesheet">
<link href="./assets/css/myplanet.css" rel="stylesheet">
<link href="./assets/css/createplanet.css" rel="stylesheet">
<link href="./assets/css/searchplanetmodal.css" rel="stylesheet">
<link href="./assets/css/sweetalert.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./assets/slick-1.6.0/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="./assets/slick-1.6.0/slick/slick-theme.css"/>
<script src="./assets/js/modernizr.js"></script> <!-- Modernizr -->

<title>WORK PLAN IT</title>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<!-- nav -->
<nav id="header" class="navbar navbar-default navbar-fixed-top bg transition">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="main.jsp">WORK PLAN IT</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="main.jsp">HOME</a></li>
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
                <li><a href="login.html"><div><i class="fa fa-sign-out fa-fw"></i> Logout</div></a>
                </li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
      </ul>
    </div>

  </div>
</nav>



<!-- Banner -->
<section id="banner">
  <h2>P L A N E T</h2>
  <!-- <p>Another fine responsive site template freebie by HTML5 UP.</p> -->
</section>

<section id="main" class="container">
	<section class="box special">
	    <header class="major">
			<h2>Your Planets</h2>
			<p>shine brightly</p>
	    </header>

		<div class="planet">
			<% if (pcount == 0) { %>

			<h2 style="margin: 50px 0;">가입된 Planet이 없습니다!</h2>
			<br>
			<div class="row">
				<div class="col-sm-6">
					<a class="btn btn-lg btn-cpjp" data-toggle="collapse" data-target="#createPlanet" id="btn-cp">Planet 생성</a>
				</div>
				<div class="col-sm-6">
					<a class="btn btn-lg btn-cpjp" id="btn-jp">Planet 가입</a>
				</div>
			</div>

			<% } else {%>
			<ul class="ch-grid my-planet-list">
				<%  
				   for (int i = 0 ; i < myplanetList.size() ; i++) {
				   PlanetDataBean myplanet = myplanetList.get(i);
				%>
				<li>
					<a href="myplanet.jsp?planet_num=<%=myplanet.getPlanet_num()%>">
			            <div class="ch-item ch-img-<%=myplanet.getPlanet_num()%>">
			              <div class="ch-info">
			                <h3><br><%=myplanet.getPlanet_name()%><%-- <br><%=myplanet.getPlanet_profile()%> --%></h3>
			              </div>
			            </div>
					</a>
				</li>
				<%} %>
			</ul>
			<%} %>
		</div>

	    <a class="btn createplanet-bottom" data-toggle="collapse" data-target="#createPlanet">
			<i class="fa fa-plus" aria-hidden="true"></i>
	    </a>
	</section>

	<div id="createPlanet" class="collapse cont_centrar">
		<div class="cont_login">
			<form method="post" name="cpform" action="cpPro.jsp">
				<div class="cont_tabs_login">
		            <li class="cp_tabs active">
		              <a onclick="">CREATE PLANET</a>
		              <span class="linea_bajo_nom"></span>
		            </li>
				</div>
	
				<div class="cont_text_inputs">
					<input type="hidden" name="mem_num" value="<%=mem_num%>">
					<input type="text" class="input_form_sign d_block active_inp" placeholder="PLANET NAME" name="planet_name" id="planet_name" required>
					<input type="text" class="input_form_sign d_block active_inp" placeholder="PROFILE" name="planet_profile" required>
				</div>
	
				<div class="cont_btn">
	            	<button class="btn_sign">확인</button>
				</div>
			</form>
		</div>   
	</div>
</section>

<section class="Search section bg-img">
	<div class="container">
		<p>Life is a journey, not a guided tour.</p>
		<form method="get" class="form-inline" name="spform" action="spPro.jsp">
		   <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Enter planet keyword" required>
		   <button type="submit" class="btn vira-btn">Search</button>
		</form>
	</div>
</section>

<section id="field" class="field">
  <div class="container">
    <div class="row"> 
      <div class="col-sm-6 text-left">
        <h2 class="heading">NOW</h2>
      </div>
      <div class="col-sm-6 text-right text-left-mobile">
        <div class="rating">
          <span class="rate active"></span>
          <span class="rate active"></span>
          <span class="rate active"></span>
          <span class="rate active"></span>
          <span class="rate"></span>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-sm-6">
        <h3 class="content">BEST</h3>
        <div class="autoplay">
            <% if (hotcount == 0) { %>
       		<div class="item">
	            <div class="field text-center wow animated fadeInUp">
					<h4 class="subheading field-name">인기 글이 없습니다.</h4>
	            </div>
            </div>
			<% } else {
				for (int i = 0 ; i < hotarticleList.size() ; i++) {
					PlanetDataBean article = hotarticleList.get(i);
			%>
              <div class="item">
                <div class="field text-center wow animated fadeInUp">
                  <%-- <h4 class="subheading field-name"><%=article.getPlanet_title()%></h4>
                  <h6 class="subheading muted field-city"><%=article.getPlanet_name()%></h6> --%>
                  <h6 class="subheading muted field-city"><%=article.getPlanet_title()%></h6>
                  <p class="small"><%=article.getPlanet_contents()%></p>
                </div>
              </div>
            <%}
   			}%>
        </div>
      </div>
      <div class="col-sm-6">
        <h3 class="content">NEW</h3>
        <div class="autoplay">
        	<% if (newcount == 0) { %>
       		<div class="item">
	            <div class="field text-center wow animated fadeInUp">
					<h4 class="subheading field-name">최신 글이 없습니다.</h4>
	            </div>
            </div>
			<% } else {
				for (int i = 0 ; i < newarticleList.size() ; i++) {
					PlanetDataBean article = newarticleList.get(i);
			%>
              <div class="item">
                <div class="field text-center wow animated fadeInUp">
                  <%-- <h4 class="subheading field-name"><%=article.getPlanet_title()%></h4>
                  <h6 class="subheading muted field-city"><%=article.getPlanet_name()%></h6> --%>
                  <h6 class="subheading muted field-city"><%=article.getPlanet_title()%></h6>
                  <p class="small"><%=article.getPlanet_contents()%></p>
                </div>
              </div>
            <%}
   			}%>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- <section id="expertise" class="expert">
    <div class="row">
      <div class="col-sm-6">
        <img src="https://static.pexels.com/photos/572897/pexels-photo-572897.jpeg" class="img-responsive">
      </div>
      <div class="col-sm-5 section">
        <h2 class="title">About Planet</h2>
        <div class="item">
          <p>
              Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall proposition. Organically grow the holistic world view of disruptiveinnovationvia workplace diversity and empowerment.
          </p>
        </div>
        </div>
      </div>
    </div>
</section>
 -->
<section id="two" class="main style2">
  <div class="container">
    <div class="row">
      <div class="col-sm-6">
        <ul class="major-icons">
          <li><span class="icon style1 major fa fa-users"></span></li>
          <li><span class="icon style2 major fa fa-comments-o"></span></li>
          <li><span class="icon style3 major fa fa-share-alt"></span></li>
          <li><span class="icon style4 major fa fa-lock"></span></li>
          <li><span class="icon style5 major fa fa-calendar"></span></li>
          <li><span class="icon style6 major fa fa-cog"></span></li>
        </ul>
      </div>
      <div class="col-sm-6">
        <header class="major">
          <h2>About Planet</h2>
        </header>
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
</section>

<footer class="footer-distributed">
  <br>
  <div class="row">
    <div class="footer-left col-md-6">
      <p class="footer-links">
        <a href="./aboutus/aboutus.jsp">ABOUT US</a>
        &nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="./sitemap/sitemap.jsp">SITE MAP</a>
      </p>
      <br><br>
      <p>made by PLANETARIUM
        <br><br>
        Hanyang Woman's University Department of Computer Information
        <br>
        서울시 성동구 살곶이길 200 한양여자대학교 정보문화관 5층 PC54실
        <br>
      </p>
    </div>
    <div class="col-md-6" align="right">
      <img src="assets/img/LOGO_WHITE.png" width="22%" height="22%">
    </div>
  </div>
</footer>

<a href="javascript:" id="toTop"><i class="fa fa-chevron-up" aria-hidden="true"></i></a>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./assets/js/pmain.js"></script> <!-- Resource jQuery -->
<script src="./assets/js/sweetalert.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="./assets/slick-1.6.0/slick/slick.min.js"></script>


<script>
//Scroll To Top
$(window).scroll(function(){
  // 100 = The point you would like to fade the nav in.
  if ($(window).scrollTop() > 100 ){
    $('.bg').addClass('show');
  } else {
    $('.bg').removeClass('show');
  };
});

$(document).ready(function(){
	// ===== Scroll to Top ==== 
	$(window).scroll(function() {
		if ($(this).scrollTop() >= 50) {        // If page is scrolled more than 50px
	        $('#toTop').fadeIn(200);    // Fade in the arrow
	    } else {
	        $('#toTop').fadeOut(200);   // Else fade out the arrow
	    }
	});
	$('#toTop').click(function() {      // When arrow is clicked
	    $('body,html').animate({
	        scrollTop : 0                       // Scroll to top of body
	    }, 500);
	});
	
	// create planet focus
	$("#btn-cp").click(function(){
        $("#planet_name").focus();
    });
    $(".createplanet-bottom").click(function(){
        $("#planet_name").focus();
    });
	// join planet focus
	$("#btn-jp").click(function(){
        $("#keyword").focus();
    });

	$('.autoplay').slick({
	    slidesToShow: 1,
	    slidesToScroll: 1,
	    autoplay: true,
	    autoplaySpeed: 3000,
	    infinite: true,
	    adaptiveHeight: false,
	    dots: true,
	    pauseOnHover: true,
	    pauseOnDotsHover: true
	});

	// Create Planet
	$('.my-planet-list').slick({
	    slidesToShow: 3,
	    slidesToScroll: 3,
	    autoplay: true,
	    autoplaySpeed: 3000,
	    infinite: true,
	    variableWidth: false,
	    adaptiveHeight: false,
	    dots: true,
	    pauseOnHover: true,
	    pauseOnDotsHover: true
	});
	slideIndex = 3;
	$('.btn_sign').on('click', function() {
		slideIndex++;
		$('.my-planet-list').slick('slickAdd','<li><a href="./myplanet.jsp"><div class="ch-item ch-img-1"><div class="ch-info"><h3>PLANET<br />'+slideIndex+'</h3></div></div></a></li>');
		//slideIndex++;
	});
	
	$('.js-remove-slide').on('click', function() {
		$('.my-planet-list').slick('slickRemove',slideIndex - 1);
		if (slideIndex !== 0){
			slideIndex--;
		}
	});

	$('.slick-prev').hide();
	$('.slick-next').hide();
});

// Search Planet Modal Open
$('.trigger').on('click', function() {
  $('.modal-wrapper').toggleClass('open');
  $('.page-wrapper').toggleClass('blur-it');
  return false;
});

// Tooltip
$('[data-toggle="tooltip"]').tooltip();

// 가입 완료 팝업 창
$('.timer').on('click', function () {
  swal({
    title: '가입을 축하합니다!',
    type: 'success',
    timer: 3000,
    showCloseButton: false,
    showCancelButton: false,
    showConfirmButton: false
    // onOpen: function() {
    //   swal.showLoading()
    // }
  })
}); 
</script>
</body>
</html>
<% 
	}
	}catch(Exception e){
		e.printStackTrace();
}
%>