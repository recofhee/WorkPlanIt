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
	//int planet_num = Integer.parseInt(request.getParameter("planet_num"));

	int num = Integer.parseInt(request.getParameter("num"));
	session.setAttribute("num", num);
	
	String pageNum = request.getParameter("pageNum");
	String email = (String)session.getAttribute("email");

    if (pageNum == null) {
        pageNum = "1";
    }
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0, pcount = 0, newcount = 0;
    int number = 0;
    
    List<PlanetDataBean> newarticleList = null;
    PlanetDBBean dbPro3 = PlanetDBBean.getInstance();
    newcount = dbPro3.getArticleCount();
    
    /* PlanetDataBean planetInfo = dbPro3.getPlanet(planet_num);

    if (newcount > 0) {
        newarticleList = dbPro3.getNewArticles(startRow, pageSize, planet_num);
    } */

	number = count-(currentPage-1)*pageSize;

	int mem_num = (Integer)session.getAttribute("mem_num");
	int planet_cont_num = 0;
	String name = null;
	
	int re_num = 0;
	
	try{
		if(email==null || email.equals(""))
			response.sendRedirect("./index.jsp");
		else{
			/* int planet_num = (Integer)session.getAttribute("planet_num"); */
			
			LogonDBBean dbPro = LogonDBBean.getInstance(); 
			LogonDataBean member = dbPro.getMember(email);
			
			name = member.getName();
			/* mem_num = member.getMem_num(); */
		
			PlanetDBBean dbPro2 = PlanetDBBean.getInstance(); 
			PlanetDataBean article =  dbPro2.getArticle(num);
		    
			int ref=article.getRef();
			int re_step=article.getRe_step();
			int re_level=article.getRe_level();
			planet_cont_num = article.getPlanet_cont_num();
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
      <a class="navbar-brand" href="./main.jsp">WORK PLAN IT</a>
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
      <article id="post-19" class="post-19 post type-post status-publish format-standard has-post-thumbnail hentry">
        <header class="entry-header">
          <!-- <span class="cat-links"><a href="https://planetarium.com/?cat=2" rel="category">Category 1</a> <a href="https://planetarium.com/?cat=10" rel="category">Category 2</a></span> -->
          <h1 class="entry-title"><%=article.getPlanet_title()%></h1>    
          <div class="entry-meta">
            <span class="posted-on"><i class="fa fa-calendar-o spaceRight" aria-hidden="true"></i><a href="https://planetarium.com/?p=19" rel="bookmark"><time class="entry-date published updated"><%= sdf.format(article.getPlanet_write_time())%></time></a></span>
            <span class="comments-link"><i class="fa fa-user spaceLeftRight" aria-hidden="true"></i><span><%=article.getWriter()%></span></span>    
          </div><!-- .entry-meta -->
        </header><!-- .entry-header -->

        <div class="entry-content">
          <!-- <div class="entry-featuredImg">
            <img width="800" height="472" src="https://static.pexels.com/photos/572897/pexels-photo-572897.jpeg" class="attachment-fora-standard size-fora-standard wp-post-image" alt="" sizes="(max-width: 800px) 100vw, 800px">
          </div> -->
          <p><%=article.getPlanet_contents()%></p>
        </div><!-- .entry-content -->
      </article><!-- #post-## -->

      <div class="sepHentry">
        <i class="fa fa-circle-thin" aria-hidden="true"></i>
      </div>

      <!-- <nav class="navigation post-navigation" role="navigation">
        <h2 class="screen-reader-text">Post navigation</h2>
        <div class="nav-links">
          <div class="nav-previous">
            <a href="https://planetarium.com/?p=17" rel="prev"><span class="meta-nav" aria-hidden="true"><i class="fa fa-lg fa-angle-double-left spaceRight"></i>Previous Post</span> <span class="screen-reader-text">Previous post:</span> <span class="post-title">Curabitur nunc felis, mollis a sem eget, finibus gravida odio</span></a>
          </div>
          <div class="nav-next">
            <a href="https://planetarium.com/?p=21" rel="next"><span class="meta-nav" aria-hidden="true">Next Post<i class="fa fa-lg fa-angle-double-right spaceLeft"></i></span> <span class="screen-reader-text">Next post:</span> <span class="post-title">Vestibulum ante ipsum primis in faucibus orci luctus</span></a>
          </div>
        </div>
      </nav> -->
      <div class="text-center">
        <input type="button" class="btn btn-primary" value="수정" onclick="document.location.href='updatearticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=pageNum%>'">
       &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" class="btn btn-danger" value="삭제" data-toggle="modal" data-target="#delete">
       &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" class="btn btn-default" value="목록" onclick="document.location.href='myplanet.jsp?planet_num=<%=article.getPlanet_num()%>'">
      </div>

    </main><!-- #main -->
  </div><!-- #primary -->


  <aside id="secondary" class="widget-area" role="complementary">
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
    <%-- <section id="recent-posts-2" class="widget widget_recent_entries">    
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
				PlanetDataBean article2 = newarticleList.get(i);
		%>
        <li>
          <a href="myplanetarticle.jsp?num=<%=article2.getPlanet_cont_num()%>&pageNum=<%=currentPage%>"><%=article2.getPlanet_title()%></a>
        </li>
      
      <%}
      }%>
      </ul>
    </section> --%>    
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

    <div>
      <a href="writearticle.jsp?planet_num=<%=article.getPlanet_num()%>" class="btn btn-write"><i class="fa fa-pencil" aria-hidden="true"></i></a>
      <br><br>
      <div id="sb-search" class="sb-search">
        <form method="get" class="form-inline" name="saform" action="saPro.jsp?plnaet_num=<%=article.getPlanet_num()%>">
			<input class="sb-search-input" placeholder="검색어를 입력하세요." type="text" value="" name="keyword" id="keyword" required>
			<input type="hidden" name="planet_num" value="<%=article.getPlanet_num()%>">
			<input type="hidden" name="mem_num" value="<%=article.getMem_num()%>">
			<input class="sb-search-submit" type="submit" value="">
			<span class="sb-icon-search"><i class="fa fa-search" aria-hidden="true"></i></span>
        </form>
      </div><!-- #search -->
    </div>

    <!-- <div id="sb-search" class="sb-search">
      <form>
        <input class="sb-search-input" placeholder="검색어를 입력하세요." type="text" value="" name="search" id="search">
        <input class="sb-search-submit" type="submit" value="">
        <span class="sb-icon-search"><i class="fa fa-search" aria-hidden="true"></i></span>
      </form>
    </div> --><!-- #search -->
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

<a href="#top" id="toTop" class="visible"><i class="fa fa-angle-up fa-lg"></i></a>

<!-- delete modal -->
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="voteLabel" aria-hidden="true" style="margin-top: 5%;">
  <div class="modal-dialog">
    <div class="panel panel-primary">
      
      <div class="panel-heading" style="background-color: #6A7499;">
        <h4 class="panel-title" id="voteLabel"><span class="glyphicon glyphicon-trash"></span> 삭제</h4>
      </div>
      <div class="modal-body text-center" style="padding: 20px;">
		<span>작성하신 게시물을 삭제하시겠습니까?</span>
      </div>
      <div class="modal-footer">
      	<form method="post" name="delForm" action="deletearticle.jsp?num=<%=article.getPlanet_cont_num()%>&pageNum=<%=pageNum%>">
      		<input type="hidden" name="planet_num" value="<%=article.getPlanet_num()%>">
      		<input type="hidden" name="num" value="<%=num%>">
	      	<div class="actions">
	          	<a class="btn btn-circle btn-ef" data-dismiss="modal">
	              <i class="glyphicon glyphicon-remove"></i>
	            </a>
	            <button type="submit" class="btn btn-circle btn-ef"><i class="glyphicon glyphicon-trash"></i></button>
	        </div>
        </form>
	  </div>
	  
    </div>
  </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./assets/js/pmain.js"></script> <!-- Resource jQuery -->
<script src="./assets/js/uisearch.js"></script>
<script src="./assets/js/classie.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="./assets/slick-1.6.0/slick/slick.min.js"></script>

<script>
  // Search
  new UISearch(document.getElementById('sb-search'));
</script>

</body>
</html>
<%}
  }catch(Exception e){} 
%>