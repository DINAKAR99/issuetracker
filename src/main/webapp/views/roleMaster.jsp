<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="${pageContext.request.contextPath}/sweetalert-2.1.2/sweetalert.min.js"></script>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<div class="container">
<c:if test="${not empty failmsg}">
		<div
			class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${failmsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<c:if test="${not empty failuremsg}">
		<div
			class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${failuremsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<c:if test="${not empty msgdeleted}">
		<div
			class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${msgdeleted}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<c:if test="${not empty updated}">
		<div
			class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${updated}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<c:if test="${not empty successmsg}">
		<div
			class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${successmsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
<form:form action="${pageContext.request.contextPath}/insertAndupdateRole"
 align="center" onsubmit="return confirm ('Are you sure you want to submit?')">
<div>
	<h2 class="title pt-2">Role Master</h2>
</div>
<div class="form-group row">
				 <label for="rolename"
					class="col-sm-2 col-form-label align-left">Role Name: <font
					color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="rolename"
						name="roleName" maxlength="30" pattern="^[A-Za-z-\s]+$"
						placeholder="Enter Role Name" required="required"
						autocomplete="off" oninput="this.value=this.value.toUpperCase()" onkeyup="Validaterolename();"> <br>
					<div>
						<span id="lblError" style="color: red"></span>
					</div>
				</div>
			</div>
			<input type="number" id="roleid" name="id" hidden/>
			<div class="form-group row">
				 <label for="rolediscription"
					class="col-sm-2 col-form-label align-left">Role Description:
					 <font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="rolediscription"
						name="roleDescription" maxlength="30" pattern="^[A-Za-z-\s]+$"
						placeholder="Enter Role Name description" required="required"
						autocomplete="off"  onkeyup="Validaterolediscription();" oninput="this.value=this.value.toUpperCase()"> <br>
					<div>
						<span id="lblError1" style="color: red"></span>
					</div>
				</div>
			</div>
			<div class="text-center mt-2">
				<button type="submit" class="btn btn-primary" id="editrole" >Submit</button>
			</div>
			<div>
				<h2 class="title pt-3"><hr>Active Roles List</h2>
			</div>
			<div id="roles" style="margin-top: 20px"
				class="table table-striped ">
				<table id="rolesReport" class="table">
					<thead>
						<tr>
							<th>Sl. No</th>
							<th>Role Name</th>
							<th>Role Description</th>
							<th>Edit</th>
							<th>Delete</th>

						</tr>
					</thead>
					<tbody>
						<c:if test="${empty rolemaster}">
							<tr>
								<td class="text-center" colspan="5">No Tasks Found</td>
							</tr>
						</c:if>
						<%
						int j = 1;
						%>
						<c:if test="${not empty rolemaster}">
							<c:forEach items="${rolemaster}" var="role">
								<tr>
									<td><%=j%></td>
									<td style="text-align: left;">${role.roleName}</td>
									<td style="text-align: left;">${role.roleDescription}</td>
									<td><button type='button' class='btn btn-info'
											onclick='editRole(${role.id});'>Edit</button></td>
									<td><a href="deleteRole/${role.id}"><button
												type='button' class='btn btn-danger'
												onclick="return confirm ('Are you sure you want to delete?')">Delete</button></a></td>
								</tr>
								<%
								j = j + 1;
								%>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
</form:form>
<script type="text/javascript">
$(document).ready(function() {
    $('#rolesReport').DataTable( {
    	
    
});
});
function editRole(roleid){
	$.post('editRoleandDescription?roleId='+roleid,function(data){
		for(var i=0;i<data.length;i++){
			var id=data[i].id;
			var rolename=data[i].roleName;
			var description=data[i].roleDescription;
			$("#rolename").val(rolename);
			$("#rolediscription").val(description);
			$("#roleid").val(id);
		}
		document.getElementById("rolename").focus();
		document.getElementById("rolediscription").focus();
		$("#editrole").html('Update');
	});
	console.log($("#roleid").val());
}
function Validaterolename() {
    var n = document.getElementById("rolename").value;
    var lblError = document.getElementById("lblError");
    lblError.innerHTML = "";
    var expr = /^[A-Za-z-\s]+$/;
  
    if (!expr.test(n)) {
        lblError.innerHTML = "*Invalid input ,the text box only allows alphabets and hypen(-).";
    }

  
}
function Validaterolediscription() {
    var n = document.getElementById("rolediscription").value;
  var lblError = document.getElementById("lblError1");
    lblError.innerHTML = "";
    var expr = /^[A-Za-z-\s]+$/;
  
    if (!expr.test(n)) {
        lblError.innerHTML = "*Invalid input ,the text box only allows alphabets and hypen(-).";
    }

   
}
/*function validate(){
	const mySentence =document.getElementById("rolediscription").value;

	const finalSentence = mySentence.replace(/(^\w{1})|(\s+\w{1})/g, letter => letter.toUpperCase());
	$("#rolediscription").val(finalSentence);
}*/
</script>
</div>
