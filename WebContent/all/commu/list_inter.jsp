<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="all.action.ReplyDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*"%>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
    SimpleDateFormat sdf_news = new SimpleDateFormat("hh:mm (yyyy.MM.dd)");
%>

<%
	String pageNum = request.getParameter("pageNum");
	String email = (String)session.getAttribute("email");
	try{
			if(email==null || email.equals(""))
				response.sendRedirect("../index.jsp");
   			else{
					int mem_num = (Integer)session.getAttribute("mem_num");
					
				  	if (pageNum == null) {
				        pageNum = "1";
				    }
				  		
				    int currentPage = Integer.parseInt(pageNum);
				    String currentPageString = Integer.toString(currentPage);
				    int startRow = (currentPage - 1) * pageSize + 1;
				    int endRow = currentPage * pageSize;
				    int count = 0;
				    int number = 0;
				    List<BoardDataBean> articleList = null; 
				    List<BoardDataBean> bestList = null; 
				    List<ReplyDataBean> newsList = null; 
				    
				    BoardDBBean dbPro = BoardDBBean.getInstance();
				    count = dbPro.getCate_ArticleCount(4);
				    
				    ReplyDBBean dbPro2 = ReplyDBBean.getInstance();
				    
				    if (count > 0) {
				        articleList = dbPro.getCate_Articles(startRow, pageSize, 4);
				        bestList = dbPro.getBest_Articles(startRow, pageSize);
				        newsList = dbPro2.getNews(startRow, pageSize, mem_num);
				    }
				
					number = count-(currentPage-1)*pageSize;
					
					LogonDBBean dbPro1 = LogonDBBean.getInstance(); 
					LogonDataBean member = dbPro1.getMember(email);
				
					String name = member.getName();
				
				
%>

<div id="main">
	<!-- Best -->
	<article class="post">
		<header>
			<div class="title" style="padding: 1.5em 2em 1.5em 2em;">
				<h2>BEST</h2>
			</div>
		</header>
		
		<div class="row" style="margin-top:-3%;">
			<section class="regular slider">
				<%  
				   for (int i = 0 ; i < 3 ; i++) {
				       BoardDataBean best_article = bestList.get(i);
				%>
			    <div onClick="select(1, 'url')">
			    	<p><h1><%=i+1%>위</h1><%=best_article.getBoard_title()%></p>
			    </div>
			    <%} %>
	  		</section>
		</div>
	</article>
		
	<% if (count == 0) { %>

	<div class="text-center">게시판에 저장된 글이 없습니다.<br><a href="commu.jsp?page=contents_write">글쓰기</a></div>

	<% } else {%>

	<!-- Post -->
	<article class="post">
		
		<div class="title row" style="padding: 0.2%; margin-bottom: 4%;">
			<div class="btn-group" style="padding-left: 0px; margin-left: 0px;">
	          <!-- <button type="button" class=" dropdown-toggle" data-toggle="dropdown" style="font-size: 0.8em; padding-left: 10%;">
	            최신순 <span class="caret"></span>
	          </button>
	          <ul class="dropdown-menu" role="menu">
	            <li><a href="#">최신순</a></li>
	            <li><a href="#">조회순</a></li>
	            <li><a href="#">관심순</a></li>
	          </ul> -->
	          <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="border-radius: 0%; border: 0em; margin-top: -10px; font-size: 0.8em;">
			    최신순
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
			    <li><a href="#">최신순</a></li>
			    <li><a href="#">조회순</a></li>
			    <li><a href="#">관심순</a></li>
			  </ul>
	        </div>
			
			<section style="float: right;">
				<form class="search" method="get" action="list_search.jsp">
					<input type="text" name="keyword" placeholder="검색어 입력" style="ime-mode:active;"/>
					<!-- <button type="submit">SEARCH</button> -->
				</form>
			</section>
		</div>
		
		<div style="height: 1%;"></div>
		
		<%  
		   for (int i = 0 ; i < articleList.size() ; i++) {
		       BoardDataBean article = articleList.get(i);
		%>
		<div class="title row"> <!-- 여기가 반복 -->
			<p style="font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 200px;"><a href="commu.jsp?page=contents&num=<%=article.getBoard_num()%>&pageNum=<%=currentPage%>"><%=article.getBoard_title()%></a></p>
			<ul class="stats" style="float: right;">
				<li><%=article.getWriter()%></li>
				<li><%=sdf.format(article.getBoard_write_time())%></li>
				<li><a href="#" class="icon fa-eye"><%=article.getReadcount()%></a></li>
				<li><a href="#" class="icon fa-comment"><%=dbPro2.getReplyAllCount(article.getBoard_num())%></a></li>
			</ul>
		</div>
		<%}%>
		
		<hr style="margin-bottom: 10px;">

		<a href="commu.jsp?page=contents_write" class="button" style="float: right; padding-right: 0px; padding-bottom: 5%; font-size: 12px; ">글쓰기</a>
		
		<br><br>
	
	</article>
		
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
	%>

	<!-- Pagination -->
	<ul class="actions pagination">
		<% 
			if (startPage > 10) { 
		%>
		<li><a href="commu.jsp?pageNum=<%=startPage - 10 %>" class="btn previous" style="color: #A0A0A0; border-radius: 0%;"></a></li>
		<%      
			} 
			if (currentPage > startPage) { 
		%>
		<li><a href="commu.jsp?pageNum=<%= currentPage - 1 %>" class="btn previous" style="color: #A0A0A0; border-radius: 0%;"></a></li>
		<% 
			} else {
				currentPage = startPage;
			}
	        for (int i = startPage ; i <= endPage ; i++) {   	
		%>  
		<li class="<%if(pageNum.equals("currentPageString")) out.print("active");%>"><a href="commu.jsp?pageNum=<%=i %>" style="color: #A0A0A0; background-color: rgba(255,255,255,0.2); border: 0em; font-size: 14px;"><%=i %></a></li>
		<%      
			}       
	        if (currentPage < endPage) { 
		%>
		<li><a href="commu.jsp?pageNum=<%=currentPage + 1 %>" class="btn next" style="color: #A0A0A0; border-radius: 0%;"></a></li>
		<%		
			} else {
				currentPage = endPage;	
			}	
	        if (endPage < pageCount) {  
		%>
		<li><a href="commu.jsp?pageNum=<%=startPage + 10 %>" class="btn next" style="color: #A0A0A0; border-radius: 0%;"></a></li>
		<%
			}
	    }
	}
	%>
	</ul>
</div>	
	
<!-- Sidebar -->
<section id="sidebar">

	<!-- Intro -->
	<section id="intro">
		<header>
			<h2>COMMUNITY</h2>
			<p>면접</p>
		</header>
	</section>
	<!-- Mini Posts -->
	<section>
	<div class="mini-posts">
		<!-- Mini Post -->
		<article class="mini-post">
			<header>
				<h3><%=name%></h3>
				
				<div class="row" style="padding-left: 2%; padding-top: 10px;">
					<a class="btn published"><i class="icon fa fa-file-text"></i> 작성글</a>
					<a class="btn published"><i class="icon fa fa-star"></i> 관심글</a>
					<a class="btn published" data-toggle="modal" data-target="#myModal"><i class="icon fa fa-cog"></i> 설정</a>
				</div>
			</header>
			<!-- <a class="image"><img src="images/pic05.jpg" alt=""/></a> -->
			<div id="upload-demo-i" class="image" style="height: 170px; background-image: url('images/pic05.jpg');"></div>
		</article>
		
	</div>
	</section>

	<!-- Posts List -->
	<section>
		<h3>활동소식</h3>
		<ul class="posts">
			<%  
			   for (int i = 0 ; i < newsList.size() ; i++) {
			       ReplyDataBean news = newsList.get(i);
			%>
			<li>
				<article>
					<header>
						<h3><a onClick="document.location.href='commu.jsp?page=contents&num=<%=news.getBoard_num()%>&pageNum=<%=pageNum%>'">새 댓글이 달렸습니다.</a></h3>
						<p><%=sdf_news.format(news.getRe_write_time())%></p>
					</header>
				</article>
			</li>
			<%} %>
		</ul>
	</section>
</section>
<%
   	}
} catch(Exception e) {e.printStackTrace();} 
%>