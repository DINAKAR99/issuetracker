<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

   <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>

</head>
<body>
	<div class="container">
	
		<c:if test="${not empty successmsg}">
			<div class="alert alert-success alert-dismissible fade show text-center font-weight-bold" role="alert">
				${successmsg}
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:if>
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
	
		<form:form modelAttribute="employee" method="post"
			action="${pageContext.request.contextPath}/registerEmployee" onsubmit="return confirm ('Are you sure you want to submit?')">
			<div>
				<h2 class="title pt-3">Employee Registration Form</h2>
			</div>

			<br>
			<div class="form-group row">
				<label for="projectTypeId" class="col-sm-2 col-form-label align-left">Project
					Type:<font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<form:select path="projectTypeId" id="projectTypeId" class="form-control" required="required">
						<form:option value="">---Select Project Type ---</form:option>
						<form:options items="${projTypeList}"/>
					</form:select>
					<%-- <select name="projectTypeId" id="projectTypeId" class="form-control" required="required">
						<option value="">---Select Project Type ---</option>
						<c:forEach items="${list2}" var="notiInfos">
							<option value="${notiInfos.project_type_id}">${notiInfos.project_type_name}</option>
						</c:forEach>
					</select> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="role" class="col-sm-2 col-form-label align-left">Role: <font
					color="red" size="2">*</font></label>
				<div class="col-sm-10">
							<form:select path="role" class="form-control"  required="required" id="role">
							 <option value="">---Select Role ---</option>
							    <c:forEach items="${roles}" var="val" varStatus="status">
							        <c:choose>
							            <c:when test="${val.key eq employee.role.id}">
							                <option value="${val.key}" selected>${val.value}</option>
							            </c:when>
							            <c:otherwise>
							                <option value="${val.key}">${val.value}</option>
							            </c:otherwise>
							        </c:choose> 
							    </c:forEach>
							</form:select>
					
					<%-- <select name="role" id="role" required="required"
						class="form-control">
						<option value="">---Select Role ---</option>
						<c:forEach items="${list}" var="notiInfos">
							<option value="${notiInfos.id}">${notiInfos.roleName}</option>
						</c:forEach>
					</select> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="userid" class="col-sm-2 col-form-label align-left">Employee
					Id: <font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
				<form:input path="id" class="form-control" id="userid" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					placeholder="Enter Employee Id" required="required" autocomplete="off" onchange="isExisted(this.id,'Employee Id',this.value)"/>
					<%-- <input type="number" class="form-control" id="userid" name="id" value="${id}" maxlength="4"
						placeholder="Enter Employee Id" required="required" autocomplete="name"> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="userName" class="col-sm-2 col-form-label align-left">Employee
					Name: <font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<form:input path="userName" class="form-control" id="userName" oninput="this.value = this.value.toUpperCase()" 
					placeholder="Enter Employee Name" maxlength="20" required="required" autocomplete="off" onchange="isExisted(this.id,'Employee',this.value)"/>
					<%-- <input type="text" class="form-control" id="userName" oninput="this.value = this.value.toUpperCase()" 
						name="userName" value="${userName}" placeholder="Enter Employee Name" maxlength="20"
						required="required" autocomplete="off"> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="emailId" class="col-sm-2 col-form-label align-left">Email Id: <font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<form:input type="email" path="emailId" class="form-control" id="emailId" placeholder="Enter Email Id"
					pattern="^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$"
						required="required" autocomplete="off"/>
					
					<%-- <input type="email" class="form-control" id="emailId" 
						name="emailId" placeholder="Enter Email Id" value="${emailId}"
						pattern="^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$"
						required="required" autocomplete="off"> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="password" class="col-sm-2 col-form-label align-left">Password:
					<font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<form:input type="password" class="form-control" id="password" path="password"
					placeholder="Enter Password" required="required" autocomplete="off" maxlength="15"/>
					<%-- <input type="password" class="form-control" id="password" value="${password}"
						name="password" placeholder="Enter Password" required="required" autocomplete="off" maxlength="15"> --%>
				</div>
			</div>
			<div class="form-group row">
				<label for="mobileNumber" class="col-sm-2 col-form-label align-left">Mobile
					Number: <font color="red" size="2">*</font>
				</label>
				<div class="col-sm-10">
					<form:input type="text" path="mobileNumber" class="form-control" id="mobileNumber" pattern="[7-9]{1}[0-9]{9}" 
					placeholder="0-9" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
					required="required" autocomplete="off"/>
					<%-- <input type="text" class="form-control" id="mobileNumber" pattern="[7-9]{1}[0-9]{9}"  value="${mobileNumber}"
						name="mobileNumber" placeholder="0-9" maxlength="10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
						required="required" autocomplete="off"> --%>
				</div>
			</div>
			<div class="text-center mt-2">
			<c:choose>
				<c:when test="${employee.id != ''&& employee.id != null}">
					<input type="hidden" name="actionVal" value="updated">
					<button type="submit" class="btn btn-primary">Update</button>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="actionVal" value="registered">
					<button type="submit" class="btn btn-primary">Register</button>
				</c:otherwise>
			</c:choose>
			</div>
		</form:form>
	
	
	<hr>
	<div>
	<h2 class="title pt-3">Registered Employee Details</h2>
	</div>
	<div id="showModules" style="margin-top: 20px" class="table table-striped ">
	    <table id="taskReportTable">
    <thead>
        <tr>
        	<th>Sl. No</th>
        	<th>Employee Id</th>
            <th>Employee Name</th>
            <th>Email Id</th>
            <th>Mobile Number</th> 
            <th>Role Name</th>
            <th>Edit</th> 
            <th>Delete</th> 
            
        </tr>
    </thead>
    <tbody>
    <c:if test="${empty empList}">
    <tr>
    	<td class="text-center" colspan="5">No Data Found</td>
    </tr>
    </c:if>
    <% int i=1; %>
    <c:if test="${not empty empList}">
        <c:forEach items="${empList}" var="empData">
        
        		<tr>
        			<td><%= i %></td>
<%--         			<td><a href="${pageContext.request.contextPath}/taskReport/${taskReport.id}/${projectTask.id}">${projectTask.name}</a></td> --%>
					<td>${empData.id}</td>   <%-- <a href="viewEmployeeDetails?id=${empData.id}"><u>${empData.id}</u></a> --%>
        			<td>${empData.userName}</td>
        			<td>${empData.emailId}</td>
        			<td>${empData.mobileNumber}</td>
        			<td>${empData.role.roleName}
        			<td><a href="editEmployeeDetails?id=${empData.id}"><button type="button" class="btn btn-info btn-sm">Edit</button></a></td>
        			<td><a href="deleteEmpDetails?id=${empData.id}&&userName=${empData.userName}"><button type="button" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete?')">Delete</button></a></td>
        		</tr>
        		<% i=i+1; %>
        		
        </c:forEach>
    </c:if>
    
    </tbody>
</table>
  </div>
  </div>

<script>
var id = '${employee.id}';
if(id!='' && id!=null){
	document.getElementById("userid").readOnly = true;
}
var userName = '${employee.userName}';
function isExisted(idName,labelVal,textVal){
	var x = '${empList}';
	if(textVal != userName && x.includes("="+textVal+",")){
		alert(labelVal+" - '"+textVal+"' already exists");
		$("#"+idName).focus().val("");
		return false;
	}
}

$(document).ready( function () {
    $('#taskReportTable').DataTable();
    $('table.docutils').attr('border', '1');
		
} );
</script>
  
</body>
</html>