<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.PlanetDBBean" %>
<%@ page import="all.action.PlanetDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<link href="./assets/css/pmain.css" rel="stylesheet">
<link href="./assets/css/mpstyle.css" rel="stylesheet">
<link href="./assets/css/sweetalert.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./assets/js/sweetalert.min.js"></script>

<% request.setCharacterEncoding("utf-8");%>

<%
	int pageSize = 3;
	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
	    pageNum = "1";
	}
	
	//int planet_num = (Integer)session.getAttribute("planet_num");
	int planet_num = 0;
	int mem_num = (Integer)session.getAttribute("mem_num");
	int mem_index = 0;
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	String keyword = request.getParameter("keyword");
    
	List<PlanetDataBean> planetList = null;
    
    PlanetDBBean dbPro = PlanetDBBean.getInstance();
    count = dbPro.getSearchPlanetCount();
    
    

	number = count-(currentPage-1)*pageSize;
    //response.sendRedirect("planet.jsp");
    
    try{
		if(request.getParameter("mem_index")!=null){
			mem_index=Integer.parseInt(request.getParameter("mem_index"));
			planet_num=Integer.parseInt(request.getParameter("planet_num"));
    	}
		if (count > 0) {
	    	planetList = dbPro.getPlanets(startRow, pageSize, keyword);
	    }
%>

<body id="myPage">
	<section id="banner">
	  <h2>P L A N E T</h2>
	  <!-- <p>Another fine responsive site template freebie by HTML5 UP.</p> -->
	</section>
	
	<section id="main" class="container">
		<section class="box special">
			<header class="major2">
				<h2>L I S T</h2>
		    </header>
<%	if (count == 0) { // 수정 필요 %> 
       		<div class="alert alert-danger" role="alert">PLANET이 존재하지 않습니다.</div>
<%	} else {
		for (int i = 0 ; i < planetList.size() ; i++) {
			PlanetDataBean planet = planetList.get(i);
%>
			<form action="jpPro.jsp" method="post" name="joinPlanet">
				<hr class="spLine">
				<div class="container-fluid">
				  <div class="row">
				    <div class="col-sm-8">
				      <h2 class="entry-title"><%=planet.getPlanet_name()%></h2>
				      <p><%=planet.getPlanet_profile()%></p>
				    </div>
				    <div class="col-sm-4">
				      <button class="btn btn-default btn-lg btn-join">Join</button>
				      <input type="hidden" name="mem_index" value="<%=mem_index%>">
				      <input type="hidden" name="planet_num" value="<%=planet.getPlanet_num()%>">
				      <input type="hidden" name="mem_num" value="<%=mem_num%>">
				    </div>
				  </div>
				</div>
			</form>
<%
		}
	}
%>
		</section>
	</section>
</body>
<%
} catch(Exception e) { 
	e.printStackTrace();
}
%>

<script>
//가입 완료 팝업 창
$('.btn-join').on('click', function(){
	swal({
	    title: '가입을 축하합니다!',
	    type: 'success',
	    timer: 3000,
	    showCloseButton: false,
	    showCancelButton: false,
	    showConfirmButton: false
	    // onOpen: function() {
	    //   swal.showLoading()
	    // }
	  }).then(function(){
		  history.go(-1); // 실행 왜 안 되니
	  })
})
</script>