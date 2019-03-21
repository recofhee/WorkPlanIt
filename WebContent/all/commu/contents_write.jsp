<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
String email = (String)session.getAttribute("email");
try{
		if(email==null || email.equals(""))
			response.sendRedirect("../index.jsp");
	   	else{
	
				int mem_num = (Integer)session.getAttribute("mem_num");
			
				int board_num = 0;
			
			
				LogonDBBean dbPro = LogonDBBean.getInstance(); 
				LogonDataBean member = dbPro.getMember(email);
			    
			    String name = member.getName();
			
				if(request.getParameter("board_num")!=null) {
				   board_num=Integer.parseInt(request.getParameter("board_num"));
				}	
%>

<!-- Main -->
<div id="main" class="single">
	<!-- Post -->
	<article class="post">
		<div class="row">
		  <h2>글작성</h2>
		 	<div class="col col-md-2"></div>
		    <div class="col col-md-8">
			  <form method="post" name="write" action="writePro.jsp" enctype="multipart/form-data">
			  		<input type="hidden" name="board_num" value="<%=board_num%>">
			  		<input type="hidden" name="mem_num" value="<%=mem_num%>">
			  		<input type="hidden" name="writer" value="<%=name%>">
			  		
					<div class="form-group required">
					    <label for="title" class="control-label">글제목</label>
					    <input type="text" name="board_title" class="form-control" style="background-color: rgba(255,255,255,0); ime-mode:active;">
				  	</div>
				  
					<div class="form-group required">
					    <label for="cate" class="control-label">카테고리</label>
					    <select name="board_cate_num" class="form-control" style="border-radius: 0px;">
					    	<option value="1">서류</option>
					    	<option value="2">필기</option>
					    	<option value="3">실기</option>
					    	<option value="4">면접</option>
					    </select>
					</div>

				  	<div class="form-group required">
				    	<label for="contents" class="control-label">글내용</label>
				    	<textarea name="board_contents" class="form-control" rows="7" style="border-radius: 0px; ime-mode:active;"></textarea>
				  	</div>
			
					<div class="form-group">
					    <label for="board_file">첨부파일</label>
					    <input type="file" name="board_file">
					</div>
				  
				    <ul class="media-date text-uppercase reviews list-inline" style="float: right;">
					    <li><button type="button" class="button" value="목록보기" OnClick="document.location.href='commu.jsp'">취소</button></li>
					    <li><button type="submit" class="button" value="작성완료">저장</button></li>
				  	</ul>
				  
				</form>
			</div>
		  	<div class="col col-md-2"></div>
		</div>
	</article>
</div>
<%
   	}
} catch(Exception e) {e.printStackTrace();} 
%>
