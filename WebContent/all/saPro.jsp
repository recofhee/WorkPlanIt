<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="all.action.PlanetDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy.MM.dd");
%>

<%
    String pageNum = request.getParameter("pageNum");

    if (pageNum == null) {
        pageNum = "1";
    }

    int planet_num = Integer.parseInt(request.getParameter("planet_num"));
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0, pcount = 0, newcount = 0;
    int number = 0;
    
    String keyword = request.getParameter("keyword");
    
    List<PlanetDataBean> articleList = null;
    List<PlanetDataBean> articleList2 = null;
    List<PlanetDataBean> newarticleList = null;
	
    
    PlanetDBBean dbPro = PlanetDBBean.getInstance();
    count = dbPro.getArticleCount();
    newcount = dbPro.getArticleCount();
    
    PlanetDataBean planetInfo = dbPro.getPlanet(planet_num);
    
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, pageSize, planet_num);
        articleList2 = dbPro.getKeywordArticles(startRow, pageSize, planet_num, keyword);
    }
    
    if (newcount > 0) {
        newarticleList = dbPro.getNewArticles(startRow, pageSize, planet_num);
    }

	number = count-(currentPage-1)*pageSize;
%>
<%
	String name = null;
	String email = (String)session.getAttribute("email");
	
	try {
		if(email==null || email.equals(""))
			response.sendRedirect("./index.jsp");
		else{
			
			int mem_num = (Integer)session.getAttribute("mem_num");
			
			/* PlanetDBBean dbPro2 = PlanetDBBean.getInstance(); 
			pcount = dbPro2.getPlanetCount(mem_num);
			
			List<PlanetDataBean> myplanetList = null;
			
			if (pcount > 0) {
		    	myplanetList = dbPro2.getMyPlanets(startRow, pageSize, mem_num);
		    } */
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://demo.itsolutionstuff.com/plugin/croppie.js"></script>
<!-- <link rel="stylesheet" href="http://demo.itsolutionstuff.com/plugin/croppie.css"> -->
<link href="./assets/css/pmain.css" rel="stylesheet">
<link href="./assets/css/mpstyle.css" rel="stylesheet">
<link href="./assets/slick-1.6.0/slick/slick.css" rel="stylesheet" type="text/css">
<link href="./assets/slick-1.6.0/slick/slick-theme.css" rel="stylesheet" type="text/css">
<link href="./assets/css/croppie.css" rel="stylesheet" type="text/css">
<!-- <link href="./assets/css/uploadprofile.css" rel="stylesheet" type="text/css"> -->
<!-- <link href="./assets/css/prism.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.9.0/sweetalert2.css" />
<link href="./assets/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<link href="./assets/css/iEdit.css" rel="stylesheet" type="text/css">
<link href="./assets/css/editprofile.css" rel="stylesheet" type="text/css">
<script src="./assets/js/modernizr.js"></script> <!-- Modernizr -->

<!-- <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-42119746-3', 'auto');
  ga('send', 'pageview');
</script> -->
<!-- <script>
$(document).ready(function(){
  $("#closead").click(function() {
        $("#ads").css("display","none");
  });
  
  $frameheight = $(window).height() - 40;
  $(".sourceView").css("height",$frameheight);
  
  $(window).resize(function() {
    $frameheight = $(window).height() - 40 ;
    $(".sourceView").css("height",$frameheight);
  });
  
});
</script> -->

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
      <a class="navbar-brand" href="planet.jsp">WORK PLAN IT</a>
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
  <div id="primary" class="content-area">
    <main id="main" class="site-main" role="main">
      <!-- <a href="#" class="btn btn-default" id="chgColor">Change Color</a> -->

      <div class="row mpmarginbottom">
        <div class="col-sm-6">
          <h2 class="myplanet-header"><%=planetInfo.getPlanet_name()%></h2>
        </div>
        <div class="col-sm-6">
          <a href="writearticle.jsp?planet_num=<%=planet_num%>" class="btn btn-write"><i class="fa fa-pencil" aria-hidden="true"></i></a>
          <br /><br />
          <div id="sb-search" class="sb-search">
            <form method="get" class="form-inline" name="saform" action="saPro.jsp">
              <input class="sb-search-input" placeholder="검색어를 입력하세요." type="text" value="" name="keyword" id="keyword" required>
              <input type="hidden" name="planet_num" value="<%=planetInfo.getPlanet_num()%>">
	          <input type="hidden" name="mem_num" value="<%=planetInfo.getMem_num()%>">
              <input class="sb-search-submit" type="submit" value="">
              <span class="sb-icon-search"><i class="fa fa-search" aria-hidden="true"></i></span>
            </form>
          </div><!-- #search -->
        </div>
      </div>
		<% if (count == 0) { %>
       	<div class="alert alert-danger" role="alert">게시판에 저장된 글이 없습니다.</div>
		<% } else {
			for (int i = 0 ; i < articleList2.size() ; i++) {
				PlanetDataBean article = articleList2.get(i);
		%>
		<article id="post" class="post type-post status-publishhentry">
	  	
          <div class="entry-meta">
            <span class="posted-on">
            	<i class="fa fa-calendar-o spaceRight" aria-hidden="true"></i>
            	<time class="entry-date published updated" datetime="2016-08-02T06:09:19+00:00">
            	<%=sdf.format(article.getPlanet_write_time())%>
            	</time>
           	</span>
           	<span class="comments-link">
            	<i class="fa fa-user spaceLeftRight" aria-hidden="true"></i>
            	<span><%=article.getWriter()%></span>
           	</span>    
          </div><!-- .entry-meta -->

			<h2 class="entry-title">
	          	<a href="myplanetarticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=currentPage%>">
					<%=article.getPlanet_title()%>
				</a>
			</h2>
        </header><!-- .entry-header -->

        <footer class="entry-footer">
          <span class="read-more"><a href="myplanetarticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=currentPage%>">Read More<i class="fa spaceLeft fa-caret-right"></i></a>
          </span>
        </footer><!-- .entry-footer -->
        
      </article><!-- #post-## -->
      <%}
      }%>
      

      <nav class="navigation pagination" role="navigation" style="display: block;">
        <div class="nav-links">
          <%
            if (count > 0) {
                int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	            int startPage =1;
	            
	            if(currentPage % 10 != 0)
	                   startPage = (int)(currentPage/10)*10 + 1;
	            else
	                   startPage = ((int)(currentPage/10)-1)*10 + 1;
	
	            int pageBlock = 10;
	            int endPage = startPage + pageBlock - 1;
	            if (endPage > pageCount) endPage = pageCount;
	            
	            if (startPage > 10) {
          %>
            <a class="prev page-numbers" href="myplanet.jsp?pageNum=<%= startPage - 10 %>"><i class="fa fa-angle-double-left spaceRight"></i>Previous</a>
          <%
            }
            for (int i = startPage ; i <= endPage ; i++) {
          %>
              <a class="page-numbers" href="myplanet.jsp?pageNum=<%= i %>"><%= i %></a>
          <%
              }
              if (endPage < pageCount) {
          %>
                <a class="next page-numbers" href="myplanet.jsp?pageNum=<%= startPage + 10 %>">Next<i class="fa fa-angle-double-right spaceLeft"></i></a>
          <%
              }
            }
          %>
        </div>
      </nav>
    </main><!-- #main -->
  </div><!-- #primary -->

  <aside id="secondary" class="widget-area" role="complementary">
    <section id="calendar-2" class="widget widget_calendar">
      <div class="widget-title">
        <h3>My Planet</h3>
      </div>
      <div id="calendar_wrap" class="calendar_wrap">
        <div class="vira-card">
          <div class="vira-card-header">
            <div class="card-img" id="upload-demo-i">
              <!-- <span class="fa fa-users" aria-hidden="true"></span> -->
              <img src="assets/img/pic08.png" class="img-circle img-responsive">
            </div>
          </div>
          <div class="vira-card-content">
            <h3><%=planetInfo.getPlanet_name()%></h3>
          </div>
        </div>
        <button id="myBtn1" class="btn btn-edit btn-block"><i class="fa fa-cog" aria-hidden="true"></i></button>
      </div>
    </section>
    
    <!-- Modal1 -->
    <div class="modal fade" id="myModal1" role="dialog">
      <div class="modal-dialog">
      
        <!-- Modal content-->
        <div class="modal-content" style="margin-top: 60px;"">
          <div class="modal-header" style="padding:35px 50px; background-color: #5e6b92;">
            
            <button type="button" class="close" data-dismiss="modal"><div align="right">&times;</div></button>

            <h4 align="center" style="color: #f7f7f7; background-color: #5e6b92;"><i class="fa fa-cog" aria-hidden="true"></i></h4>
          </div>
          <div class="modal-body" style="padding:40px 50px;">

              <form method="post" name="editPlanet" action="editPlanetPro.jsp?plnaet_num=<%=planetInfo.getPlanet_num()%>" id="editPlanetForm">
	            <input type="hidden" name="planet_num" value="<%=planetInfo.getPlanet_num()%>">
	            <input type="hidden" name="mem_num" value="<%=planetInfo.getMem_num()%>">
                <div class="col-sm-12">
                  <label for="upload" style="width: 50%; margin: 0 auto 10px;">Upload</label>
                  <input type="file" id="upload">
                  <div id="upload-demo" class="croppie-container"></div>
                </div>

                <div class="col-sm-12" style="margin-bottom: 40px;">
                
                  	<div class="edit-profile-page">
	                    <div class="profile-panel">
	                      <!-- <div class="edit-container"> -->
	                        <!-- <div class="btn editBtn" onclick="editProfile()">Edit</div> -->
	                      <!-- </div> -->
	                      <div class="first-name-label">PLANET NAME</div>
	                      <div class="first-name"><input type="text" name="planet_name" value="<%=planetInfo.getPlanet_name()%>" style="width: 100%;"></div>
	                      <div class="profile-title-label">PROFILE</div>
	                      <div class="profile-title"><input type="text" name="planet_profile" value="<%=planetInfo.getPlanet_profile()%>" style="width: 100%;"></div>
	                    </div>
                  	</div>
                  
                </div>

              <button id="txt4" type="submit" class="btn btn-modal btn-block upload-result"><span class="glyphicon glyphicon-ok"></span></button>
            </form>
        </div>
      </div>
    </div>
    </div>
    <!-- <section id="categories-2" class="widget widget_categories">
      <div class="widget-title">
        <h3>Categories</h3>
      </div>    
      <ul>
        <li class="cat-item cat-item-6"><a href="https://planetarium.com/?cat=6">Category 1</a> (4)</li>
        <li class="cat-item cat-item-2"><a href="https://planetarium.com/?cat=2">Category 2</a> (6)</li>
        <li class="cat-item cat-item-10"><a href="https://planetarium.com/?cat=10">Category 3</a> (3)</li>
        <li class="cat-item cat-item-1"><a href="https://planetarium.com/?cat=1">Category 4</a> (3)</li>
      </ul>
    </section> --> 
    <section id="recent-posts-2" class="widget widget_recent_entries">    
		<div class="widget-title">
		  <h3>최신 글</h3>
		</div>    
		<ul>
   		<% if (newcount == 0) { %>
       	<li>
          <a>최신 글이 없습니다.</a>
        </li>
		<% } else {
			for (int i = 0 ; i < newarticleList.size() ; i++) {
				PlanetDataBean article = newarticleList.get(i);
		%>
        <li>
          <a href="myplanetarticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=currentPage%>"><%=article.getPlanet_title()%></a>
        </li>
      
      <%}
      }%>
      </ul>
    </section>    
    <!-- <section id="recent-comments-2" class="widget widget_recent_comments">
      <div class="widget-title">
        <h3>최근 댓글</h3>
      </div>
      <ul id="recentcomments">
        <li class="recentcomments"><span class="comment-author-link">Sarah</span> on <a href="https://planetarium.com/?p=25#comment-10">Welcome to Fora Free WordPress Theme</a></li>
        <li class="recentcomments"><span class="comment-author-link">Sarah</span> on <a href="https://planetarium.com/?p=21#comment-9">Vestibulum ante ipsum primis in faucibus orci luctus</a></li>
        <li class="recentcomments"><span class="comment-author-link">Sarah</span> on <a href="https://planetarium.com/?p=29#comment-8">Nulla lacinia consequat metus vitae porttitor. In hac habitasse platea dictumst. Cras vel ullamcorper tellus, et tempus orci.</a></li>
      </ul>
    </section> -->
  </aside><!-- #secondary -->

</div>

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

<script src="//www.google-analytics.com/analytics.js"></script>
<script src="./assets/js/pmain.js"></script> <!-- Resource jQuery -->
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="./assets/slick-1.6.0/slick/slick.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.9.0/sweetalert2.js"></script>
<script src="./assets/js/uisearch.js"></script>
<script src="./assets/js/classie.js"></script>
<script src="./assets/js/exif.js"></script>
<script src="./assets/js/iEdit.js" type="text/javascript"></script>
<script src="./assets/js/script.js" type="text/javascript"></script>
<script src="./assets/js/editprofile.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>

<script>
  // Search
  new UISearch(document.getElementById('sb-search'));
</script>
<!-- <script>
    $(function() {
        $('#chgColor').colorpicker().on('changeColor', function(e) {
            // $('body')[0].style.backgroundColor = e.color.toString('rgba');
            $('nav')[0].style.backgroundColor = e.color.toString('rgba');
        });
    });
</script> -->

<!-- <script>
  !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
</script> -->

<!-- <script>
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-9788881-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script> -->

<!-- <script>
  (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
  function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
  e=o.createElement(i);r=o.getElementsByTagName(i)[0];
  e.src='//www.google-analytics.com/analytics.js';
  r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
  ga('create','UA-2398527-4');ga('send','pageview');
</script> -->

</body>
</html>
<% 
	}
	}catch(Exception e){
		e.printStackTrace();
}
%>