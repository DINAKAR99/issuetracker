<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
	<h2 class="title pt-3"> VRA Allotment </h2>
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
	<div class="container">	
	<form:form action="${pageContext.request.contextPath}/vraAllotment" method="post" id="vacDetId" modelAttribute="vraDet">

		<div class="row" style="justify-content: center;">
			<div class="form-group col-2" style="text-align: center;">
				<label for="nativeDistrictCode">Districts <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			</div>
			<div class="form-group col-5">
				
				    <form:select path="districtCode"  id="distId" cssClass="form-control" 
				    		onchange="getSelectBox(this.value)" autofocus="autofocus" >
							 	<form:option disabled="disabled" value="0">--select District--</form:option>
							 	<form:options items="${districtsList}"></form:options>
					</form:select>
					<input type="hidden" name="allotmentVar" id="allotmentVarId">
			</div>
			<c:if test="${vraDet.districtCode!=null && vraDet.districtCode!=''}">
			<c:choose>
				<c:when test="${vacancyStatus!=1 && vraStatus!=1 && allotmentStatus!=1}">
					<div class="form-group col-4">
			   			<p style="text-align: right;color: red;text-align: justify;">Vacancies and vra's are not confirmed / forwarded for allotment process.</p>
			 		</div>
				</c:when>
				<c:when test="${vacancyStatus!=1 && allotmentStatus!=1}">
					<div class="form-group col-4">
			   			<p style="text-align: right;color: red;text-align: justify;">Vacancies are not confirmed / forwarded for allotment process.</p>
			 		</div>
				</c:when>
				<c:when test="${vraStatus!=1 && allotmentStatus!=1}">
					<div class="form-group col-4">
			   			<p style="text-align: right;color: red;text-align: justify;">Vra's are not confirmed / forwarded for allotment process.</p>
			 		</div>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${finalAllotmentStatus!=1}">
								<div class="form-group col-1">
						   			<button type="submit" class="btn btn-primary submitClass" style="width: 85px;" value="Allot">Allot</button>
						 		</div>
					 			<c:if test="${allotmentStatus==1}">
				 					<div class="form-group col-3">
							   			<button type="submit" class="btn btn-info submitClass" style="width: 150px;" value="Final Allot">Final Allot</button>
							 		</div>
						 		</c:if>
					 	</c:when>
					 	<c:otherwise>
					 			<div class="form-group col-3">
							        <c:if test="${vraDet.districtCode!=null && vraDet.districtCode!=''}">
							      <a  class=" btn btn-block btn-info" href="generatePdf/${vraDet.districtCode}">Download Orders</a>
							      </c:if>
							 	</div>
							 	<div class="form-group col-2">
							 		<p style="text-align: right;color: red;text-align: justify;">Final Allotment is done.</p>
							 	</div>
					 		</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			 </c:if>
			 <!-- <div class="form-group col-2">
			   <button type="submit" class="btn btn-info submitClass" value="Final Allot">Final Allot</button>
			 </div> -->
	  	</div>
  	</form:form>
  	<br>
  </div>
	<c:if test="${vraDet.districtCode!=null && vraDet.districtCode!=''}">
	<hr>
	<div id="taskStatus" style="margin-top: 20px" class="table table-striped ">
	    <table id="vraAllotmentReport">
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
            <th>Date Of Appointment</th> 
            <th>Education Qualification</th>
            <th>Present Status</th>
            <th>Post Name</th>
            <th>Name of the Department</th>
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
	        			<td><fmt:formatDate pattern = "dd-MM-yyyy" value = "${vra.dateOfAppointmnet}" /></td>
	        			<td>${vra.educationQualification}</td>
	        			<td>${vra.presentStatus}</td>
	        			<td>${vra.postName}</td>
	        			<td>${vra.hodMaster.hodName}</td>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
</table>
<br><br>
  </div>
 </c:if>
  
</div>

<script>
$(document).ready(function() {
	var exportCol = [0,1,2,3,4,5,6,7,9,11,12];
    $('#vraAllotmentReport').DataTable( {
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
<script type="text/javascript">
$('.submitClass').click(function(){
// 	var submitVal = $(this).val();
		if($("#distId").val()==0){
			alert("Please Select District");
			return false;
		}else{
			$("#allotmentVarId").val($(this).val());
			 if( !confirm('Are you sure you want to allot?') ) 
				 event.preventDefault();
		}
});

$('#distId').change(function(){
	if($(this).val()!=0){
		$("#vacDetId").submit();
	}
});
</script>