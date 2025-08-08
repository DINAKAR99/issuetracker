<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
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
<div class="">
	<div>
	<h2 class="title pt-3"> VRAs </h2>
	</div>
	
	<c:choose>
		<c:when test="${not empty updated}">
			<div
				class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
				role="alert">
				${updated}
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:when>
		<c:when test="${not empty failuremsg}">
			<div
				class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
				role="alert">
				${failuremsg}
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
		</c:when>
		<c:otherwise>
			<c:if test="${status==1}">
				<p style="text-align: right;color: darkgreen;font-size: larger;">Data is successfully verified/confirmed and forwarded for allotment process.</p>
				<hr>
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:if test="${(status==0 || status==null) && genderNullData!=0}">
		<marquee behavior="scroll" direction="left" style="color: red;font-size: larger;" scrollamount="10"> Please update all vra's data to confirm/forward for allotment process.</marquee>
		<!-- <p style="text-align: right;color: red;font-size: larger;">Please update all vra's data to confirm/forward for allotment process.</p> -->
		<hr>
	</c:if>
	<div id="taskStatus" style="margin-top: 20px" class="table table-striped ">
	    <table id="taskStatusReport">
    <thead>
        <tr>
        	<th>Sl. No</th>
            <th>District</th>
            <th>Working Mandal</th>
            <th>Native Mandal</th>
            <th>Name of the VRA</th>
            <th>Father's/Husband's Name</th>
            <th>Gender</th>
            <th>Date Of Birth</th>
           <!--  <th>Type Of Recruitment</th> -->
            <th>Date Of Appointment</th> 
            <th>Education Qualification</th>
            <th>Present Status</th>
            <th>Undertaking Given For Regularization</th> 
            <!-- <th>Uploaded Doc</th> -->
            <c:if test="${status==0 || status==null}">
            <th>Edit Personal Details</th> 
            <th>Options</th>  	
           	</c:if>
        </tr>
    </thead>
    <tbody>
	    <c:if test="${empty vraDetailsList}">
		    <tr>
		    	<td class="text-center" colspan="12">No Tasks Found</td>
		    </tr>
	    </c:if>
	    <% int i=1; %>
	    <c:if test="${not empty vraDetailsList}">
	        <c:forEach items="${vraDetailsList}" var="vra">
	        		<tr>
	        			<td><%= i %></td>
			        	<td>${vra.distMaster.distName}</td>
			        	<td>${vra.mandalMaster.mandalName}</td>
			        	<td>${vra.nativeMandalMast.mandalName}</td>
	        			<td>${fn:replace(vra.name, '.', ' ')}</td>
	        			<td>${vra.fatherName}</td>
	        			<td>${vra.gender}</td>
	        			<td> <fmt:formatDate pattern = "dd-MM-yyyy" value = "${vra.dateOfBirth}" /> </td>
	        			<%-- <td>${vra.typeOfRecruitment}</td> --%>
	        			<td><fmt:formatDate pattern = "dd-MM-yyyy" value = "${vra.dateOfAppointmnet}" /></td>
	        			<td>${vra.educationQualification}</td>
	        			<td>${vra.presentStatus}</td>
	        			<td>${vra.underTakingGiven}</td>
	        			<%-- <td>
		        			<c:choose>
		        				<c:when test="${vra.underTakingDocument!=null}">
		        					<a target="_blank" href="${pageContext.request.contextPath}/preview/${vra.underTakingDocument}">View</a> 
		        				</c:when>
		        				<c:otherwise>
		        					-
		        				</c:otherwise>
		        			</c:choose>
	        			</td>  --%>
	        			<c:if test="${status==0 || status==null}">
	        				<td><a href="${pageContext.request.contextPath}/vraFormDetails/${vra.sno}"><i class="fa fa-edit" style="font-size:24px"></i></a></td>
	        				<td><a href="${pageContext.request.contextPath}/vraOptions/${vra.sno}"><i class="fa fa-edit" style="font-size:24px"></i></a></td>
	        			</c:if>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
</table>
<br><br>
<c:if test="${(status==0 || status==null) && genderNullData==0}">
	<form action="${pageContext.request.contextPath}/updateFinalStatus" method="post" id="vraDetId">
		<p style="color: red;text-align: center;">  <input type="checkbox" id="confirmId">
			<input type="hidden" name="statusType" value="VRA">
			<input type="hidden" name="redirectAction" value="${redirectAction}">
		 	<label for="confirmId">I confirm that the above data is verified and can be used for allotment process.</label>
			 <div class="text-center mt-2">
			  <button type="submit" class="btn btn-primary" id="submitId" style="border-color: darkgreen;">Submit</button>
			  </div>
		 </p>
	</form>
</c:if>
  </div>
  
</div>

<script>

$('#submitId').click(function(){
	if($('#confirmId').is(':checked')){
		if( !confirm('Are you sure you want to submit?') )
			 event.preventDefault();
	}else{
		alert("Please select the checkbox to confirm the data");
// 		$("#confirmId").focus();
		return false;
	}
});

$(document).ready(function() {
	var exportCol = [1,2,3,4,5,6,7,8,9,10];
    $('#taskStatusReport').DataTable( {
        dom: 'Blfrtip',
        scrollY: '630px',
        aLengthMenu: [
            [50, 100, 200],
            [50, 100, 200]
        ],
        iDisplayLength: 100,
        buttons : [{
				extend : 'copy',
				/* footer: true,
				text : '<i class="fa fa-files-o"></i>',
				titleAttr : 'Copy', */
			    exportOptions: {
			         columns: exportCol
			    }
			},
			{
				extend : 'excel',
				/* footer: true,
				text : '<i class="fa fa-file-excel-o"></i>',
				titleAttr : 'Excel', */
			    exportOptions: {
			         columns: exportCol
			    }

			},
			{
				extend : 'csv',
				/* footer: true,
				text : '<i class="fa fa-file-text-o"></i>',
				titleAttr : 'CSV', */
			    exportOptions: {
			         columns: exportCol
			    }
			},
			{
				extend : 'pdf',
				/* footer: true,
				text : '<i class="fa fa-file-pdf-o"></i>',
				titleAttr : 'PDF', */
				orientation : 'landscape',
			    exportOptions: {
			         columns: exportCol
			    }
			},
			{
				extend : 'print',
				/* footer: true,
				 className: 'footer',
				text : '<i class="fa fa-print"></i>',
				titleAttr : 'print', */
			    exportOptions: {
			         columns: exportCol
			    }
			} ]
    } );
    $('table.docutils').attr('border', '1');
    
		
} );
</script>