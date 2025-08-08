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
	th {
/*   border-top: 1px solid #0000FF; */
/*   border-bottom: 1px solid #0000FF; */
  border-right: 1px solid #000000;
}	
.blink {
            animation: blinker 5.5s linear infinite;
            color: red;
            font-family: sans-serif;
        }
        @keyframes blinker {
            50% {
                opacity: 0;
            }
        }
</style>
<div class="container">
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
				<p style="text-align: right;color: darkgreen;font-size: larger;">Vacancies are submitted and forwarded for allotment process.</p>
				<hr>
			</c:if>
		</c:otherwise>
	</c:choose>
	
	<c:if test="${(status==0 || status==null) &&  authMstCnt == 0}">
		<marquee behavior="scroll" direction="left" style="color: red;font-size: larger;" scrollamount="10" class="blink"> Please update all vacancies data to confirm/forward for allotment process.</marquee>
		<!-- <p style="text-align: right;color: red;font-size: larger;">Please update all vra's data to confirm/forward for allotment process.</p> -->
		<hr>
	</c:if>

	<div class="table table-striped ">
	<form:form action="${pageContext.request.contextPath}/updateDistVacancyDetails" method="post" id="authMst" modelAttribute="authMst">
	    <table style="width: inherit;">
    <thead style="background-color: #d3d8df;">
        <tr>	
        		<th>S No</th>
        		<th style="width: 380px;">Name of the Department</th>
                <th style="width: 300px;">Post Category</th>
                <c:if test="${status==0 || status==null}">
	                <th style="width: 380px;">Reporting Officer<span class="text-red font-weight-bold " style="color: red;">*</span></th>
	                <th style="width: 200px;">Min. Qualification<span class="text-red font-weight-bold " style="color: red;">*</span></th>
	                <th>Vacancies<span class="text-red font-weight-bold " style="color: red;">*</span></th>
               </c:if>
               <c:if test="${status==1}">
               		<th style="width: 380px;">Reporting Officer</th>
	                <th style="width: 200px;">Min. Qualification</th>
	                <th>Vacancies</th>
               </c:if>
            </tr>
    </thead>
    <tbody>
	    <c:if test="${empty authMst.vacDetailsList}">
		    <tr>
		    	<td class="text-center" colspan="6">No Tasks Found</td>
		    </tr>
	    </c:if>
	    <% int i=1; %>
	    <c:if test="${not empty authMst.vacDetailsList}">
	        <c:forEach items="${authMst.vacDetailsList}" var="vac">
	        		<tr>
	        			<td><%= i %></td>
	        			<%-- <td><a href="${pageContext.request.contextPath}/vacancyFormDetails/${vac[0]}"><i class="fa fa-edit" style="font-size:24px"></i></a></td> --%>
			        	<td  style="color: #00549d;font-weight: bold;">${vac.hodName}</td>
			        	<td>${vac.postCategoryName}</td>
			        	<c:if test="${status==0 || status==null}">
				        	<td><input type="text" name="appointingAuth" class="form-control validateClass" 
						    	 value="${vac.appointingAuth}" onkeypress="javascript:return allowAlphabetsAndNumbersAndComma(event);"
						    	maxlength="100" placeholder="Enter Authority Name" autocomplete="off">
					    	</td>
					    	<td> 
					    		<input type="hidden" value="${vac.minQualificationReq}" class="eduQualClass">
					    		<form:select path="minQualificationReq" id="minEduQual" cssClass="form-control minEduQual" autofocus="autofocus" >
									 	<form:option disabled="disabled" value="">--select--</form:option>
									 	<form:options items="${educationTypes}"></form:options>
								</form:select>
					    	</td>
				        	<td><input type="text" name="vacancies" class="form-control validateClass" 
						    	placeholder="Enter Vacancies" value="${vac.vacancies}"
						    	maxlength="3" onkeypress="javascript:return integersOnly(event);" autocomplete="off">
						    	<input type="hidden" name="sno" value="${vac.vacPostCatId}">
						    	<input type="hidden" name="hodId" value="${vac.hodId}">
						    	<%-- <input type="hidden" name="distId" value="${distId}"> --%>
						    	<input type="hidden" name="postCategoryName" value="${vac.postCategoryName}">
						    	<%-- <input type="hidden" name="postCategory[]" value="${vac[2]}"> --%>
					    	</td>
					    </c:if>
					    <c:if test="${status==1}">
					    	<td>${vac.appointingAuth}</td>
					    	<td>${vac.minQualificationReq}</td>
				        	<td>${vac.vacancies}</td>
					    </c:if>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	        <c:if test="${status==0 || status==null}">
		        <tr>
		        	<td colspan="6">
		        	 <div class="text-center mt-2">
		        	 <button type="submit" class="btn btn-primary" id = "updateId">Update</button>
		        	 </div>
		        	 </td>
		        </tr>
		     </c:if>
	    </c:if>
    </tbody>
    
</table>
		 <%-- <div class="text-center mt-2">
		 		<input type="hidden" name="distId" value="${distId}">
			  <button type="submit" class="btn btn-primary" id = "updateId">Submit</button>
			  <!-- <button type="reset" class="btn btn-warning">clear</button> -->
		 </div> --%>
		</form:form>
		<br>
<c:if test="${(status==0 || status==null) && authMstCnt>0}">
	<form action="${pageContext.request.contextPath}/updateFinalStatus" method="post" id="vraDetId">
		<p style="color: red;text-align: center;">  <input type="checkbox" id="confirmId">
			<input type="hidden" name="statusType" value="Vacancies">
			<input type="hidden" name="redirectAction" value="${redirectAction}">
		 	<label for="confirmId">I confirm that the above data is verified and can be used for allotment process.
		 	<button type="submit" class="btn btn-info" id="submitId" style="border-color: darkgreen;">Submit</button></label>
		 </p>
	</form>
</c:if>
  </div>
  <br><br><br><br>
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
function integersOnly(evt) {
	var theEvent = evt || window.event;
	var key = theEvent.keyCode || theEvent.which;
	var keyVal = String.fromCharCode(key);
	var regex = /[0-9]/;
	if (evt.shiftKey)
		return false;
	if (!regex.test(keyVal) && ![ 8, 16, 20, 35, 36, 37, 38, 39 ].includes(key)) {
		theEvent.returnValue = false;
		if (theEvent.preventDefault)
			theEvent.preventDefault();
	}
}

$('#updateId').click(function(){
	var i = 0;
	$(".validateClass").each(function() {
		  if($(this).val().trim()==''){
			  i++;
			  $(this).css("border-color", "red");
		  }else{
			  $(this).css("border-color", "");
		  }
	});
	$(".minEduQual").each(function() {
		  if($(this).val()==''){
			  i++;
			  $(this).focus();
			  return false;
		  }
	});
	
	if(i==0){
		 if( !confirm('Are you sure you want to update?') ) 
			 event.preventDefault();
	}else{
		alert("Please enter all required fields");
		 event.preventDefault();
	} 
});

function allowAlphabetsAndNumbersAndComma(e) {
	  var code = ('charCode' in e) ? e.charCode : e.keyCode;
//	  alert(code);
	  if (!(code == 40) && !(code == 41) && !(code == 44)
			  && !(code == 46) &&
			  !(code == 47) && !(code == 95) && !(code == 92) &&
			  !(code == 32) &&// space
			  !(code == 45) &&
			  !(code > 47 && code < 58) &&
	    !(code > 64 && code < 91) && // upper alpha (A-Z)
	    !(code > 96 && code < 123)) { // lower alpha (a-z)
	    e.preventDefault();
	  }
	}
$( function() {
	$(".eduQualClass").each(function() {
		$(this).parent().parent().find("#minEduQual").val($(this).val());
	});
});
</script>