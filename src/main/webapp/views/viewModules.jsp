<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
   <script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
  
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
<style>
	.modal-lg {
    max-width: 80%;
}
.modal-dialog{
max-width: 1000px !important;
}

</style>
<div class="container">
	<div>
	<h4 class="text-primary text-center font-weight-bold">View Modules</h4>
	</div>
	
		<div class="text-right">
		<a href="/moduleStatus" class="btn btn-success">View Module Status</a>
		</div>	
	<form:form id="form1" action="/viewModule" method="post" modelAttribute="module">
	
	<div class="form-group">
            <label for="projectName">Select Project <font color="red" size="2">*</font></label>
           <form:select path="project"  id="projectName"	cssClass="form-control" required="required">
						<form:option disabled="disabled" value="">--select--</form:option>
						<c:if test="${not empty projects}">
								<c:forEach items="${projects}" var="p">
									<c:if test="${module.project.id eq p.id}">
									<option selected="selected" value="${p.id}">${p.name}</option>
									</c:if>
									<c:if test="${module.project.id ne p.id}">
									<option value="${p.id}">${p.name}</option>
									</c:if>
								</c:forEach>
							
						</c:if>
						</form:select>	
						<span>
						<form:errors path="project" cssClass="text-danger font-weight-bold"></form:errors></span>	
        </div>
        
        <div class="text-center">
  <button id="submitProject" type="submit" class="btn btn-primary">Submit</button>
  </div>
  <div id="showModules" style="margin-top: 20px">
	    <table id="modulesTable" class="display">
    <thead>
        <tr>
        	<th>Sl No.</th>
            <th>Module Name</th>
            <th>Module Description</th>
            <th>Module Start Date</th>
            <th>Module End Date</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    <c:if test="${empty modulesList}">
    <tr>
    	<td class="text-center" colspan="5">No Modules Found</td>
    </tr>
    </c:if>
    <c:if test="${not empty modulesList}">
    <c:forEach items="${modulesList}" var="module" varStatus="counter">
		<tr>
			<td>${counter.count}</td>
            <td>${module.moduleName}</td>
            <td>${module.moduleDescription}</td>
            <td>${module.moduleName}</td>
            <td>${module.moduleDescription}</td>
            <td>
            <button type="button" class="btn btn-primary" id="editModule${counter.count}" data-toggle="modal" data-target="#updateModuleModal" onclick="editModule(this.id)">Edit</button> 
            <button type="button" class="btn btn-danger" id="deleteModule${counter.count}" onclick="deleteModule(this.id,${module.id},${module.project.id})">Delete</button>
             </td>
        </tr>    	
    </c:forEach>
    </c:if>
    </tbody>
</table>
  </div>
  
  <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#updateModuleModal">
  Launch demo modal
</button> -->
</form:form>
<!-- Modal -->
<form:form action="/updateModule" method="post" modelAttribute="module">
<div class="modal fade" id="updateModuleModal" tabindex="-1" role="dialog" aria-labelledby="updateModuleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-primary text-center" id="updateModuleModalLabel">Update Module</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="width: 100%">
  
  	
  	
  	<div class="form-group">
            <label for="projectName">Select Project Name <font color="red" size="2">*</font></label>
           <form:select path="project"  id="projectName"	cssClass="form-control" required="required">
						<form:option disabled="disabled" value="">--select--</form:option>
						<c:if test="${not empty projects}">
								<c:forEach items="${projects}" var="p">
									<c:if test="${module.project.id eq p.id}">
									<option selected="selected" value="${p.id}">${p.name}</option>
									</c:if>
									<c:if test="${module.project.id ne p.id}">
									<option value="${p.id}">${p.name}</option>
									</c:if>
								</c:forEach>
							
						</c:if>
						</form:select>	
						<span>
						<form:errors path="project" cssClass="text-danger font-weight-bold"></form:errors></span>	
        </div>
    
    <form:hidden path="project" cssClass="form-control updateProject" id="updateProject" required="required" readonly="true"/>
    <form:errors path="project" cssClass="text-danger font-weight-bold"></form:errors>
  	    
  	 <div class="form-group">
    <label for="updateProject">Project Name <font color="red" size="2">*</font></label>
    <input type="text" class="form-control updateProject" value="" readonly="readonly"/>
    <form:errors path="project" cssClass="text-danger font-weight-bold"></form:errors>
  	</div>
  	
  	<div class="form-group">
    <label for="addModule">Module Name <font color="red" size="2">*</font></label>
    <form:input path="moduleName" cssClass="form-control" id="addModule" name="name" placeholder="Enter Module Name" required="required"/>
    <form:errors path="moduleName" cssClass="text-danger font-weight-bold"></form:errors>
  	</div>
  		
  	<div class="row">
  	
  	<div class="form-group col">
    <label for="moduleStartDate">Module Start Date<font color="red" size="2">*</font></label>
    <form:input path="moduleStartDate" cssClass="form-control" id="moduleStartDate" placeholder="Select Start Date" required="required" readonly="true"/>
    <form:errors path="moduleStartDate" cssClass="text-danger font-weight-bold"></form:errors>
  	</div>
  	
  	<div class="form-group col">
    <label for="moduleEndDate">Module End Date <font color="red" size="2">*</font></label>
    <form:input path="moduleEndDate" cssClass="form-control" id="moduleEndDate" name="name" placeholder="Select End Date" required="required" readonly="true"/>
    <form:errors path="moduleEndDate" cssClass="text-danger font-weight-bold"></form:errors>
  	</div>
  	
  	</div>
  	
   <div class="form-group">
    <label for="moduleDescription">Module Description <font color="red" size="2">*</font></label>
    <form:textarea path="moduleDescription" cssClass="form-control" id="moduleDescription" rows="3" placeholder="Description About Module" required="required"/>
    <form:errors path="moduleDescription" cssClass="text-danger font-weight-bold"></form:errors>
  </div>
	
	<div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-primary">Update Module</button>
      </div>
  
    </div>
  </div>
</div>
</div>
</form:form>
        </div>
        <script>
        $(document).ready( function () {
            $('#modulesTable').DataTable();
        		
        } );
        //$("#showModules").hide();        
        /* $("#deleteModule").click(function(){
        	  alert("The deleteModule was clicked.");
        	}); */
        	/* $("#submitProject").click(function(){
        		alert(">>>>>>>>>>>");
        		//$("#modulesTable").hide();
        		$("#showModules").show();
          	}); */
        	
        	function editModule(moduleId){
        		//alert("editModuleId is : "+moduleId);
        	}
        	
        	function deleteModule(formId,moduleId,projectId){
        		//alert("=========");
        	//alert("moduleId is : "+formId+" : "+moduleId+" : "+projectId);
        	
        	$.post(
    				"${pageContext.request.contextPath}/deleteModule"	, function(data, status) {
    					//$("select#" + id).html(data);
    					//window.location.reload();
    					console.log("status is : "+status);
    					console.log("status is : "+data);
    					if(status=="success" && data>0){
    						//alert("success");
    						$("#form1").submit()
    						document.getElementById("modulesTable").deleteRow(1);
    					}
    					document.getElementById("modulesTable").deleteRow(1);
    				
    					
    				});
        }
        	
        	
        	
        	function validateDate(){
        		console("$(#moduleStartDate).val()"+$("#moduleStartDate").val())
        		console("$(#moduleEndDate).val()"+$("#moduleEndDate").val())
        		if($("#moduleStartDate").val().trim()>=$("#moduleEndDate").val().trim()){
        			swal({
        				title : "Oops!",
        				text : "period from Date should not be greater than period to Date",
        				icon : "warning"
        			});
        			return false;
        		}
        		return true;
        	}
        </script>
