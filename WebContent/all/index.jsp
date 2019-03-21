<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="all.action.LogonDBBean"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WORK PLAN IT</title>
<link href="assets/bootstrap-3.3.7/css/bootstrap.min.css"	rel="stylesheet">
<link href="assets/css/login.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<style>
body {
	background: url(assets/img/cover.jpg) no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	overflow-x: hidden;
}

#row-main {
	overflow-x: hidden; /* necessary to hide collapsed sidebar */
}

#content {
	-webkit-transition: width 0.3s ease;
	-moz-transition: width 0.3s ease;
	-o-transition: width 0.3s ease;
	transition: width 0.3s ease;
}

.col-md-9 .width-12, .col-md-12 .width-9 {
	display: none; /* just hiding labels for demo purposes */
}

#sidebar {
	background-color: rgba(0, 0, 0, 0);
	-webkit-transition: margin 0.3s ease;
	-moz-transition: margin 0.3s ease;
	-o-transition: margin 0.3s ease;
	transition: margin 0.3s ease;
	padding-top: 35px;
}

.collapsed {
	display: none; /* hide it for small displays */
}

@media ( min-width : 992px) {
	.collapsed {
		display: block;
		margin-right: -25%; /* same width as sidebar */
	}
}
</style>
</head>

<body onload="startTime()" id="myPage" data-spy="scroll"
	data-offset="60">

	<div class="row" id="row-main">
		<div class="col-md-12" id="content">
			<div style="text-align-last: right; margin-top: 35px;">
				<div class="btn-group" role="group">
					<button type="button" class="btn btn-login toggle-sidebar"
						style="background-color: rgba(255, 255, 255, 0.7);">
						<span class="glyphicon glyphicon-user"
							style="color: rgba(0, 0, 0, 0.7);"></span>
					</button>
				</div>
			</div>
			<div id="myCarousel" class="carousel" data-ride="carousel"
				style="background-color: rgba(0, 0, 0, 0);">

				<div class="carousel-inner">
					<div class="item active">
						<div id="txt" align="center" style="padding: 17px"></div>
						<div id="txt2" align="center">Life is a journey, not a
							guided tour.</div>

						<div id="txt3" align="center" style="margin-top: 50px">
							<p>
								made by PLANETARIUM Hanyang Woman's University Department of
								Computer Information <br> 서울시 성동구 살곶이길 200 한양여자대학교 정보문화관 5층
								PC54실 <br>
							</p>
						</div>
					</div>
				</div>

			</div>

		</div>

		<div class="col-md-3 collapsed" id="sidebar">
			<form method="post" action="loginpro.jsp">
				<div id="txt4">
					<label>E-mail</label>
					<div class="controls" style="padding: 15px">
						<input type="email" name="email" placeholder="Enter e-mail"
							class="form-control" />
					</div>
				</div>
				<div id="txt4">
					<label>Password</label>
					<div class="controls" style="padding: 15px">
						<input type="password" name="password"
							placeholder="Enter password" class="form-control" />
					</div>
				</div>

				<div id="txt4" class="controls">
					<div class="controls" style="padding: 15px">
						<button type="submit" id="txt4" class="btn btn-login"
							style="background-color: rgba(0, 0, 0, 0.7);">Log in</button>
					</div>
				</div>
			</form>
			<div id="txt4" class="controls">
				<div class="controls" style="padding: 15px">
					<button id="myBtn1" class="btn btn-login"
						style="background-color: rgba(0, 0, 0, 0.7);">Join</button>
					<button id="myBtn2" class="btn btn-login"
						style="background-color: rgba(0, 0, 0, 0.7);">Find</button>
				</div>
			</div>

		</div>

	</div>



	<!-- Modal1 -->
	<div class="modal fade" id="myModal1" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header"
					style="padding: 35px 50px; background-color: #5e6b9e;">

					<button type="button" class="close" data-dismiss="modal">
						<div align="right">&times;</div>
					</button>

					<h4 style="background-color: #5e6b9e;">
						<span class="glyphicon glyphicon-user"></span> JOIN
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form method="post" action="login.jsp">
						<div class="form-group">
							<label for="email">E-mail</label> <input type="email"
								class="form-control" name="email" placeholder="Enter E-mail"
								required="true"> <input type="button"
								name="confirm_email" class="form-control" value="중복 확인"
								onClick="openConfirmEmail(this.form)">
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" name="password"
								placeholder="Enter Password" required="true">
						</div>
						<div class="form-group">
							<label for="name">Name</label> <input type="text"
								class="form-control" name="name" placeholder="Enter Name"
								required="true">
						</div>
						<div class="form-group">
							<label for="birthday">Birthday</label> <input type="date"
								class="form-control" name="birthday"
								placeholder="Enter Birthday" required="true">
						</div>
						<button id="txt4" type="submit" class="btn btn-modal btn-block">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</form>
				</div>

			</div>

		</div>
	</div>


	<!-- Modal2 -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header"
					style="padding: 35px 50px; background-color: #5e6b9e;">

					<button type="button" class="close" data-dismiss="modal">
						<div align="right">&times;</div>
					</button>

					<h4 style="background-color: #5e6b9e;">
						<span class="glyphicon glyphicon-search"></span> FIND
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;">
					<form role="form">
						<div class="form-group">
							<label for="email">E-mail</label> <input type="email"
								class="form-control" id="email" placeholder="Enter E-mail"
								required="true">
						</div>

						<div class="form-group">
							<label for="btd">Birthday</label> <input type="Date"
								class="form-control" id="btd" placeholder="Enter birthday"
								required="true">
						</div>

						<button id="txt4" type="submit" class="btn btn-modal btn-block">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</form>
				</div>

			</div>

		</div>
	</div>






	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="assets/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script>
      function startTime()
      {
        var today=new Date();
        var h=today.getHours();
        var m=today.getMinutes();
        var s=today.getSeconds();
    // add a zero in front of numbers<10
        m=checkTime(m);
        s=checkTime(s);
        document.getElementById('txt').innerHTML=h+":"+m+":"+s;
        t=setTimeout('startTime()',500);
      }
      function checkTime(i)
      {
        if (i<10)
        {
          i="0" + i;
        }
        return i;
      }
    </script>




	<script>
        $(document).ready(function () {
            $(".toggle-sidebar").click(function () {
                $("#sidebar").toggleClass("collapsed");
                $("#content").toggleClass("col-md-9 col-md-12");
                
                return false;
            });
        });
    </script>


	<script>
$(document).ready(function(){
    $("#myBtn1").click(function(){
        $("#myModal1").modal();
    });
    $("#myBtn2").click(function(){
        $("#myModal2").modal();
    });
});
</script>

</body>
</html>