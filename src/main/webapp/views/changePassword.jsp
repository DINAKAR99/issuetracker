<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
			<style>
				.label {
					font-weight: bold;
				}
			</style>
			<div class="container">
				<div>
					<h2 class="title pt-3">Change Password </h2>
				</div>

				<c:if test="${not empty updated}">
					<div class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
						role="alert">
						${updated}
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<c:if test="${not empty failuremsg}">
					<div class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
						role="alert">
						${failuremsg}
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
				</c:if>

				<form:form action="${pageContext.request.contextPath}/updateChangePassword" method="post"
					modelAttribute="emp" id="userId">

					<div class="row" style="justify-content: center;">
						<div class="form-group col-3">
							<label for="postCategoryName" class="label">Old Password<span
									class="text-red font-weight-bold" style="color: red;">*</span></label>
						</div>
						<div class="form-group col-6">
							<input type="password" name="" id="oldPassWordId" class="form-control validateClass"
								onchange="checkPassword(this.value,this.id)" placeholder="Old Password"
								autocomplete="off">
						</div>
					</div>
					<div class="row" style="justify-content: center;">
						<div class="form-group col-3">
							<label for="postCategoryName" class="label">New Password<span
									class="text-red font-weight-bold" style="color: red;">*</span></label>
						</div>
						<div class="form-group col-6">
							<input type="password" name="" id="newPassWordId" class="form-control validateClass"
								maxlength="10" placeholder="New Password" autocomplete="off" readonly="readonly">
						</div>
					</div>
					<div class="row" style="justify-content: center;">
						<div class="form-group col-3">
							<label for="postCategoryName" class="label">Confirm Password<span
									class="text-red font-weight-bold" style="color: red;">*</span></label>
						</div>
						<div class="form-group col-6">
							<input type="password" name="password" id="confirmPassWordId"
								class="form-control validateClass" maxlength="10" placeholder="Confirm Password"
								autocomplete="off" readonly="readonly">
						</div>
					</div>

					<input type="hidden" name="id" id="empId" value="${userid}">

					<div class="text-center mt-2">
						<button type="submit" class="btn btn-primary" id="updateId">Submit</button>
						<button type="reset" class="btn btn-warning">clear</button>
						<button type="button" class="btn btn-info" onclick="history.back()">Back</button>
					</div>

				</form:form>
				<br><br><br><br><br><br><br>
			</div>
			<script type="text/javascript">
				$('#updateId').click(function () {
					var i = 0;
					$(".validateClass").each(function () {
						if ($(this).val().trim() == '') {
							i++;
							$(this).css("border-color", "red");
						} else {
							$(this).css("border-color", "");
						}
					});

					if (i == 0) {
						var newPassWord = $("#newPassWordId").val();
						var confirmPassWord = $("#confirmPassWordId").val();
						if (newPassWord != confirmPassWord) {
							alert("Entered new password and confirmation passwords are not matching. Please Re-enter password");
							$("#newPassWordId").val("");
							$("#confirmPassWordId").val("");
							event.preventDefault();
						} else {
							if (!confirm('Are you sure you want to submit?'))
								event.preventDefault();
						}
					} else {
						alert("Please enter all required fields");
						event.preventDefault();
					}
				});

				function checkPassword(val, id) {
					var idVal = $("#empId").val();
					$.post("${pageContext.request.contextPath}/checkPassword?password=" + val + "&&id=" + idVal, function (data) {
						if (data == false) {
							alert("Old password you entered is incorrect");
							$("#" + id).val("");
							$("#" + id).css("border-color", "red").focus();
							$("#newPassWordId,#confirmPassWordId").attr('readonly', 'readonly');

						} else {
							$("#" + id).css("border-color", "");
							$("#newPassWordId,#confirmPassWordId").removeAttr('readonly');
						}
					});
				}


			</script>