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
            <th>Type Of Recruitment</th>
            <th>Date Of Appointment</th> 
            <th>Education Qualification</th>
            <th>Present Status</th>
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
	        			<td>${vra.typeOfRecruitment}</td>
	        			<td><fmt:formatDate pattern = "dd-MM-yyyy" value = "${vra.dateOfAppointmnet}" /></td>
	        			<td>${vra.educationQualification}</td>
	        			<td>${vra.presentStatus}</td>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
</table>
<br><br>
  </div>
  
</div>

<script>

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