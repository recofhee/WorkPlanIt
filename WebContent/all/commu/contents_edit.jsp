<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>

<%
String email = (String)session.getAttribute("email");
try{
		if(email==null || email.equals(""))
			response.sendRedirect("../index.jsp");
	   	else{
				int num = Integer.parseInt(request.getParameter("num"));
				String pageNum = request.getParameter("pageNum");
				int mem_num = (Integer)session.getAttribute("mem_num");	
				
				BoardDBBean dbPro = BoardDBBean.getInstance(); 
		   	 	BoardDataBean article = dbPro.updateGetArticle(num);
		    	int dbmem_num = article.getMem_num();
		    	if(mem_num==dbmem_num){
%>

<!-- Main -->
<div id="main" class="single">
	<!-- Post -->
	<article class="post">
		<div class="row">
		  <h2>글수정</h2>
		 	<div class="col col-md-2"></div>
		    <div class="col col-md-8">
			  <form method="post" name="update" action="updatePro.jsp?pageNum=<%=pageNum%>" enctype="multipart/form-data">
					<%-- <input type="hidden" name="email" value="<%=dbemail%>"> --%>
					<input type="hidden" name="board_num" value="<%=article.getBoard_num()%>">
					<input type="hidden" name="mem_num" value="<%=article.getMem_num()%>">
			  		
					<div class="form-group required">
					    <label for="title" class="control-label">글제목</label>
					    <input type="text" name="board_title" class="form-control" value="<%=article.getBoard_title()%>" style="background-color: rgba(255,255,255,0); ime-mode:active;">
				  	</div>
				  
					<div class="form-group required">
					    <label for="cate" class="control-label">카테고리</label>
					    <select name="board_cate_num" class="form-control" style="border-radius: 0px;">
					    	<option value="1"<% Integer cate_num = article.getBoard_cate_num(); if(cate_num==1) out.print(" selected=\"selected\""); %>>서류</option>
					    	<option value="2"<% if(cate_num==2) out.print(" selected=\"selected\""); %>>필기</option>
					    	<option value="3"<% if(cate_num==3) out.print(" selected=\"selected\""); %>>실기</option>
					    	<option value="4"<% if(cate_num==4) out.print(" selected=\"selected\""); %>>면접</option>
					    </select>
					</div>

				  	<div class="form-group required">
				    	<label for="contents" class="control-label">글내용</label>
				    	<textarea name="board_contents" class="form-control" rows="7" style="border-radius: 0px; ime-mode:active;"><%=article.getBoard_contents()%></textarea>
				  	</div>
			
					<div class="form-group">
					    <label for="board_file">첨부파일</label>
					    <input type="file" class="form-control-file" name="board_file" value="<%=article.getBoard_file()%>">
					</div>
				  
				    <ul class="media-date text-uppercase reviews list-inline" style="float: right;">
					    <li><button type="button" class="button" value="목록보기" OnClick="history.go(-1)">취소</button></li>
					    <li><button type="submit" class="button" value="작성완료">저장</button></li>
				  	</ul>
				  
				</form>
			</div>
		  	<div class="col col-md-2"></div>
		</div>
	</article>
</div>
	
	<%
      } else {
	%>
		<script> 
			alert("작성자만 수정 가능합니다."); 
			location.href="commu.jsp?page=contents&num=<%=num%>&pageNum=<%=pageNum%>";
		</script>

<%
      }
   	}
} catch(Exception e) {e.printStackTrace();} 
%>

