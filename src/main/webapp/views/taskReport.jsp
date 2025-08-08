<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.js"></script>
  <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
  
   <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.print.min.js"></script>
    
    <style type="text/css">
	.dt-buttons{
		text-align: center !important;
	}
</style>

<!-- <script src="sweetalert-2.1.2/sweetalert.min.js"></script> -->

<div class="container-fluid">
	<div>
	<h2 class="title pt-3"> Task Report</h2>
	</div>
	
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
	
	<form:form id="taskForm" action="/taskReport" method="post" modelAttribute="task">
	
	 <%-- <div class="form-group">
            <label for="projectName">Select Project <font color="red" size="2">*</font></label>
           <form:select path="project"  id="projectName"	class="form-control" required="required" onchange="getModulesByProject(this.value)">
						<option value="">--select--</option>
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
        </div> --%> 
        
  	<%-- <div class="form-group">
            <label for="moduleId">Select Module <font color="red" size="2">*</font></label>
           <form:select path="module"  id="moduleId"	class="form-control" required="required" >
						<option value="">--select--</option>
				</form:select>	
        </div> --%>
        
        <input id="hiddenModule" type="hidden" name="moduleId">
        <input id="hiddenProject" type="hidden" name="projectId">
        
  <!-- <div class="text-center">
  <button type="submit" class="btn btn-primary">Submit</button>
  </div> -->
	</form:form>
<div id="showModules" style="margin-top: 20px" class="_table _table-striped ">
	    <table id="taskReportTable">
    <thead>
        <tr>
        	<th>Sl No.</th>
        	<th>Project / Notification</th>
            <th>Task Name</th>
            <th>Status</th>
            <th>Received From</th>
            <th>Forward To</th> 
            <th>Received On</th>
            <th>Remarks</th>
            <!-- <th>Document</th> -->
           
        </tr>
    </thead>
    <tbody>
    <c:if test="${empty taskList}">
    <tr>
    	<td class="text-center" colspan="5">No Tasks Found</td>
    </tr>
    </c:if>
    <c:if test="${not empty taskList}">
    
    	
    	<c:forEach items="${taskList}" var="tasks" varStatus="counter" >
    		
    		<tr>
			<td>${counter.count}</td>
			<td>${tasks.projectName}</td>
            <td>${tasks.name}</td>            
            <td>${tasks.status}</td>
            <td>${tasks.receivedFrom}</td>
            <td>${tasks.forwardTo}</td>
            <td>${tasks.assignedDate}</td>
            <td>${tasks.remarks}</td>
            <%-- <td><a target="_blank" href="${pageContext.request.contextPath}/preview/${taskFileUploads.filePath}">View</a> </td> --%>
        </tr>  
        </c:forEach>
    
    </c:if>
    </tbody>
</table>
  </div>
  </div>
  
<script>
$(document).ready(function() {
    $('#taskReportTable').DataTable( {
        dom: 'Blfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    } );
    $('table.docutils').attr('border', '1');
    
		
} );


function deleteTask(id,taskid,taskStatus){
	//alert(taskStatus);
	$.post({
			url : "${pageContext.request.contextPath}/deleteTask?taskid="+taskid,
					
			success : function(data, status, xhr) {
				if(data!=null && data!= "") {
				window.location.reload();
              }else{
            	  swal({
  					title : "Oops!!",
  					text : "The Selected project doesn't contain any Module .",
  					icon : "info"
  				});
              }
			}
	});
}
function getModulesByProject(projectId){
  	//alert("projectId : "+projectId);
  	 $("option[class='optionVal']").remove(); 
  	$.post({
  			url : "${pageContext.request.contextPath}/getModulesByProject?projectId="+projectId,
  					
  			success : function(data, status, xhr) {
  				if(data!=null && data!= "") {
  				for( var i = 0; i<data.length; i++){
                      var id = data[i].id;
                      var name = data[i].moduleName;
                      
                      $("#moduleId").append("<option class='optionVal' value='"+id+"'>"+name+"</option>");
  				}
                  }else{
                	  swal({
      					title : "Oops!!",
      					text : "The Selected project doesn't contain any Module .",
      					icon : "info"
      				});
                  }
  			}
  	});
  }
</script>
