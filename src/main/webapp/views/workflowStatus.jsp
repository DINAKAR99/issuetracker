<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
 
 
  
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;400;500;700&display=swap" rel="stylesheet"> 
  <link rel="stylesheet" href="resources/css/font-awesome.min.css"/>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
<style>

</style>
<div class="container-fluid card shadow-lg p-3 mb-5 bg-white rounded">
	<div>
	<h2 class="title pt-3">CheckList Status</h2>
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
	
		<!-- <div class="text-right">
		<a href="/viewModule" class="btn btn-success">View Modules</a>
		</div> -->
	<form:form id="moduleForm" action="/moduleStatus" method="post" modelAttribute="workflow">
  <div style="margin-top: 20px">
	    <table id="myTable">
    <thead>
        <tr>
        	<th>Sl No.</th>
	         <th>Project Name</th>
            <th>Module Name</th>
            <th>Received from </th>
            <th>Received on </th>
            <th>Level</th>
             <th>Status</th>
            <th>View Tasks Status </th>
        </tr>
    </thead>
    <tbody>
    <c:if test="${empty workflowStatus}">
    <tr>
    	<td class="text-center" colspan="5">No Records Found</td>
    </tr>
    </c:if>
    <c:if test="${not empty workflowStatus}">
    <c:forEach items="${workflowStatus}" var="workflow" varStatus="counter">
		<tr>
			<td>${counter.count}</td>
			<td>${workflow.module.project.name}</td>
            <td>${workflow.module.moduleName}</td>
            <c:choose>
            	<c:when test="${not empty workflow.receivedFromName}">
            		<td>${workflow.receivedFromName}</td>	
            	</c:when>
            	<c:otherwise>
            		<td> -- </td>
            	</c:otherwise>
            </c:choose>
            
            <c:choose>
            	<c:when test="${not empty workflow.receivedOn}">
            		<td>${workflow.receivedOn}</td>
            	</c:when>
            	<c:otherwise>
            		<td> -- </td>
            	</c:otherwise>
            </c:choose>
            
			<c:choose>
            	<c:when test="${not empty workflow.level}">
            		<td>${workflow.level.name}</td>
            	</c:when>
            	<c:otherwise>
            		<td> -- </td>
            	</c:otherwise>
            </c:choose>
            
            <c:choose>
            	<c:when test="${not empty workflow.status}">
            		<td>${workflow.status}</td>	
            	</c:when>
            	<c:otherwise>
            		<td>--</td>
            	</c:otherwise>
            </c:choose>
            
			<td><a href="updateStatus/${workflow.module.id}/${workflow.module.project.id}"> <i class="fa fa-eye" aria-hidden="true"></i> View</a></td>
			<%-- <td><a id="viewTask" href="#" onclick="return viewTasks(${module.project.id},${module.id});" onkeypress=""> <i class="fa fa-eye" aria-hidden="true"></i>View</a></td> --%>
        </tr>    	
    </c:forEach>
    </c:if>
    </tbody>
</table>
  </div>
 
</form:form>
        </div>
        <script>
        
        function submitPro(){
        	$( "#moduleForm" ).submit();	
        }
        
        $("#viewTask").keydown(function(e){
    		e.preventDefault();
    	});
        
        $("#viewTask").keypress(function(e){
    		e.preventDefault();
    	});
        
       /* function viewTasks(projectId,moduleId){
        	//alert(">>>>>>>>>>>>>>>"+projectId);
        	//$("#viewTask").attr("href", "/viewTasks?moduleId="+moduleId);
        	$('#hiddenProject').val(projectId);
        	$('#hiddenModule').val(moduleId);
        	 $("#moduleForm").attr("method", "get");
        	$('#moduleForm').attr('action', "/viewTasks").submit();
        }*/
        $(document).ready( function () {
            $('#myTable').DataTable();
        } );
       
        </script>
        
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.smartmenus.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/sm-menu.js"></script>
