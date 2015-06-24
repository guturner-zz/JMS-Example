<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>JMS Example: controller</title>

	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">

	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		function resetOutput() {
			$("#output").children().each(function(index) {
				if (!$(this).is(":visible")) {
					$(this).remove();
				}
			});
		}
		
		function setOutput(level, msg) {
			resetOutput();
	
			var c = "";
			if (level == 0) {
				c = "alert alert-dismissible alert-success";
			} else if (level == 1) {
				c = "alert alert-dismissible alert-danger";
			} else {
				c = "alert alert-dismissible alert-warning";
			}
	
			var d = document.createElement("div");
	
			$(d).addClass(c);
			$(d).html(msg);
			$(d).appendTo($("#output"));
			$(d).fadeOut(3000);
		}
	
		function checkMessages() {
			$.ajax({
				type:    "GET",
				url:     "CheckMessages",
				success: function(data, textStatus, jqXHR) {
					msg = "<strong>Worker says: </strong> Getting a package from " + data + "!";
					setOutput(0, msg);
					$("#results").text(parseInt($("#results").text(), 10) + 1);

					var numAvailable = parseInt($("#available").text(), 10);
					if (numAvailable < 3) {
						$("#available").text(numAvailable + 1);
						$("#waiting").text(parseInt($("#waiting").text(), 10) - 1);
					}
				},
				error:   function(jqXHR, textStatus, errorThrown) {
					msg = "<strong>Breaking news! </strong>" + jqXHR.responseText;
					setOutput(2, msg);
				}
			});
		}

		$(document).ready(function() {
			$("#checkBtn").click(function(e) {
				var numAvailable = parseInt($("#available").text(), 10);
				var numWaiting   = parseInt($("#waiting").text(), 10);
				if (numAvailable <= 0) {
					setOutput(1, "<strong>Foreman says: </strong> Not enough workers!");
				} else {
					setOutput(0, "<strong>Foreman says: </strong> Go wait for a package, worker!");
					
					if (numAvailable > 0) {
						$("#available").text(numAvailable - 1);
						$("#waiting").text(numWaiting + 1);
					}

					checkMessages();
				}
			});
		});
	</script>
</head>
<body>
	<div class="navbar navbar-default navbar-fixed-top">
    	<div class="container">
        	<div class="navbar-header">
          		<a href="#" class="navbar-brand">Controller</a>
          		<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            		<!-- <span class="icon-bar"></span> -->
          		</button>
        	</div>
      	</div>
    </div>


    <div class="container">

    	<div class="page-header" id="banner">
        	<div class="row">
          		<div class="col-lg-8 col-md-7 col-sm-6">
            		<h1>Collect widgets!</h1>
          		</div>
        	</div>
      	</div>

		<div class="bs-docs-section clearfix">
	       	<div class="row" style="margin-top: 25px;">
	       		<div class="col-lg-12" style="font-size: 3em;">
	       			<center>
	       				<button class="btn btn-default" type="button" id="checkBtn">Tell a Worker to Wait</button>
	       			</center>
	       		</div>
	        </div>
	   	</div>
	   	
	   	<div class="bs-docs-section clearfix">
	       	<div class="row" style="margin-top: 25px;">
	       		<div class="col-lg-12" style="font-size: 3em;">
	       			<center>
	       				<div id="results">0</div> Widgets Received
	       			</center>
	       		</div>
	        </div>
	   	</div>
	   	
	   	<div class="bs-docs-section clearfix">
        	<div class="row" style="margin-top: 50px;">
        		<center>
	          		<div class="col-lg-6">
	          			<div id="available">3</div> Workers Available
	          		</div>
	          		
	          		<div class="col-lg-6">
	          			<div id="waiting">0</div> Workers Waiting for a Package
	          		</div>
	          	</center>
          	</div>
        </div>
	
		<div class="bs-docs-section clearfix">
        	<div class="row" style="margin-top: 50px;">
       			<div class="col-lg-12">
       				<center>
       					<div id="output"></div>
       				</center>
       			</div>
            </div>
    	</div>
	
	</div>
</body>
</html>