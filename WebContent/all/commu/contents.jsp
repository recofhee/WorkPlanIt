<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
String email = (String)session.getAttribute("email");
try{
		if(email==null || email.equals(""))
			response.sendRedirect("../index.jsp");
	  	else{
				int num = Integer.parseInt(request.getParameter("num"));
				session.setAttribute("num", num);
				
				String pageNum = request.getParameter("pageNum");
			
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				
				int mem_num = (Integer)session.getAttribute("mem_num");	
				int re_num = 0;
		
		
				ReplyDBBean dbPro2 = ReplyDBBean.getInstance();
				int replycount = dbPro2.getReplyAllCount(num);
			
				LogonDBBean dbPro = LogonDBBean.getInstance(); 
				LogonDataBean member = dbPro.getMember(email);
				
				String name = member.getName();
				/* mem_num = member.getMem_num(); */
			
				BoardDBBean dbPro1 = BoardDBBean.getInstance(); 
			    BoardDataBean article = dbPro1.getArticle(num);
			    String filename = article.getBoard_file();
			    
			    int board_cate_num = article.getBoard_cate_num();
			    int board_num = article.getBoard_num();
			    String board_title = article.getBoard_title();
			    String board_cate_name = dbPro1.getMetaBoard(board_cate_num);
			    
			    int savecount = dbPro1.getSaveCount(board_num);
			    int save = dbPro1.getSave_num(board_num,mem_num);
%>
	<!-- Main -->
	<div id="main">
		<!-- Post -->
		<article class="post">
			<header>
			<div class="title">
				<h2><a href="#"><%=article.getBoard_title()%></a></h2>
				<p>
					<%=board_cate_name%>
				</p>
			</div>
			<div class="meta">
				<time class="published" datetime="2017-09-26"><%=sdf.format(article.getBoard_write_time())%></time>
				<a class="author"><span class="name"><%=article.getWriter()%></span><img src="images/pic11.jpg" alt=""/></a>
			</div>
			</header>
			
			<%if (article.getBoard_file()==null) {%>
			<ul class="nav navbar-nav navbar-right" style="margin-top: -30px;">
	            <li class="dropdown">
	                <a href="#" class="author" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-paperclip"></i> 첨부파일</a>
	                <ul class="dropdown-menu dropdown-file" role="menu">
		            	<li>
	                        <a>첨부된 파일이 없습니다.</a>	
		              	</li>
		          	</ul>
		        </li>
	        </ul>
	        <%} else { %>
	        <ul class="nav navbar-nav navbar-right" style="margin-top: -30px;">
	            <li class="dropdown">
	                <a href="#" class="author" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-paperclip"></i> 첨부파일</a>
	                <ul class="dropdown-menu dropdown-file" role="menu">
		            	<li>
	                        <a onClick="document.location.href='filedown.jsp?num=<%=article.getBoard_num()%>&pageNum=<%=pageNum%>&file=<%=filename%>'"><i class="fa fa-file-o"></i> <%=filename%></a>	
		              	</li>
		          	</ul>
		        </li>
	        </ul>
	        
	        <%} %>
			
			<br>
			<!-- <span class="image featured"><img src="images/pic02.jpg" alt=""/></span> -->
			<p>
				<%=article.getBoard_contents()%>
			</p>
			<footer>
				<ul class="stats">
					<!-- <li><a onClick="document.location.href='commu.jsp'">목록보기</a></li> -->
					<li><a onClick="document.location.href='commu.jsp?pageNum=<%=pageNum%>'">목록보기</a></li>
					<li><a class="icon fa-eye"><%=article.getReadcount()%></a></li>
					<li><a class="icon fa-comment"><%=replycount%></a></li>
					<li>
						<form id="save" action="contents_save.jsp" method="post">
							<input type="hidden" name="board_num" value="<%=board_num%>" />
							<input type="hidden" name="mem_num" value="<%=mem_num%>" />
							<input type="hidden" name="board_title" value="<%=board_title%>" />
							<input type="hidden" name="writer" value="<%=name%>" />
							<a class="icon fa-star" onClick="formSubmit(); return false;"><%=savecount%></a>
						</form>
					</li>
					<li><a class="icon fa-pencil-square-o" onClick="document.location.href='commu.jsp?page=contents_edit&num=<%=article.getBoard_num()%>&pageNum=<%=pageNum%>'">수정</a></li>
					<%-- <li><a class="icon fa-trash" onClick="document.location.href='commu.jsp?page=contents_delete&num=<%=article.getBoard_num()%>&pageNum=<%=pageNum%>'">삭제</a></li> --%>
					<li><a class="icon fa-trash" data-toggle="modal" data-target="#delete" style="color:#5e6b92;">삭제</a></li>
				</ul>
			</footer>
		</article>

		<article class="post">
			<div class="title">
				<form method="post" action="replyPro.jsp?pageNum=<%=pageNum%>">
					<input type="hidden" name="board_num" value="<%=board_num%>" />
					<input type="hidden" name="mem_num" value="<%=mem_num%>" />
					<input type="hidden" name="name" value="<%=name%>" />
				      
					<div class="row">
						<div class="col-sm-11">
							<input type="text" class="form-control" name="description" placeholder="댓글 작성" style="border-radius:0px; margin: 0 0 0 0;"/>
						</div>
						<div class="col-sm-1">
							<button type="submit" id="comment" class="form-control" style="border:none; box-shadow:none;">COMMENT</button>
						</div>
					</div>
				</form>	
				<jsp:include page="list_reply.jsp" flush="false"/>
			</div>
		</article>
	</div>
	
<!-- delete modal -->
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="voteLabel" aria-hidden="true" style="margin-top: 5%;">
  <div class="modal-dialog">
    <div class="panel panel-primary">
      
      <div class="panel-heading" style="background-color: #6A7499;">
        <h4 class="panel-title" id="voteLabel"><span class="glyphicon glyphicon-trash"></span> 삭제</h4>
      </div>
      <div class="modal-body text-center" style="padding: 20px;">
		<span>작성하신 게시물을 삭제하시겠습까?</span>
      </div>
      <div class="modal-footer">
      	<form method="post" name="delForm" action="contents_delete.jsp?pageNum=<%=pageNum%>&num=<%=article.getBoard_num()%>"> 
      		<%-- <input type="hidden" name="num" value="<%=num%>"> --%>
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

<script>
function formSubmit() {
	document.getElementById("save").submit();
}
</script>

<%
   	}
} catch(Exception e) {e.printStackTrace();} 
%>
