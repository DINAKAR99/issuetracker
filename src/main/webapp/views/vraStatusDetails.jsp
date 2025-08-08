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
	<h2 class="title pt-3"> Status of VRA records update as on ${time}	</h2>
	</div>
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
	<div id="taskStatus" style="margin-top: 20px" class="table table-striped ">
	    <table id="taskStatusReport">
    <thead>
        <tr>
        	<th>Sl. No</th>
        	<th>User ID</th>
            <th>District</th>
            <th>No. of Vacancies</th>
            <th>No. of VRA Records</th>
            <th>No. of VRA records updated</th>
            <th>No.of VRA Pending for Update</th>
            <th>VRA Data Confirmed</th>
            <th>Vacancies Confirmed</th>
            
        </tr>
    </thead>
    <tbody>
	    <c:if test="${empty vraStatusList}">
		    <tr>
		    	<td class="text-center" colspan="5">No Data Found</td>
		    </tr>
	    </c:if>
	    <% int i=1; %>
	    <c:if test="${not empty vraStatusList}">
	        <c:forEach items="${vraStatusList}" var="vra">
	        		<tr>
	        			<td><%= i %></td>
			        	<td>${vra[0]}</td>
			        	<td>${vra[1]}</td>
	        			<td><a href="${pageContext.request.contextPath}/distVacancyDetails?dist_id=${vra[5]}" class="sum">${vra[2]}</a></td>
	        			<td><a href="${pageContext.request.contextPath}/vraDetails?dist_id=${vra[5]}" class="sum">${vra[3]}</a></td>
	        			<td  class="sum">${vra[4]}</td>
	        			<td  class="sum">${vra[6]}</td>
	        			<%-- <td>${vra[5]}</td>
	        			<td>${vra[6]}</td> --%>
	        			<td>NO</td>
	        			<td>NO</td>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
    <tfoot>
    <tr>
    <td colspan="3" style="text-align:center;font-weight: bold;">Total</td>
    <td class="total" style="text-align: left;"> </td>
    <td class="total" style="text-align: left;"></td>
    <td class="total" style="text-align: left;"></td>
    <td class="total" style="text-align: left;"></td>
    <td colspan="2"></td>
    </tr>
    </tfoot>
</table>
<br><br>
  </div>
</div>
<script>

$(document).ready(
		function() {
			function tally(selector) {
				$(selector).each(
						function() {
							var total = 0, column = $(this).siblings(
									selector).andSelf().index(this);
							$("#taskStatusReport tbody tr").each(function() {
										total += parseFloat($(
												'.sum:eq(' + column + ')',
												this).html()) || 0;
									});
							$(this).html(total);
						});
			}
			tally('td.total');

		});
		
		
$(document).ready(function() {
	var exportCol = [1,2,3,4,5,6,7,8];
    $('#taskStatusReport').DataTable( {
        dom: 'Blfrtip',
        scrollY: '630px',
        aLengthMenu: [
            [50, 100, 200],
            [50, 100, 200]
        ],
        iDisplayLength: 50,
        buttons : [{
				extend : 'copy',
				/* footer: true,
				text : '<i class="fa fa-files-o"></i>',
				titleAttr : 'Copy', */
				title : 'Status of VRA records',
			    exportOptions: {
			         columns: exportCol
			    }
			},
			{
				extend : 'excel',
				/* footer: true,
				text : '<i class="fa fa-file-excel-o"></i>',
				titleAttr : 'Excel', */
				title : 'Status of VRA records',
			    exportOptions: {
			         columns: exportCol
			    }

			},
			{
				extend : 'csv',
				/* footer: true,
				text : '<i class="fa fa-file-text-o"></i>',
				titleAttr : 'CSV', */
				title : 'Status of VRA records',
			    exportOptions: {
			         columns: exportCol
			    }
			},
			{
				extend : 'pdf',
				/* footer: true,
				text : '<i class="fa fa-file-pdf-o"></i>',
				titleAttr : 'PDF', */
				title : 'Status of VRA records',
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
				title : 'Status of VRA records',
			    exportOptions: {
			         columns: exportCol
			    }
			} ]
    } );
    $('table.docutils').attr('border', '1');
    
		
} );



</script>