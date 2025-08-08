<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="${pageContext.request.contextPath}/sweetalert-2.1.2/sweetalert.min.js"></script>
<c:if test="${not empty userfailmsg}">
		<div
			class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${userfailmsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
<div class="container">

<div>
				<h2 class="title pt-3">Reset Password</h2>
			</div>
<br>

	<c:if test="${view_page eq 'main_page'}">
	<form:form action="forgotPassword" method="post" align="center">
	<div class="form-group row" style="align:center">
	<label for="username" class="col-sm-2 col-form-label" align="left">User Name:
	<font style="color:red; size:2">*</font></label>
	<div class="col-sm-7">
	<input type="text" id="username" name="userName" class="form-control" autocomplete="off" required oninput="this.value=this.value.toUpperCase()" onKeyup="validateuserName()"
	pattern="^[A-Za-z.]+$"/>
	<div>
						<span id="lblError" style="color: red"></span>
					</div>
	</div>
	</div>
	<br>
	<div class="text-cente">
	<button type="submit" class="btn btn-primary">Get OTP</button>
	</div>
	</form:form>
	</c:if>	
	<c:if test="${otp eq 'otp_page' }">
	<form:form action="validateotp" method="post" align="center">
	<div class="form-group row">
	<label for="otp" class="col-sm-2 col-form-label">Enter Otp:
	<font style="color:red; size:2">*</font></label>
	<div class="col-sm-7">
	<input type="number" id="otp" class="form-control" autocomplete="off" required maxlength="6" onKeyup="validate()"/>
	<div>
						<span id="otpError" style="color: red"></span>
					</div>
	</div>
	</div>
	<input type="text" name="userName" hidden value="${empName}"/>
	<input type="number" name="id" hidden value="${empId}"/>
	<input type="number" id="Otp" hidden value="${otpnumber}"/>
	</div>
	<br>
	<div align="center">
	<button type="submit" class="btn btn-primary" onclick="return validateOtp()">submit otp</button>
	</div>
	</form:form>
	</c:if>	
	<c:if test="${reset eq 'reset_page'}">
	<form:form align="center" action="confirmPassword" onsubmit="return confirm ('Are you sure you want to submit?')">
	<div class="form-group row">
	<label for="resetpassword" class="col-sm-2 col-form-label"> Password:<font style="color:red; size:2">*</font></label>
	
	<div class="col-sm-7">
	<input type="password" id="resetpassword" class="form-control" autocomplete="off" placeholder="enter new password" name="password" maxlength="5" required/>
	<i class="bi bi-eye-slash" id="togglePassword"></i>
	</div>
	<input type="text" name="userName" hidden value="${EmpName}"/>
	<input type="number" name="id" hidden value="${EmpId}"/>
	</div>
	<br>
	<div align="center">
	<button type="submit" class="btn btn-primary">submit</button>
	</div>
	</form:form>
	</c:if>			
</div>
<script>
function validateuserName(){
	var value=$("#username").val();
	 var lblError = document.getElementById("lblError");
	    lblError.innerHTML = "";
	    var expr = /^[A-Za-z.]+$/;
	  
	    if (!expr.test(value)) {
	        lblError.innerHTML = "*Invalid input ,the text box only allows alphabets and .";
	    }
}
function validateOtp(){
	var otpValue=$("#Otp").val();
	console.log(otpValue);
	var otpInput=$("#otp").val();
	console.log(otpInput);
	if(otpValue==otpInput){
		return true;
	}else{
		alert("please enter the correct otp");
		return false;
	}
}
function validate(){
	var otpvalue=$("#otp").val()
	var expression=/^[0-9]+$/;
	var otpError=document.getElementById("otpError");
	otpError.innerHTML="";
	if(!expression.test(otpvalue)){
		otpError.innerHTML = "*Invalid input ,otp contains only numbers";
	}
}
</script>