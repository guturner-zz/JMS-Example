<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>JMS Example: producer-one</title>

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
		
		function incrementProgressBar(num, iterations) {
			changeProgressPercentage(num, iterations);
		}

		function changeProgressPercentage(num, percentage) {
			$("#progressBar" + num).css("width", percentage + "%");
			$("#progressBarTxt" + num).text(percentage + "%");
		}

		$(document).ready(function() {
			$("#submitBtn").click(function(e) {
				if ($("#widgetsTxt").text() <= 0) {
					msg = "<strong>Worker says: </strong> Can't do that boss, not enough widgets!";
					setOutput(1, msg);
					return;
				}
				
				$.ajax({
					type:    "GET",
					url:     "SendMessage",
					success: function(data, textStatus, jqXHR) {
						var msg = "";

						if (data.startsWith("0")) {
							msg = "<strong>Foreman says: </strong>" + data.substring(1);
							$("#widgetsTxt span").text(parseInt($("#widgetsTxt").text(), 10) - 1);
							setOutput(0, msg);
						} else if (jqXHR.responseText.startsWith("1")) {
							msg = "<strong>Uh oh. </strong>" + data.substring(1);
							setOutput(1, msg);
						} else {
							msg = "<strong>Breaking news! </strong>" + data.substring(1);
							setOutput(2, msg);
						}
					},
					error:   function(jqXHR, textStatus, errorThrown) {
						setOutput(1, jqXHR.responseText);
					}
				});
			});
			
			$("#progressBarBtn1").click(function(e) {
				var iterations = 0;
				$("#progressBarBtn1").prop("disabled", true);
				
				var interval = setInterval(function() {
					iterations += 1;
					if (iterations > 100) {
						clearInterval(interval);
						$("#componentTxt1 span").text(parseInt($("#componentTxt1").text(), 10) + 1);
						$("#progressBarBtn1").prop("disabled", false);
						changeProgressPercentage(1, 0);
					} else {
						incrementProgressBar(1, iterations);
					}
				}, 125);
			});
	
			$("#progressBarBtn2").click(function(e) {
				var iterations = 0;
				$("#progressBarBtn2").prop("disabled", true);
				
				var interval = setInterval(function() {
					iterations += 1;
					if (iterations > 100) {
						clearInterval(interval);
						$("#componentTxt2 span").text(parseInt($("#componentTxt2").text(), 10) + 1);
						$("#progressBarBtn2").prop("disabled", false);
						changeProgressPercentage(2, 0);
					} else {
						incrementProgressBar(2, iterations);
					}
				}, 175);
			});
	
			$("#craftWidget").click(function(e) {
				if ( ($("#componentTxt1").text() <= 0 || $("#componentTxt2").text() <= 0 ) ) {
					setOutput(1, "<strong>Worker says: </strong> We don't have enough components!");
				} else {
					$("#componentTxt1").text(parseInt($("#componentTxt1").text(), 10) - 1);
					$("#componentTxt2").text(parseInt($("#componentTxt2").text(), 10) - 1);
					$("#widgetsTxt span").text(parseInt($("#widgetsTxt").text(), 10) + 1);
					setOutput(0, "<strong>Worker says: </strong> Crafting a widget!");
				}
			});
		});
	</script>
</head>
<body>
	<div class="navbar navbar-default navbar-fixed-top">
    	<div class="container">
        	<div class="navbar-header">
          		<a href="#" class="navbar-brand">Production Factory One</a>
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
            		<h1>Build widgets!</h1>
          		</div>
        	</div>
      	</div>

		<div class="bs-docs-section clearfix">
        	<div class="row" style="margin-top: 25px;">
           		<div class="col-lg-12">
           			<center>
           				<button class="btn btn-default" type="button" id="submitBtn">Load Trucks</button>
           			</center>
           		</div>
            </div>
    	</div>

      	<div class="bs-docs-section clearfix">
        	<div class="row" style="margin-top: 50px;">
          		<div class="col-lg-6">
            		<div class="row">
            			<div class="col-md-12">
            				<center>
            					<div id="componentTxt1"><span>0</span></div>
            				</center>
            			</div>
            			<div class="col-md-12">
            				<center>
            					<div class="progress" style="position: relative;">
									<div class="progress-bar" id="progressBar1" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>
									<div id="progressBarTxt1" style="position: absolute; width: 100%;">0%</div>
								</div>
            				</center>
            			</div>
            			<div class="col-md-12">
            				<center>
            					<button type="button" class="btn btn-default" id="progressBarBtn1">Make Component 1</button>
            				</center>
            			</div>
            		</div>
          		</div>
          		<div class="col-lg-6">
            		<div class="row">
            			<div class="col-md-12">
            				<center>
            					<div id="componentTxt2"><span>0</span></div>
            				</center>
            			</div>
            			<div class="col-md-12">
            				<center>
            					<div class="progress" style="position: relative;">
									<div class="progress-bar" id="progressBar2" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>
								  	<div id="progressBarTxt2" style="position: absolute; width: 100%;">0%</div>
								</div>
            				</center>
            			</div>
            			<div class="col-md-12">
            				<center>
            					<button type="button" class="btn btn-default" id="progressBarBtn2">Make Component 2</button>
            				</center>
            			</div>
            		</div>
          		</div>
        	</div>
      	</div>
      	
      	<div class="bs-docs-section clearfix">
        	<div class="row" style="margin-top: 100px;">
       			<div class="col-lg-6" style="text-align: right;">
       				<button type="button" class="btn btn-default" id="craftWidget">Craft Widget</button>
       			</div>
       			<div class="col-lg-6" style="text-align: left;">
       				<div id="widgetsTxt" style="font-size: 2em;"><span>0</span></div>
       			</div>
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