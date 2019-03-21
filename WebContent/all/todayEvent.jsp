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
	 List<TodayDataBean> todayList1 = null;
	 int DelList = 0; 
	TodayDBBean dbPro2 = TodayDBBean.getInstance();
	todayList1 = dbPro2.getTodays(mem_num);
	
	
	 if (todayList1 == null) { %>
	오늘은 일정이 없습니다
<% } else {	
	for (int i = 0 ; i < todayList1.size() ; i++) {
	TodayDataBean today1 = todayList1.get(i);
	%>
	<li style="list-style-type: none;"><span class="glyphicon glyphicon-stop" aria-hidden="true"></span><h7 class="list-group-item-heading"><%=today1.getTitle() %></h7></li>
	<%}}%>




















