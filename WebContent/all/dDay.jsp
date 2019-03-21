<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="all.action.LogonDBBean"%>
<%@ page import="all.action.LogonDataBean"%>
<%@ page import="all.action.TodayDBBean"%>
<%@ page import="all.action.TodayDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
int mem_num = (Integer)session.getAttribute("mem_num");

%>




<%
	 List<TodayDataBean> DdayList1 = null;
	 int DelList = 0; 
	TodayDBBean dbPro2 = TodayDBBean.getInstance();
	DdayList1 = dbPro2.getDdays(mem_num);
	
	
	 if (DdayList1 == null) { %>
	최근채용일정이 없습니다.
<% } else {	
	for (int i = 0 ; i < DdayList1.size() ; i++) {
	TodayDataBean today1 = DdayList1.get(i);
	%>
		
	<h1 style="color: #f9992f; font-weight: bold;">D-<%=today1.getDday() %></h1>
					<%=today1.getTitle() %> 
	<%}}%>




















