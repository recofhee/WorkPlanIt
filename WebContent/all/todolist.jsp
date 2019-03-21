<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="all.action.LogonDBBean"%>
<%@ page import="all.action.LogonDataBean"%>
<%@ page import="all.action.TodoDBBean"%>
<%@ page import="all.action.TodoDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>



<%
int mem_num = (Integer)session.getAttribute("mem_num");

%>

<form method="post" action="todoPro.jsp">
<div id="todo" class="bg-grey" style="height: 550px;">
<div id="myDIV" class="header">
	<h2 style="margin: 5px">To Do List</h2>
<br>
	<input class="hidden" name="mem_num" value="<%=mem_num%>">
	
	<input type="text" id="myInput" name="todo_text" placeholder="You can check your to do list">
	<button type="submit" class="addBtn">Add</button>
</div>

	<%
 List<TodoDataBean> TodoList = null;
 int DelList = 0; 
TodoDBBean dbPro = TodoDBBean.getInstance();
TodoList = dbPro.getTodos(mem_num);
%>

<ul id="toDo" class="list-unstyled" style="height: 378px; overflow-x: hidden; overflow-y: scroll;">

<% if (TodoList == null) { %>
	할 일이 없습니다.
<% } else {

for (int i = 0 ; i < TodoList.size() ; i++) {
TodoDataBean todo = TodoList.get(i);
%>
<li name="toDoLi"><%=todo.getTodo_text() %></li>
<%}}%></ul>
</div>
</form>

<script>
//Create a "close" button and append it to each list item
var myNodelist = document.getElementsByName("toDoLi");
var i;
for (i = 0; i < myNodelist.length; i++) {
  var span = document.createElement("SPAN");
  var txt = document.createTextNode("\u00D7");
  span.className = "close";
  span.appendChild(txt);
  myNodelist[i].appendChild(span);
}

// Click on a close button to hide the current list item
var close = document.getElementsByClassName("close");
var i;
for (i = 0; i < close.length; i++) {
  close[i].onclick = function() {
    var div = this.parentElement;
    div.style.display = "none";
    <%-- <%
    int index = todo.getTodo_index();
    DelList = dbPro.deleteTodo(index);
    %> --%>
    
    
  }
}
//여기가 투두 체크하는거 !!
//Add a "checked" symbol when clicking on a list item
var list = document.querySelector('#toDo');
list.addEventListener('click', function(ev) {
  if (ev.target.tagName === 'LI') {
    ev.target.classList.toggle('checked');
  }
}, false);
</script>


















