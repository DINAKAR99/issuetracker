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
	th {
/*   border-top: 1px solid #0000FF; */
/*   border-bottom: 1px solid #0000FF; */
  border-right: 1px solid #000000;
}	
</style>
<div class="">
	<div>
	<h2 class="title pt-3"> Vacancy Details </h2>
	</div>
	<c:if test="${not empty deleted}">
		<div
			class="alert alert-success alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${deleted}
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
	
	<div style="text-align: right">
		<a href="${pageContext.request.contextPath}/vacancyFormDetails/0"><button style="height: 40px; margin-right: 20px; width: 200px; font-weight: bold" 
		id="addNewFunId" class="btn btn-sm btn-info">+ Add New</button></a>
	</div>
	<div  style="margin-top: 20px" class="table table-striped ">
	    <table id="vacanciesReport">
    <thead style="background-color: #d3d8df;">
        <tr>	
        		<th rowspan="2">S No</th>
        		<th rowspan="2">Action</th>
                <th rowspan="2">Post Category</th>
                <th colspan="34" style="text-align: left;">Vacancies</th>
                <th rowspan="2">Min Qly Req</th>
                <th rowspan="2">Appointing Auth</th>
            </tr>
            <tr>
                <th>Total</th>
                <c:forEach items="${districtsList}" var="dist">
                 <th>${dist.distName}<br>${dist.distCode}</th>
                </c:forEach>
            </tr>
    </thead>
    <tbody>
	    <c:if test="${empty vacDetailsList}">
		    <tr>
		    	<td class="text-center" colspan="5">No Tasks Found</td>
		    </tr>
	    </c:if>
	    <% int i=1; %>
	    <c:if test="${not empty vacDetailsList}">
	        <c:forEach items="${vacDetailsList}" var="vac">
	        		<tr>
	        			<td><%= i %></td>
	        			<td><a href="${pageContext.request.contextPath}/vacancyFormDetails/${vac.sno}"><i class="fa fa-edit" style="font-size:24px"></i></a></td>
			        	<td  style="color: #00549d;font-weight: bold;">${vac.postCategoryName}</td>
			        	<td>${vac.totalVacancies}</td>
			        	<c:forEach items="${districtsList}" var="dist">
			        		<c:set var="dist1" value="d${dist.distCode}"></c:set>
			        		<td>${vac[dist1]}</td>
			        	</c:forEach>
	        			<td>${vac.minQualificationReq}</td>
	        			<td>${vac.appointingAuth}</td>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
</table>
<br><br><br><br>

<!-- <p style="color: red;text-align: center;">  <input type="checkbox">
 I confirm that the above data is verified and can be used for allotment process.
 <div class="text-center mt-2">
  <button type="submit" class="btn btn-primary">Submit</button>
  </div>
 </p>
  -->
  </div>
  
</div>

<script>
$(document).ready(function() {
	var exportCol = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,
		19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37];
    $('#vacanciesReport').DataTable( {
        dom: 'Blfrtip',
        scrollY: '630px',
        scrollX: true,
        
        scrollCollapse: true,
        paging:         false,
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
			} ]
    } );
    $('table.docutils').attr('border', '1');
    
		
} );
</script>