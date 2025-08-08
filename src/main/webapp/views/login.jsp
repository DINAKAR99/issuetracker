<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/md5.js"></script>
	<style>
		.is-invalid {
			border: 2px solid red !important;
			background-color: #ffe6e6 !important;
		}

		/* Highlight valid fields with green border */
		.is-valid {
			border: 2px solid green !important;
			background-color: #e6ffe6 !important;
		}

		.invalid-feedback {
			width: 90% !important;
		}

		/* Error message styling */
		.error {
			color: red !important;
			font-size: 12px !important;
			margin-left: 100px !important;
			margin-top: -5px !important;
			display: block !important;
		}

		.login-card {
			background: white;
			padding: 20px;
			border-radius: 8px;
			box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
			width: 320px;
		}

		.login-card h2 {
			text-align: center;
			margin-bottom: 20px;
			color: #333;
		}

		.input-group {
			display: flex;
			align-items: center;
			margin-bottom: 15px;
		}

		.input-group label {
			width: 100px;
			/* Fixed width for labels */
			font-weight: bold;
			color: #555;
		}

		.input-group input {
			flex: 0.5;
			padding: 6px;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 14px;
		}

		.input-group {
			margin-left: 6%;
		}
	</style>

	<c:if test="${not empty successmsg}">
		<div class="alert alert-success alert-dismissible fade show text-center font-weight-bold" role="alert">
			${successmsg}
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<form action="authenticate" method="post" autocomplete="off" id="form1">
		<!-- <section style="background-color: #073d76" > -->
		<div class="banner">
			<div class="container-fluid">
				<div class="row no-gutters">
					<div class="col-sm-6">
					</div>
					<div class="col-sm-6">
						<div id="formContent" class="ml-auto mr-auto">
							<!-- Tabs Titles -->
							<img src="./images/icon.svg" id="icon" alt="User Icon">
							<h2 style="font-size: larger !important;" class="active">Sign In</h2>
							<!-- Icon -->
							<c:if test="${param.error != null}">
								<p style="color: red;margin-top: 10px;">Invalid username or password</p>
							</c:if>
							<c:if test="${errorMessageForUsercaptcha!= null}">
								<p style="color: red;margin-top: 10px;">${errorMessageForUsercaptcha}</p>
							</c:if>
							<div class="input-group row">
								<label for="username" class="col-md-4">Username :</label>
								<input type="text" id="userName" name="userName" maxlength="20"  oninput="cleanInput(event)"
									style=" text-align: start;padding-left: 10px;">
							</div>
							<div class="input-group row">
								<label for="password" class="col-md-4">Password &nbsp;:</label>
								<input type="password" id="password" name="password"
									style=" text-align: start;padding-left: 10px;">
							</div>

							<div class="input-group row">
								<label for="captcha" class="col-md-4">Captcha &nbsp;:</label>
								<canvas id="textCanvas2" height="15" style="margin-left: 5px;"></canvas> 
								<button type="button" class="btn btn-outline-dark" style="margin-left: 5px;" onClick="fetchCaptcha();">
									<i class="fa fa-refresh" aria-hidden="true"></i>
								</button>
							</div>
							<div class="input-group row">
								<label for="captcha" class="col-md-4"></label>
								<input type="captcha" class="col-md-3 ms-1 " style="margin-left: 4px;" id="captcha"
									name="captcha" placeholder="Enter Captcha"
									style=" text-align: start;padding-left: 10px;">
							</div>
							<button class="btn btn-primary" type="submit" class="login-btn">Login</button>


							
							<br>

							<br>
						</div>
					</div>
				</div>
			</div>
		</div>

	</form>
	<script>
		// Function to remove invalid characters
		function cleanInput(event) {
			const regex = /[^A-Za-z0-9-_]/g; // Allow letters, numbers, hyphen, and underscore only
			const input = event.target.value;

			// Remove invalid characters
			event.target.value = input.replace(regex, '');
		}

	</script>
	<script>
		$(document)
			.ready( 
				function () { 
					fetchCaptcha();
				}) 
		let captchaValue = '';
		function fetchCaptcha() { 
			$.get(
				"${pageContext.request.contextPath}/captcha/number",
				function (data) {
					captchaValue = data;
 					generateCaptcha(data)
				})
		}

		function generateCaptcha(data) { 
			var code = data;
			var canvasVar = document.getElementById('textCanvas2');
			var tCtx = canvasVar.getContext('2d');
			var imageElem = document.getElementById('captchaImage2');

			// Convert the integer code to a string
			var codeStr = code.toString();
			var codeWithSpaces = codeStr.split('').join(' ');

			// Set canvas size based on the code length
			tCtx.canvas.width = tCtx.measureText(codeWithSpaces).width + 50;
			tCtx.canvas.height = 30; // Adjust as needed

			// Clear the canvas
			tCtx.clearRect(0, 0, tCtx.canvas.width, tCtx.canvas.height);

			// Draw the background
			tCtx.fillStyle = "#000000";
			tCtx.fillRect(0, 0, tCtx.canvas.width, tCtx.canvas.height);

			// Draw the text
			tCtx.font = "18px Arial";
			tCtx.fillStyle = "white";
			tCtx.textAlign = "center";
			tCtx.fillText(codeWithSpaces, tCtx.canvas.width / 2, tCtx.canvas.height / 2 + 6);

			// Set the image source to the data URL of the canvas
			imageElem.src = tCtx.canvas.toDataURL(); 
		}

	</script>
	<script type="text/javascript">
		$(document).ready(function () {
			toastr.options = {
				"positionClass": "toast-top-center",
				"closeButton": true,
				"debug": false,
				"newestOnTop": false,
				"progressBar": true,

				"preventDuplicates": false,
				"onclick": null,
				"showDuration": "300",
				"hideDuration": "1000",
				"timeOut": "5000",
				"extendedTimeOut": "1000",
				"showEasing": "swing",
				"hideEasing": "linear",
				"showMethod": "fadeIn",
				"hideMethod": "fadeOut",

			}
		});

		function validateForm() {
			if (($("#userName").val()).trim() == "") {
				toastr.error('Please Enter UserName');
				return false;
			}

			else if (($("#password").val()).trim() == "") {
				toastr.error('Please Enter Password');
				return false;
			}

		}
	</script>

	<script>
	$('#captcha').keyup(
		function () {  
			var captcha = $("#captcha").val()
				.toUpperCase(); 
			$("#captcha").val(captcha);
		});
		$(document).ready(function () {
			$.validator.addMethod("userExistsCheck", function (value, element, param) {
				var result = false;
				$.ajax({
					url: "${pageContext.request.contextPath}/userExistsCheck",
					type: 'get',
					async: false,
					data: {
						userid: $(element).val().trim()
					},
					success: function (response) {
						result = (param === response);
					}, erorr: function (e) {
						console.log(e);
					}
				});
				return result;
			}, "User not found !");
			$.validator.addMethod("incorrectCaptcha2", function (value, element, param) {
				console.log(hex_md5("dd")); 
				var int1 = captchaValue;
				var int2 = value;
				if (int1 == int2) {
					return true;
				} 
				return false;
				 
			}, "Entered captcha is incorrect!");
		})
		
		// Initialize form validation on the myForm form element
		$("#form1").validate({
			// Specify validation rules
			rules: {
				userName: {
					required: true,
					userExistsCheck: 'exist'

				},
				password: {
					required: true,

				},
				captcha: {
					required: true,
					incorrectCaptcha2: true

				},

			},
			// Specify validation error messages
			messages: {
				userName: {
					required: "Please Enter Username",

				},
				password: {
					required: "Please Enter Password",

				},
				captcha: {
					required: "Please Enter Captcha",
					incorrectCaptcha2: "Entered captcha is incorrect!" 
				},


			},
			// Add Bootstrap 4 styling to the error messages
			errorElement: "span",
			errorClass: "invalid-feedback",
			highlight: function (element, errorClass, validClass) {
				$(element).addClass("is-invalid").removeClass("is-valid");
			},
			unhighlight: function (element, errorClass, validClass) {
				$(element).removeClass("is-invalid").addClass("is-valid");
			},

			submitHandler: function (form) { 
				var password = $("#password").val();
				$("#password").val(hex_md5(password)); 
				form.submit();

			},
		})

	</script>