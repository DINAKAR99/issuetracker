<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script src="${pageContext.request.contextPath}/sweetalert-2.1.2/sweetalert.min.js"></script>
  <head>
  	<style type="text/css">
.rowpad {
	margin-right: 0px;
	margin-left: 0px;
}

.btn-primary {
	background-color: #00549d !important;
	border-color: #00549d !important;
}

input[type=submit] {
	padding: 8px !important;
	background-color: #00549d !important;
	border-color: #00549d !important;
}

.container {
	max-width: 1300px !important;
}
	.btn-sm{   
    font-size: 0.8rem !important;
    }   
</style>
  </head>
<div class="container">
	<div>
	<h2 class="title pt-3">CHECKLIST ACTIVITY </h2>
	</div>
	 <form action="${pageContext.request.contextPath}/taskReport" method="post">
		<input type="hidden" name="level" value="${workflow.level.id}">
		<input type="hidden" name="module" value="${workflow.module.id}">
		<input type="hidden" name="project"  value="${workflow.project.id}"/>
		<!-- <div class="text-right">
		<input type="submit" class="btn btn-success" value="View Task"/>
		<a href="/viewTask" class="btn btn-success">View Task</a>
		</div> -->
	</form>
	
	<c:if test="${not empty successmsg}">
	<div class="alert alert-success alert-dismissible fade show text-center font-weight-bold" role="alert">
	${successmsg}
	<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
  	</div>
	</c:if>
	
	<c:if test="${not empty failmsg}">
	<div class="alert alert-danger alert-dismissible fade show text-center font-weight-bold" role="alert">
	${failmsg}
	<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
  	</div>
	</c:if>
	
	<form:form id="updateStatusForm" action="${pageContext.request.contextPath}/updateStatus" method="post">
	
	<input type="hidden" name="prjectTypeId" id="prjectTypeId"/>
	<input type="hidden" name="projectId" id="projectId"/>
	<input type="hidden" name=levelId  id="levelId"/>
	<input type="hidden" name="remarks" id="remarks"/>
	<input type="hidden" name="taskId" id="taskId"/>
	
        
        <div style="margin: 15px 15px 15px 15px" class="form-row">
					<table class="table table-hover table-striped table-bordered"
						id="bPQueryRaiseProcess">
						<thead>
							<tr>
								<th>S.No.</th>
								<th>Project / Notification</th>
								<th>Stage</th>
								<th>Received From</th>
								<th>Assigned Date</th>
								<th>Status</th>
								<!-- <th>Forward To</th> -->
								<c:if test="${empty taskCompleted}">
								<th>Remarks</th>
								</c:if>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
					<c:if test="${empty employeeTasks}">
						<tr>
							<td class="text-center" colspan="8">No Tasks Found</td>
						</tr>
					</c:if>
					
					<c:forEach items="${employeeTasks}" var="employeeTask" varStatus="counter">
								<tr>
									<td>${counter.count}</td>
									<td>${employeeTask.project.name}</td>
									<td>${employeeTask.name} </td>
									<td>${employeeTask.receivedFrom}</td>
									<td>${employeeTask.assignedDate}</td>
									<td>${employeeTask.currentPhase}</td>
								
								<c:choose>

								<c:when test="${employeeTask.status=='completed'}">
									<td>
										${employeeTask.remarks}
									</td>
								</c:when>
								<c:otherwise>
									<td style="padding: 0px;">
									<c:if test="${empty taskCompleted}">
									<div class="form-group">	   					
	   					 <textarea class="form-control" id="remarks${employeeTask.id}" rows="2"></textarea>
					 			 </div></c:if>
									</td>
								</c:otherwise>
							</c:choose>
									
									
							<c:choose>

								<c:when test="${employeeTask.status=='completed'}">
									<td>
										<button class="btn btn-info btn-sm"
											onclick="return viewTaskReport(${employeeTask.id},${employeeTask.project.id});">View Report</button>
									</td>
								</c:when>
								<c:otherwise>
								
									<%-- <td><button class="btn btn-primary btn-sm" onclick="return forwardTask(${employeeTask.id},'remarks${employeeTask.id}',${employeeTask.levelId},${employeeTask.project.id});">${employeeTask.taskLableName}</button>
										<button class="btn btn-info btn-sm" onclick="return viewTaskReport(${employeeTask.id},${employeeTask.project.id});">View Report</button>
									</td> --%>
									<td>
            							<!-- <label for="forwardto">Forward to <font color="red" size="2">*</font></label>  -->
            							<c:choose>
            							<c:when test="${empty taskCompleted}">
            							<select name="forwardto" class="form-control" id="forwardto${employeeTask.id}" >
											<option value="0">--select Forward to--</option>
											<c:if test="${not empty employee1}">
												<c:forEach items="${employee1}" var="employeeTest">
													<option value="${employeeTest.userName}">${employeeTest.userName}-${employeeTest.role.roleName}</option>
												</c:forEach>
											</c:if>
										</select><br/>
										<button class="btn btn-primary btn-sm" onclick="return forwardTask(${employeeTask.id},'remarks${employeeTask.id}',${employeeTask.levelId},${employeeTask.project.id},${employeeTask.projectTypeId});">Forward</button>
										<button class="btn btn-info btn-sm" onclick="return viewTaskReport(${employeeTask.id},${employeeTask.project.id});">View Report</button>
										</c:when>
										<c:otherwise>
										
										<%-- <button class="btn btn-primary btn-sm" onclick="return closeTask(${employeeTask.levelId},${employeeTask.project.id});">${taskCompleted}</button> --%>
<%-- 										<a class="btn btn-primary btn-sm" onclick="return closeTask(${employeeTask.id},${employeeTask.levelId},${employeeTask.project.id},${employeeTask.projectTypeId});">${taskCompleted}</a> --%>
										<button class="btn btn-primary btn-sm" onclick="return closeTask(${employeeTask.id},${employeeTask.levelId},${employeeTask.project.id},${employeeTask.projectTypeId});">${taskCompleted}</button>
										</c:otherwise>
										</c:choose>
									</td>
								</c:otherwise>
							</c:choose>

							
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
  
        <!-- <div class="text-center mt-2" id="submitDiv" style="color: #00549d">
  <button type="submit" class="btn btn-primary" >Update Status</button>
  </div> -->
  
       </form:form>
     
     </div>
     <script> function closeTask(taskId,levelId,projectId,projectTypeId){
    	 
    	 if(!confirm("Do you really want to close?")) {
 		    return false;
 		  }
    	 
    	$("#taskId").val(taskId);
    	$("#levelId").val(levelId);
    	$("#projectId").val(projectId);
    	$("#prjectTypeId").val(projectTypeId);
//     	alert("entered");
    	return true;
     }</script>
     <script>
     
     function forwardTask(taskId,remarksId,levelId,projectId,prjectTypeId){
    	// alert("In remarks : "+$("#"+remarksId).val().trim());
    	// alert($("#forwardto"+taskId).val().trim() + " forward to");
    	 if($("#"+remarksId).val().trim()==""){
    		 
    		 swal({
 				title : "Oops!",
 				text : "Please Enter Remarks",
 				icon : "warning"
 			});
    		 
    		 return false;
    	 } else if($("#forwardto"+taskId).val().trim()=="0"){
    		 swal({
 				title : "Oops!",
 				text : "Please Select Forward to employee",
 				icon : "warning"
 			});
    		 
    		 return false;
    	 }
    	 
    	 if(!confirm("Do you really want to forward?")) {
    		    return false;
    		  }
    	 
    	$("#taskId").val(taskId);
    	$("#remarks").val($("#"+remarksId).val().trim());
    	$("#levelId").val(levelId);
    	$("#projectId").val(projectId);
    	$("#prjectTypeId").val(prjectTypeId);
    	return true;
     }
     
    
       
    
       function viewTaskReport(taskId,projectId){
     	  // alert(taskId);
     	   //alert(projectId);
     	   //$("#taskId").val(taskId);
     	   //$("#projectId").val(projectId);
     	   $('#updateStatusForm').prop('action', '${pageContext.request.contextPath}/taskReport/'+taskId+'/'+projectId);
     	   //$('#updateStatusForm').prop('method', 'GET');
     	   $('input').remove();
     	   return true;
        }
       
       
       
          </script>