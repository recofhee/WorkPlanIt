<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="all.action.LogonDBBean"%>
<%@ page import="all.action.LogonDataBean"%>
<%@ page import="all.action.BoardDBBean"%>
<%@ page import="all.action.BoardDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
int mem_num = (Integer)session.getAttribute("mem_num");

%>




<%
List<BoardDataBean> articleList=null;
	 
	 int DelList = 0; 
	BoardDBBean dbPro2 = BoardDBBean.getInstance();
	articleList = dbPro2.getBestMain();
	
	
	 if (articleList == null) { %>
	최근채용일정이 없습니다.
<% } else {	
	for (int i = 0 ; i < articleList.size() ; i++) {
	BoardDataBean bestC = articleList.get(i);
		if (i==1){
	%>
		<div class="item active">
		
                <a href="./commu/commu.jsp?page=contents&num=<%=bestC.getBoard_num() %>" style="text-decoration: none"><h1 style="color: #eee;"><%=bestC.getBoard_title() %></h1>
                <h4 style="color: #ccc;">글쓴이 : <%=bestC.getWriter() %>  |  조회수 : <%=bestC.getReadcount() %></h4>
                </a>
                <br><br>
                </div>

	
	<%} else {%>
		
		<div class="item">
        
                <a href="./commu/commu.jsp?page=contents&num=<%=bestC.getBoard_num() %>" style="text-decoration: none"><h1 style="color: #eee;"><%=bestC.getBoard_title() %></h1>
                <h4 style="color: #ccc;">글쓴이 : <%=bestC.getWriter() %>  |  조회수 : <%=bestC.getReadcount() %></h4>
                </a><br><br>
                
        </div>
	<%}}}%>






















