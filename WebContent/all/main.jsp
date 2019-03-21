<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="all.action.LogonDBBean"%>
<%@ page import="all.action.LogonDataBean"%>
<%@ page import="all.action.TodoDBBean"%>
<%@ page import="all.action.TodoDataBean"%>
<%@ page import="all.action.TodayDBBean"%>
<%@ page import="all.action.TodayDataBean"%>
<%@ page import="all.action.BoardDBBean"%>
<%@ page import="all.action.BoardDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!-- 오늘의 날짜 구하기 -->
<%!
public static String getdate(int mountdate)
{
   //mountdate = 해당 숫자만큼 더해진 날짜를 반환
   DecimalFormat df = new DecimalFormat("00");
   Calendar calendar = Calendar.getInstance();
 
   calendar.add(calendar.DATE, mountdate);
   String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
   String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다
   String day = df.format(calendar.get(Calendar.DATE)); //날짜를 구한다
   String date = year + month + day;   //8자리 숫자★
   return date;
}
%>
<%
String str=getdate(0);
%>
<!-- 세션 -->
<%
  String pagefile = request.getParameter("page");
  if (pagefile == null) {
    pagefile = "main";
  }
  
  String email = "";
  int db_mem_num = 0;
  int mem_num = 0;
  
  try{
         email = (String)session.getAttribute("email");
         
         //System.out.println(email);
         
         if(email==null || email.equals(""))
            response.sendRedirect("index.jsp");
         else{
            LogonDBBean dbPro = LogonDBBean.getInstance(); 
             LogonDataBean member = dbPro.getMember(email);
             db_mem_num = member.getMem_num();
             session.setAttribute("mem_num",db_mem_num);
%>





<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<link href="assets/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="assets/css/main.css" rel="stylesheet">
<link href="assets/css/footer-distributed.css" rel="stylesheet">



<jsp:useBean id="today1" scope="page" class="all.action.TodayDataBean">
   <jsp:setProperty name="today1" property="*"/>
</jsp:useBean>
<jsp:useBean id="bestC" scope="page" class="all.action.BoardDataBean">
   <jsp:setProperty name="bestC" property="*"/>
</jsp:useBean>

<!-- <script src="assets/js/dhtmlxscheduler.js" type="text/javascript"
	charset="utf-8"></script>
<script src="assets/js/dhtmlxscheduler_minical.js"
	type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="assets/css/dhtmlxscheduler.css"
	type="text/css" charset="utf-8"> -->
	
	<link href='./assets/lib/fullcalendar.min.css' rel='stylesheet' />
    <link href='./assets/lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <!-- <script src='./assets/lib/jquery.min.js'></script> -->   
    <script src='./assets/lib/moment.min.js'></script>
    <script src='./assets/lib/fullcalendar.js'></script>

<script src="./assets/js/jquery-3.2.1.min.js"></script>
<script src="./assets/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="./assets/js/todolist.js" ></script> -->
<script src="./assets/js/move.js" type="text/javascript" charset="utf-8"></script>

<!-- 캘린더 보이기 및 입력,수정,삭제  -->
<script>

 $(document).ready(function() {
  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();

  var calendar = $('#calendar').fullCalendar({
   editable: true,
   header: {
    left: 'prev,next today',
    center: 'title',
    right: 'month,agendaWeek,agendaDay'
   },
//달력에 뿌려주는 부븐이다. 일정. 꺄항
   events: "http://localhost/php/events.php?email=<%= email %>" ,

   eventRender: function(event, element, view) {

    if (event.allDay === 'true') {
     event.allDay = true;
    } else {
     event.allDay = false;
    }
    if(event.is_imported == 1){
    	element.attr('style','background: #f9992f; border:none; !important;');
    }
   },
   selectable: true,
   selectHelper: true,
   select: function(start, end, allDay) {
  	   
   //var title = prompt('Event Title:');
   //var title = prompt('Event Title:');
   var start = $.fullCalendar.formatDate(start, "Y-MM-DD HH:mm:ss");
   var end = $.fullCalendar.formatDate(end, "Y-MM-DD HH:mm:ss");
   
   var arrStartDateTime = start.split(' ');
   var arrStartDate = arrStartDateTime[0].split("-");
   var startYear = arrStartDate[0];
   var startMonth = arrStartDate[1];
   var startDay = arrStartDate[2];
   var arrStartTime = arrStartDateTime[1].split(":");
   var startHour = arrStartTime[0];
   var startMin = arrStartTime[1];
   var startSecond = arrStartTime[2];
   
   var arrEndDateTime = end.split(' ');
   var arrEndDate = arrEndDateTime[0].split("-");
   var endYear = arrEndDate[0];
   var endMonth = arrEndDate[1];
   var endDay = arrEndDate[2];
   var arrEndTime = arrEndDateTime[1].split(":");
   var endHour = arrEndTime[0];
   var endMin = arrEndTime[1];
   var endSecond = arrEndTime[2];
   
   //set selection start date
   $('#txtsTime').val(startHour + ":" + startMin);
   $('#txtsDay').val(startDay);
   $('#txtsMonth').val(startMonth);
   $('#txtsYear').val(startYear);
   
 	//set selection end date
   $('#txteTime').val(endHour + ":" + endMin);
   $('#txteDay').val(endDay);
   $('#txteMonth').val(endMonth);
   $('#txteYear').val(endYear);
   
   $("#bigimage2").modal("show");

   $('#btnDelete').attr('style','display:none;');

   $('#txtEventId').val('');
   $('#txtTitle').val('');
   $('#txtDescription').val('');
   


   calendar.fullCalendar('unselect');
   },

   editable: false,
   eventDrop: function(event, delta) {
   var start = $.fullCalendar.formatDate(event.start, "Y-MM-DD HH:mm:ss");
   var end = $.fullCalendar.formatDate(event.end, "Y-MM-DD HH:mm:ss");
   $.ajax({
	   url: 'http://localhost/php/update_events.php',
	   data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
	   type: "POST",
	   success: function(json) {
	    //alert("Updated Successfully");
	   }
   });
   },
   eventClick: function(event) {
	  
	   $("#txtEventId").val(event.id);
	   $("#txtTitle").val(event.title);
	   $("#txtDescription").val(event.description);
	   console.log(event);
	   
	   var start = $.fullCalendar.formatDate(event.start, "Y-MM-DD HH:mm:ss");
	   var end = $.fullCalendar.formatDate(event.end, "Y-MM-DD HH:mm:ss");
	   
	   
	   var arrStartDateTime = start.split(' ');
	   var arrStartDate = arrStartDateTime[0].split("-");
	   var startYear = arrStartDate[0];
	   var startMonth = arrStartDate[1];
	   var startDay = arrStartDate[2];
	   var arrStartTime = arrStartDateTime[1].split(":");
	   var startHour = arrStartTime[0];
	   var startMin = arrStartTime[1];
	   var startSecond = arrStartTime[2];
	   
	   var arrEndDateTime = end.split(' ');
	   var arrEndDate = arrEndDateTime[0].split("-");
	   var endYear = arrEndDate[0];
	   var endMonth = arrEndDate[1];
	   var endDay = arrEndDate[2];
	   var arrEndTime = arrEndDateTime[1].split(":");
	   var endHour = arrEndTime[0];
	   var endMin = arrEndTime[1];
	   var endSecond = arrEndTime[2];
	   
	   //set selection start date
	   $('#txtsTime').val(startHour + ":" + startMin);
	   $('#txtsDay').val(startDay);
	   $('#txtsMonth').val(startMonth);
	   $('#txtsYear').val(startYear);
	   
	 	//set selection end date
	   $('#txteTime').val(endHour + ":" + endMin);
	   $('#txteDay').val(endDay);
	   $('#txteMonth').val(endMonth);
	   $('#txteYear').val(endYear);
	   
	   $("#bigimage2").modal("show");
	   $('#btnDelete').removeAttr('style','display:none;');
	   
	 
  	},
   eventResize: function(event) {
	   var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
	   var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
	   $.ajax({
	    url: 'http://localhost/php/update_events.php',
	    data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
	    type: "POST",
	    success: function(json) {	     
	    }
	   });
	}
   
  });
  
  
  $('#btnSave').click(function(){
	  	
		 
		 email ="<%= email %>";
		 title = $('#txtTitle').val();
		 start = $('#txtsYear').val() + "-" + $('#txtsMonth').val() + "-" + $('#txtsDay').val() + " " + $('#txtsTime').val() + ":00";
		 end = $('#txteYear').val() + "-" + $('#txteMonth').val() + "-" + $('#txteDay').val() + " " + $('#txteTime').val() + ":00";
		 
		 event_id =  $("#txtEventId").val();
		 description = $('#txtDescription').val();
		 
		 if(event_id){
			 url = 'http://localhost/php/update_events.php';
			 data = 'title='+ title+'&start='+ start +'&end='+ end +'&id='+ event_id + '&description=' + description;
		 }
		 else{
			 url = 'http://localhost/php/add_events.php?email=<%= email %>';
			 data = 'title='+ title +'&start='+ start +'&end='+ end +'&description=' + description;
		 }
	     
	     $.ajax({
	  	   url: url,
	  	   data: data,
	  	   type: "POST",
	  	   error: function(json) {
		  	   
		  	   window.location.reload();
	  	   }
	     });
	     
	 });
  
  $('#btnDelete').click(function(){
		
	  
		event_id =  $("#txtEventId").val();
		if(!event_id) return;
		
		var decision = confirm("Do you really want to do that?"); 
		if (decision) {
		$.ajax({
			type: "POST",
			url: "http://localhost/php/delete_event.php",
			data: "&id=" + event_id,
			 error: function(json) {
				 
				  window.location.reload();
				  }
		});
		}
		
	 });
  
  
  	$(document).on('click','#btnImport',function(event){
  		event.preventDefault();
  		parent = $(this).parent().parent().parent();

  		 title = $(parent).find('.list-group-item-heading').html();
  		
  		 title = title.replace('<b><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>',"");
  		 title = title.replace('</b>','');

  		 

  		 arrstart = $(parent).find('p.list-group-item-text').eq(3).text().replace("접수시작 ", "");
  		 arrStrdate = arrstart.replace("접수마감 ", "");
  		
  		start = arrStrdate.substr(0,10);
  		 end = arrStrdate.substr(11,21);  		 
  		
  		 start =start + " " +  "00:00:00";
  		 end = end + " " +  "00:00:00";
  		 

	 
	  		url = 'http://localhost/php/add_events.php?email=<%= email %>';
	  		data = 'title='+ title+'&start='+ start +'&end='+ end + "&import=1";
	  	    
	  	    $.ajax({
	  	 	   url: url,
	  	 	   data: data,
	  	 	   type: "POST",
	  	 	   error: function(json) {
	  		  	 
	  		  	   window.location.reload();
	  	 	   }
	  	    });
  		 
  	
  	});
  	
  	
  	
  	
  
  
 });
 
 

</script>



<!-- 시작 임박 일정  -->
<script>
	
</script>




<!-- 배너이미지 호버효과  css -->
<style>
#banner a img{
	-webkit-filter: grayscale(100%);
filter: gray;
}
 
#banner a:hover img{
-webkit-filter: grayscale(0%);
filter: none;
}
</style>



<title>WORK PLAN IT</title>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="javascript:goHome()">WORK PLAN IT</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li class="<%if(pagefile.equals("commu")) out.print(" active"); %>"><a
						href="javascript:goCommu()">COMMUNITY</a></li>
					<li
						class="<%if(pagefile.equals("planet")) out.print(" active"); %>"><a
						href="javascript:goPlanet()">PLANET</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-alerts">
							<li><a href="#">
									<div>
										<i class="fa fa-comment fa-fw"></i> New Comment <span
											class="pull-right small">4분 전</span>
									</div>
							</a></li>
							<li><a href="#">
									<div>
										<i class="fa fa-envelope fa-fw"></i> Message Sent <span
											class="pull-right small">4분 전</span>
									</div>
							</a></li>
							<li><a href="#">
									<div>
										<i class="fa fa-tasks fa-fw"></i> New Task <span
											class="pull-right small">4분 전</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a class="text-center" href="#"> <strong>See
										All Alerts ></strong>
							</a></li>
						</ul> <!-- /.dropdown-alerts --></li>
					<!-- /.dropdown -->
					<li class="dropdown userdd"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="javascript:goMypage()"><div>
										<i class="fa fa-user fa-fw"></i> My Page
									</div></a></li>
							<li><a href="#"><div>
										<i class="fa fa-gear fa-fw"></i> Settings
									</div></a></li>
							<li class="divider"></li>
							<li><a href="index.jsp"><div>
										<i class="fa fa-sign-out fa-fw"></i> Logout
									</div></a></li>
						</ul> <!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
				</ul>
			</div>
		</div>
	</nav>

	<br>
	<br>

	<div class="row" style="margin: 50px">
		<div id="calendar" class="col-md-9">
			<!-- /달력부분 -->

			<!-- 메모장 부분 -->

		</div>
		<div class="col-md-3">
			<!-- 디데이랑 검색부분 -->

			<form style="padding-top: 50px">
				<div class="input-group">
					<input type="text" name="q" class="form-control" placeholder="enter job keyword">
					<span class="input-group-btn">
						<button class="btn btn-default" id="searchBtn" type="button">
							<img src="https://cdn4.iconfinder.com/data/icons/app-custom-ui-1/48/Loupe-16.png">
						</button>
					</span>
				</div>
				<!-- /input-group -->
				<div id="result"></div>
			</form>

			<hr>

			<div style="height: 450px;">
				<div id="myDIV" class="header">
					<h2 style="margin: 5px">Today's Events</h2>
				</div>
				<div id="todayevent" >
					<jsp:include page="todayEvent.jsp" flush="false"/>
				
					<!-- 오늘의 일정 -->
					
				</div>
			</div>
			<hr>
			<div align="right">
				<p>
				<jsp:include page="dDay.jsp" flush="false"/>
					
				</p>
			</div>
		</div>
	</div>


	<br>
	<br>


	<!-- Container (Services Section) -->
	<div id="services" class="container-fluid text-center">
		<div class="row">
			<div class="col-sm-6">
				<jsp:include page="todolist.jsp" flush="false"/>
			</div>

			<div class="col-sm-6">
				<div style="height: 550px;">
					<div id="myDIV" class="header">
						<h2 style="margin: 5px">PLANET NEWS</h2>
					</div>
					<div id="myUL"
						style="text-align: left; height: 453px; overflow-x: hidden; overflow-y: scroll;">
						<div class="alert alert-dismissable"
							style="border-radius: 0; border-left: solid 5px #5e6b92;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>NOTICE</strong> 공지사항입니다.
						</div>

						<div class="alert alert-dismissable"
							style="border-radius: 0; border-left: solid 5px #5e6b92;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>NEW</strong> [힐링] 합격을 위한 마음 가짐
						</div>

						<div class="alert alert-dismissable"
							style="border-radius: 0; border-left: solid 5px #5e6b92;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>NEW</strong> 정기 모임 일정 안내
						</div>

						<div class="alert alert-dismissable"
							style="border-radius: 0; border-left: solid 5px #5e6b92;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>NOTICE</strong> 우리 플래닛 규칙 공지
						</div>

					</div>

				</div>
			</div>
		</div></div>

		<br>

		<section style=" background: url(./assets/img/cover.jpg) no-repeat center center fixed; -webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover; overflow-x: hidden; margin-right: 0px; margin-left: 0px;">
    <div id="about" class="container-fluid" >
      <div class="row text-left" style="height: 600px;">
      <h1 style="color: #eee;"> BEST COMMUNITY</h1>
        <div class="col-sm-12" style="padding: 100px;">

        

          <div id="myCarousel" class="carousel slide text-center" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators" >
              <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
              <li data-target="#myCarousel" data-slide-to="1"></li>
              <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox" >
            <jsp:include page="bestC.jsp" flush="false"/>
              <!-- <div class="item active">
                <a href="#" style="text-decoration: none"><h1 style="color: #eee;">오늘공부 인증</h1>
                <h4 style="color: #ccc;">6시 30분에 일어나서 바로 도서관으로 향했습니다. 어제 다 못한 CSS를 마저 하기 위해서 입니다...</h4></a>
              </div>
              <div class="item">
                <a href="#" style="text-decoration: none"><h1 style="color: #eee;">안녕하세요! 가입인사 드립니다</h1>
                <h4 style="color: #ccc;">안녕하세요 저는 무역회사 준비하고 있는 96년생 ㅇㅇㅇ입니다. 앞으로 많은 정보 얻어 갈게요!...</h4></a>
              </div>
              <div class="item">
                <a href="#" style="text-decoration: none"><h1 style="color: #eee;">7전 8기</h1>
                <h4 style="color: #ccc;">아직은 때가 아닌가 봅니다. 이번 시험도 아깝게 떨어졌어요. 이번엔 될거라 믿었...</h4></a>
              </div> -->
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>

          </div>
        </div>
      </div>


    </div></section>
	

	<div class="modal fade" id="bigimage" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="margin-top: 80px;">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="padding:35px 40px; background-color: #5e6b92;">

        <div><button type="button" class="close" data-dismiss="modal"><div align="right">&times;</div></button></div>

        <h3 style="background-color: #5e6b92; color: #eee; text-align: center;">
          검색 결과

        </h3>
		
      </div>
      
      <div class="modal-body" id="momo" style="padding:20px 20px; max-height: calc(100vh - 210px); overflow-y: auto;">
	
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- modal 2 -->
<div class="modal fade" id="bigimage2" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="margin-top: 80px;">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="padding:35px 40px; background-color: #5e6b92;">

        <div><button type="button" class="close" data-dismiss="modal"><div align="right">&times;</div></button></div>

        <h5 style="background-color: #5e6b92; color: #eee; text-align: center;">
          <span class="glyphicon glyphicon-calendar"></span>
		<input type="hidden" value="" id="txtEventId" >
        </h5>
			
      </div>
      <div class="modal-body" id="momo2" style="padding:20px 20px; max-height: calc(100vh - 210px); overflow-y: auto;">
      	Title <input type="text" class="form-control" id="txtTitle" ><br>
      	Description <input type="text" class="form-control" id="txtDescription"><br>
      	&emsp;&emsp;<span class="label label-day">시작</span> &emsp;&emsp;<select id="txtsTime">
      		  	<%
      			for(int i=0; i<24; i++){
      				for(int j=0; j<=55;j=j+5){
      					String stHour = String.format("%02d",i);
      					String stMin = String.format("%02d",j);
      			%>
      			<option value="<%=stHour + ":" + stMin %>"><%=stHour + ":" + stMin %></option>
      			<%} 
      			}
      			%>
      		  </select>
      		  <select id="txtsDay">
      		  	<%
      			for(int i=1; i<=31; i++){	
      				String stDay = String.format("%02d",i);
      			%>
      			<option value="<%=stDay %>"><%=stDay %></option>
      			<%} %>
      		  </select>
      		  일
      		  <select id="txtsMonth">
      		  <%
      			for(int i=1; i<=12; i++){	
      				String stMonth = String.format("%02d",i);
      			%>
      			<option value="<%=stMonth %>"><%=stMonth %></option>
      		<%} %>
      		  </select>
      		  월
      		  <select id="txtsYear">
      		   <%
      			for(int i=2017; i<=2025; i++){
      			%>
      			<option value="<%=i %>"><%=i %></option>
      			<%} %>
      		  </select>
      		  년
      	<br>
      	&emsp;&emsp;<span class="label label-day">마감</span> &emsp;&emsp;<select id="txteTime">
      		  	<%
      			for(int i=0; i<24; i++){
      				for(int j=0; j<=55;j=j+5){
      					String stHour = String.format("%02d",i);
      					String stMin = String.format("%02d",j);
      			%>
      			<option value="<%=stHour + ":" + stMin %>"><%=stHour + ":" + stMin %></option>
      			<%} 
      			}
      			%>
      		  </select> 
      		  <select id="txteDay">
      		  	<%
      			for(int i=1; i<=31; i++){	
      				String stDay = String.format("%02d",i);
      			%>
      			<option value="<%=stDay %>"><%=stDay %></option>
      			<%} %>
      		  </select>
      		  일
      		  <select id="txteMonth">
      		  <%
      			for(int i=1; i<=12; i++){	
      				String stMonth = String.format("%02d",i);
      			%>
      			<option value="<%=stMonth %>"><%=stMonth %></option>
      		<%} %>
      		  </select>
      		  월
      		  <select id="txteYear">
      		   <%
      			for(int i=2017; i<=2025; i++){
      			%>
      			<option value="<%=i %>"><%=i %></option>
      			<%} %>
      		  </select>
      		  년
      		  <br><br>
      		  <input type="button" class="btn-modal" id="btnSave" value="저장"><br id="modalBr">
      		  <input type="button" class="btn-modal" id="btnDelete" value="삭제">
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- end modal 2 -->

<!-- 오늘의 채용공고 -->
	<div style=" padding-top:40px; margin-bottom:20px; text-align:center;"><h1><b>오늘의 추천 공고</b></h1>
	<button id="choocheonBtn" onclick="choocheonToday()"><hr width="20%" color="#5e6b92">▽</button>	</div>
	
		<div id="tc" class="container container-fluid"></div>
<!-- /오늘의 채용공고 -->
	
<div>
	<footer class="footer-distributed" style="margin-top: 10px; padding-bottom: 30px;">		
		<div class="row">
			<div class="footer-left col-md-6" style="margin-top: 10px;">
				<p class="footer-links">
					<a href="./aboutus/aboutus.jsp">ABOUT US</a> &emsp;|&emsp; <a href="./sitemap/sitemap.jsp">SITE
						MAP</a>
				</p>
				<br>
				<br>
				<p>
					made by PLANETARIUM <br>
					powered by SARAMIN <br>
					<br> Hanyang Woman's University Department of Computer
					Information <br> 서울시 성동구 살곶이길 200 한양여자대학교 정보문화관 5층 PC54실 <br>
				</p>
			</div>
			<div class="col-md-6" align="right">
				<img src="assets/img/LOGO_WHITE.png" width="22%" height="18%">
			</div>
		</div>
		<br>
		<div id="banner" style="margin-top: 10px;">   
    <a href="http://www.saramin.co.kr"><img src="./assets/img/saramin.png" style="height:40px;"></a>
      &emsp;&emsp;<a href="http://www.jobkorea.co.kr"><img src="./assets/img/jobkorea.png" style="height:40px;"></a>
      
	  &emsp;&emsp;<a href="http://www.incruit.com"><img src="./assets/img/incruit.png" style="height:40px;"></a>
	   
	  
   </div>
	</footer>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!-- todolist -->
	<!-- <script src="./assets/js/todolist.js"></script> -->
	
	<!-- <script src='./assets/lib/jquery.min.js'></script>    --> 
    <script src='./assets/lib/moment.min.js'></script>
    <script src='./assets/lib/fullcalendar.js'></script>

	<script>
    $(document).ready(function() {
      // Add smooth scrolling to all links in navbar + footer link
      $(".navbar a, footer a[href='#myPage']").on("click", function(event) {
        // Make sure this.hash has a value before overriding default behavior
        if (this.hash !== "") {
          // Prevent default anchor click behavior
          event.preventDefault();
    
          // Store hash
          var hash = this.hash;
    
          // Using jQuery's animate() method to add smooth page scroll
          // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
          $("html, body").animate(
            {
              scrollTop: $(hash).offset().top
            },
            900,
            function() {
              // Add hash (#) to URL when done scrolling (default click behavior)
              window.location.hash = hash;
            }
          );
        } // End if
      });
    
      $(window).scroll(function() {
        $(".slideanim").each(function() {
          var pos = $(this).offset().top;
    
          var winTop = $(window).scrollTop();
          if (pos < winTop + 600) {
            $(this).addClass("slide");
          }
        });
      });
    });
  </script>

	

	<!-- print -->
	<!-- <script>
    function myFunction() {
      window.print('.idPrint');
    }
  </script> -->


	<!-- 취업정보 검색 모달. -->
<script>

$('#btnImport').click(function(){
	 //$("#bigimage2").find(".modal-body").html("abc");
	 title = $('.list-group-item-heading').html();
	 title = title.replace('<b><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>',"");
	 title = title.replace('</b>','');
	 
	 arrstart = $('p.list-group-item-text').eq(3).text().replace("접수시작 ", "");
	 arrstart = arrstart.replace("접수마감 ", "");
	 arrstart = arrstart.split(" ");
	 start = arrstart[0];
	 end = arrstart[0];
	 
	 email ="<%= email %>";
	 
	 start =start + " " + $('#txtsTime').val() + ":00";
	 end = end + " " + $('#txteTime').val() + ":00";
	 
	 
	 
	url = 'http://localhost/php/add_events.php?email=<%= email %>';
	data = 'title='+ title+'&start='+ start +'&end='+ end;
    
    $.ajax({
 	   url: url,
 	   data: data,
 	   type: "POST",
 	   success: function(json) {
	  	   //alert('Added Successfully');
	  	   window.location.reload();
 	   }
    });
});


    $('input[name="q"]').keydown(function(event) {
      if (event.keyCode == 13) {
        // enter-click
        $("#searchBtn").trigger("click");
      }
    });
    
    $("#searchBtn").click(function() {
      var q = $('input[name="q"]').val();
      if (q.length > 1) {
        fetchSearchResult(q);
      } else {
        alert("검색어는 2글자 이상 입력하세요!");
      }
    });
  
    function timestamp2date(UNIX_timestamp) {
    	var a = new Date(UNIX_timestamp * 1000);
    	var year = a.getFullYear();
    	var month = a.getMonth() + 1;
    	month = (month < 10) ? '0' + month : month;
    	var date = a.getDate();
    	date = (date < 10) ? '0' + date : date;

    	var time = year+'-'+month+'-'+date;

    	return time;
    };
    
    function fetchSearchResult(q) {
    	
        //console.log(q);
        $.get("http://localhost/php/api.php", {
          keywords: q
        }).done(function(data) {
          //console.log(data);
          var items = $(data).find("job");
          var results = [];
          //console.log(items);
          $.each(items, function(k, v) {
            var title = $(this).find("title").text();
            var jobtype = $(this).find("job-type").text();
            var jobcategory = $(this).find("job-category").text();
            var salary = $(this).find("salary").text();
            var url = $(this).find("url").text();
            var expiration = $(this).find('expiration-timestamp').text();
			var expirationDate = timestamp2date(expiration);
			
			var opening = $(this).find('opening-timestamp').text();
			var openingDate = timestamp2date(opening);
            
			
            //console.log(url);
            results.push(
              '<h7 class="list-group-item-heading"><b><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span> ' +
              title +
              '</b></h7><div class="row"><div class="col-md-10"><a href="' +
              url +
              '" class="list-group-item" style="border:none;" target="_blank"><p class="list-group-item-text" style="line-height:2em"><span class="label label-job-type">' +
              jobtype +'</span></p><hr style="margin:10px;"><p class="list-group-item-text" style="line-height:2em"><span class="label label-job">카테고리</span> ' +
              jobcategory +
              '</p><p class="list-group-item-text" style="line-height:2em"><span class="label label-job">연봉</span> ' +
              salary +
              '</p><p class="list-group-item-text" style="line-height:2em"><span class="label label-job">접수시작</span> '+ 
              openingDate +'&emsp;<span class="label label-job-magam">접수마감</span> '+ 
              expirationDate +'</p></a></div><div class="col-md-2" ><br><br>&emsp;<button class="btn btn-default" id="btnImport" style="border : none;"><span class="glyphicon glyphicon-plus"></span></button>&emsp;<button class="btn btn-default" onclick="myFunction()" style="border:none; margin-top: 15px;"><span class="glyphicon glyphicon-star"></span></button></div></div><hr>');
          });
          $("#bigimage").find(".modal-body").html(results.join(""));
          $("#bigimage").modal("show");
        });
      }

    
    
    // click item
    $(document).on("click", "a.list-group-item", function(evt) {
      $(this).siblings().removeClass("active").end().addClass("active");
    });
   
  </script>
  <!-- /채용검색모달끝 -->
  
  <!-- 오늘 추천공고 -->
 <script>

    
  function choocheonToday() {
	  <%-- console.log(<%= str%>); --%>
      
      $.get("http://localhost/php/todayapi.php", {
          fields: <%= str%>
      }).done(function(data) {
        //console.log(data);
        var items = $(data).find("job");
        var choocheons = [];
        //console.log(items);
        $.each(items, function(k, v) {
          var title = $(this).find("title").text();
          var name = $(this).find("name").text();
          
          var url = $(this).find("url").text();
          //console.log(url);
          choocheons.push(
            '<a href="' +
              url +
              '" class="list-group-item" style="border-radius: 0;" target="_blank"><span class="glyphicon glyphicon-bell" aria-hidden="true"></span><h7>'+name+'</h7><br><h7 class="list-group-item-heading"> ' +
              title +
              '</h7></a>');
          });
          $("#tc").html(choocheons.join(""));
          
        });
      }

    
    
    // click item
    $(document).on("click", "a.list-group-item", function(evt) {
      $(this).siblings().removeClass("active").end().addClass("active");
    });
    
    
   
  </script>
  
  <!-- /추천공고끝 -->
  
 <script>
function myFunction() {
    var txt;
    if (confirm("마이페이지 채용정보에 저장하시겠습니까?") == true) {
    	location.href = './mypage.jsp';
    } else {
        
    }
    //document.getElementById("demo").innerHTML = txt;
}
</script>
  
  
 

</body>

</html>

<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>