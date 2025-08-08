<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@ page import="java.util.Date, java.util.Calendar" %>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>

	<c:set var="todayDate" value="<%=new Date()%>"/>
	<div class="container-fluid">
	<div>
	<h2 class="title pt-3"> Exception Report</h2>
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
	
<div id="showModules" style="margin-top: 20px" class="table table-striped ">
	    <table id="taskReportTable">
    <thead>
        <tr>
        	<th>Sl. No</th>
            <th>Notification Name</th>
            <th>Current Stage</th>
            <th>Target Date</th>
            <th>Schedule Adherence</th> 
            
        </tr>
    </thead>
    <tbody>
    <c:if test="${empty projects}">
    <tr>
    	<td class="text-center" colspan="5">No Tasks Found</td>
    </tr>
    </c:if>
    <c:if test="${not empty projects}">
	<% int i=1; %>    	
    	<c:forEach items="${projects}" var="project" varStatus="counter" >
    		
    		<c:forEach items="${project.task}" var="task">
    			
    		<tr>
			<td><%= i %></td>
            <td>${project.name}</td>            
            <td>${task.name}</td>
            <td>           
								<fmt:formatDate value="${task.devCompletiondate}" var="newParsedDate" type="date" pattern="dd-MM-yyyy" scope="request"/>
								${newParsedDate}
								
            </td>
            <td>
            	<c:if test="${task.status=='completed'}">completed</c:if>
            	
            	<c:if test="${task.status=='pending'}">
            <%
            	if(request.getAttribute("newParsedDate") != null) {

            					String taskTargetdate = request.getAttribute("newParsedDate").toString();

            					String dateStr = taskTargetdate;

            					SimpleDateFormat formater = new SimpleDateFormat("dd-MM-yyyy");
            					Date result = formater.parse(request.getAttribute("newParsedDate").toString());
            					/* out.println(new Date().getDate() - result.getDate()); */ 
            					int dateDifference = new Date().getDate() - result.getDate();
            					Calendar cal = Calendar.getInstance();

            					try {
            						cal.setTime(formater.parse(dateStr));
            					} catch (ParseException e) {
            						e.printStackTrace();
            					}
            					cal.add(Calendar.DAY_OF_MONTH, dateDifference);
            					String dateAfter = formater.format(cal.getTime());
            					if(dateDifference>0){
            						out.println("Delayed by "+dateDifference+" days");	
            					}else if(dateDifference<=0){
            						out.println("pending");
            					}
            					
            				}
            %>
            </c:if>
								</td>
            </tr>  
        <% i=i+1; %>
    		</c:forEach>
    		
        </c:forEach>
    
    </c:if>
    </tbody>
</table>
  </div>
  </div>

<script>
$(document).ready( function () {
    $('#taskReportTable').DataTable();
    $('table.docutils').attr('border', '1');
		
} );
</script>
