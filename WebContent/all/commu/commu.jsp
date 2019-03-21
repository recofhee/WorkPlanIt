<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page trimDirectiveWhitespaces="true" %>

<%
	String pagefile = request.getParameter("page");
	if (pagefile == null) {
		pagefile = "list";
	}
	
	String email ="";
	try{
		   email = (String)session.getAttribute("email");
		   if(email==null || email.equals(""))
			response.sendRedirect("../index.jsp");
		   else{
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="assets/css/font-awesome.min.css" rel="stylesheet">
<link href="assets/css/commu.css" rel="stylesheet">
<!-- <script src="assets/js/move.js" type="text/javascript" charset="utf-8"></script> -->
<script src="http://demo.itsolutionstuff.com/plugin/croppie.js"></script>
<link rel="stylesheet" href="http://demo.itsolutionstuff.com/plugin/croppie.css">
<link href="assets/css/slick.css" rel="stylesheet">

<title>WORK PLAN IT</title>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
	

<!-- Wrapper -->
<div id="wrapper">
	<!-- Header -->
	<jsp:include page="header.inc.jsp" flush="false"/>

	<!-- Main -->
	<jsp:include page='<%=pagefile + ".jsp"%>' flush="false"/>


</div>

<div>
   <jsp:include page="footer.inc.jsp" flush="false"/>
</div>
   

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 5%;">
	<div class="modal-dialog">
    	<div class="modal-content">
      		<div class="modal-header">
	        	<h4 class="modal-title" id="myModalLabel"><i class="icon fa fa-cog"></i> 설정</h4>
	      	</div>
		    <div class="modal-body">
				<div class="text-center" id="upload-demo"></div>
				<div>
				    <label for="upload">사진 선택</label>
					<input type="file" id="upload">
				</div>
		    </div>
	      	<div class="modal-footer">
		        <button type="button" data-dismiss="modal">Close</button>
		        <button class="upload-result">Upload Image</button>
	      	</div>
   		 </div>
  	</div>
</div>


<script>

$uploadCrop = $('#upload-demo').croppie({
    enableExif: true,
    viewport: {
        width: 350,
        height: 200
        // type: 'circle'
    },
    boundary: {
        width: 350,
        height: 200
    }
});

$('#upload').on('change', function() { 
	var reader = new FileReader();
    reader.onload = function (e) {
    	$uploadCrop.croppie('bind', {
    		url: e.target.result
    	}).then(function(){
    		console.log('jQuery bind complete');
    	});
    	
    }
    reader.readAsDataURL(this.files[0]);
});

$('.upload-result').on('click', function (ev) {
	$uploadCrop.croppie('result', {
		type: 'canvas',
		size: 'viewport'
	}).then(function (resp) {

		$.ajax({
			url: "http://localhost/commu/ajaxpro.php",
			type: "POST",
			data: {"image":resp},
			success: function (data) {
				html = '<img style="height: 170px;" src="' + resp + '" />';
				$("#upload-demo-i").html(html);
			}
		});
	});
});

</script>

<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>
<script src="assets/js/slick.js"></script>


<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>

</body>
</html>