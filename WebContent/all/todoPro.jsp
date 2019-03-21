<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.TodoDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="todo" scope="page" class="all.action.TodoDataBean">
   <jsp:setProperty name="todo" property="*"/>
</jsp:useBean>
 
<%
	//int num=todo.getTodo_index();

	todo.setTodo_writetime(new Timestamp(System.currentTimeMillis()));

    TodoDBBean dbPro = TodoDBBean.getInstance();
    dbPro.insertTodo(todo); 

   	response.sendRedirect("main.jsp");
%>
<%-- <input value=<%=todo.getTodo_text() %> >
<input value=<%=todo.getMem_num() %> > --%>