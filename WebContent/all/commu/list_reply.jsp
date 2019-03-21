<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.ReplyDBBean" %>
<%@ page import="all.action.ReplyDataBean" %>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
%>

<%
	String email = (String)session.getAttribute("email");
	try {
			if(email==null || email.equals(""))
				response.sendRedirect("../index.jsp");
		   	else{	
					int num = (Integer)session.getAttribute("num");
					int mem_num = (Integer)session.getAttribute("mem_num");
				    String pageNum = request.getParameter("pageNum");
				    
				    
				    if (pageNum == null) {
				        pageNum = "1";
				    }
				
				    int currentPage = Integer.parseInt(pageNum);
				    int startRow = (currentPage - 1) * pageSize + 1;
				    int endRow = currentPage * pageSize;
				    int count = 0;
				    int number = 0;
				    List<ReplyDataBean> replyList = null; 
				    
				    ReplyDBBean dbPro = ReplyDBBean.getInstance();
				    count = dbPro.getReplyAllCount(num);
				    
				    if (count > 0) {
				        replyList = dbPro.getReplys(startRow, pageSize, num);
				    }
				
					number = count-(currentPage-1)*pageSize;
%>

<% if (count == 0) { %>
	<p>작성된 댓글이 없습니다.</p>
<% } else {
	
   for (int i = 0 ; i < replyList.size() ; i++) {
	ReplyDataBean reply = replyList.get(i);
%>
	<ul class="comments-list">
	   <li class="comment">
	        <a class="pull-left" href="#">
	            <img class="avatar" src="images/pic08.jpg" alt="avatar">
	        </a>
	        <div class="comment-body">
	            <div class="comment-heading">
	                <h4 class="user"><%=reply.getName()%></h4>
	                <p class="time"><%=sdf.format(reply.getRe_write_time())%>&nbsp;
	                	<a data-toggle="modal" data-target="#update">수정</a>
	                	<a onClick="document.location.href='reply_delete.jsp?re_num=<%=reply.getRe_num()%>&num=<%=reply.getBoard_num()%>&pageNum=<%=pageNum%>'">삭제</a>
	                </p>
	            </div>
	            <p><%=reply.getDescription()%></p>
	        </div>
	    </li>
	</ul>
	
<%-- <%	}%> --%>
	<!-- update reply -->
	<div class="modal fade" id="update" tabindex="-1" role="dialog" aria-labelledby="voteLabel" aria-hidden="true" style="margin-top: 5%;">
	  <div class="modal-dialog">
	    <div class="panel panel-primary">
	    	<div class="modal-header">
		    	<h2 class="text-center">댓글 수정</h2>
		  	</div>
		    <div class="modal-body text-center" style="padding: 20px;">
				<form method="post" action="reply_update.jsp?re_num=<%=reply.getRe_num()%>&pageNum=<%=pageNum%>">
					<input class="hidden" name="mem_num" value="<%=mem_num%>">
					<input class="hidden" name="board_num" value="<%=reply.getBoard_num()%>">
					<input class="hidden" name="re_num" value="<%=reply.getRe_num()%>">
					<textarea name="description"><%=reply.getDescription()%></textarea>
					<br>
					<div class="actions">
						<button type="button" data-dismiss="modal" class="btn btn-circle btn-ef"><i class="fa fa-remove" style="font-size:14px;"></i></button>
						<button type="submit" class="btn btn-circle btn-ef"><i class="fa fa-save text-center" style="font-size:14px;"></i></button>
					</div>
				</form>
		    </div>
	    </div>
	  </div>
	</div>	
<%
			}
		}
   	}
} catch(Exception e) {e.printStackTrace();} 
%>