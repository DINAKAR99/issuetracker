<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<style type="text/css">
	.dt-buttons{
		text-align: center !important;
	}
	th {
  border-right: 1px solid #000000;
}	
.table-striped tbody tr:nth-of-type(odd) {
    background-color: rgb(255 255 255 / 5%) !important;
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
	<h2 class="title pt-3"> VRA Options </h2>
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
	</c:choose>
	
	<c:if test="${(status==0 || status==null) &&  authMstCnt == 0}">
		<marquee behavior="scroll" direction="left" style="color: red;font-size: larger;" scrollamount="10" class="blink"> Please update all vacancies data to confirm/forward for allotment process.</marquee>
		<!-- <p style="text-align: right;color: red;font-size: larger;">Please update all vra's data to confirm/forward for allotment process.</p> -->
		<hr>
	</c:if>

	<div class="table table-striped ">
	<form:form action="${pageContext.request.contextPath}/updatePriorityDetails" method="post" id="vraDet" modelAttribute="vraDet">
	    <table class="table borderless" style="width: 100%;">
    <tbody>
    				<tr>	
	        				<td></td>
     						<td style="font-weight: bold;">Name</td>
			        		<td>${vraDet.name}
			        		<form:hidden path="sno" value="${sno}"/>
			        		</td>
	        		</tr>
	        		<tr>	
	        				<td></td>
     						<td style="font-weight: bold;">Father Name</td>
			        		<td>${vraDet.fatherName}</td>
	        		</tr>
	        		<tr>
					    	<td></td>
	        				<td style="font-weight: bold;">Under Taking Given For Regularization</td>
				        	<td><form:select path="underTakingGiven"  id="eligibleForReg" cssClass="form-control" class="dropDownClass"  required="required" autofocus="autofocus" >
										 	<form:option disabled="disabled" value="">--select--</form:option>
										 	<form:options items="${yesOrNoTypes}"></form:options>
								</form:select>
					    	</td>
					   </tr>
    				<tr style="background-color: #8baec3 !important;display: none;" class="optionsDiv">	
     						<td>#</td>
			        		<td colspan="2" style="font-weight: bold;">Departments</td>
	        		</tr>
	        		<c:if test="${not empty optionsDet}">
	        			<c:forEach items="${optionsDet}" var="hod" varStatus="i">
					        		<tr class="optionsDiv" style="display: none;">	
					        				<td>${i.count}</td>
							        		<td style="color: #00549d;font-weight: bold;">${hod.hodMaster.hodName}
							        		<form:hidden path="vraPriorityMstDet[${i.index}].hodId" value="${hod.hodMaster.hodId}"/>
							        		 <span class="text-red font-weight-bold " style="color: red;">*</span></td>
								        	<td><form:input type="text" path="vraPriorityMstDet[${i.index}].orderOfPriority"  class="form-control validateClass" id="priority_${i.index}"
										    	 value="${hod.orderOfPriority}" onkeypress="javascript:return integersOnly(event);" onchange="checkPriority(${i.index})"
										    	maxlength="2" placeholder="Enter order of priority" autocomplete="off"/>
									    	</td>
					        		</tr>
					 </c:forEach>
	        		</c:if>
	        		<c:if test="${empty optionsDet}">
				      <c:forEach items="${hods}" var="hod" varStatus="i">
					        		<tr class="optionsDiv" style="display: none;">	
					        				<td>${i.count}</td>
							        		<td style="color: #00549d;font-weight: bold;">${hod.hodName}
							        		<form:hidden path="vraPriorityMstDet[${i.index}].hodId" value="${hod.hodId}"/>
							        		 <span class="text-red font-weight-bold " style="color: red;">*</span></td>
								        	<td><form:input type="text" path="vraPriorityMstDet[${i.index}].orderOfPriority"  class="form-control validateClass" id="priority_${i.index}"
										    	 value="" onkeypress="javascript:return integersOnly(event);" onchange="checkPriority(${i.index})"
										    	maxlength="2" placeholder="Enter order of priority" autocomplete="off"/>
									    	</td>
					        		</tr>
					  </c:forEach>
					</c:if>
	       				<%-- <tr>
	       					<td></td>
	        				<td style="font-weight: bold;">Under taking given for regularization</td>
				        	<td><form:select path="underTakingGiven"  id="underTakingGiven" cssClass="form-control" autofocus="autofocus">
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${yesOrNoTypes}"></form:options>
								</form:select>
					    	</td>
					   </tr> --%>
					  <%--  <tr id="utDateDiv" style="display: none;">
					   		<td></td>
	        				<td style="font-weight: bold;">Under taking regularization date</td>
				        	<td><fmt:formatDate var="dob"  pattern = "dd/MM/yyyy" value = "${vraDet.underTakingGivenDate}" />
						    	<input name="underTakingGivenDate" readonly="readonly" class="form-control" id="underTakingGivenDate"
						    	 	placeholder="DD/MM/yyyy" value="${dob}" autocomplete="off">
					    	</td>
					   </tr> --%>
					   
					   <!-- <tr>
					   		<td></td>
	        				<td style="font-weight: bold;">Upload Undertaking Doc</td>
				        	<td><input type="file" class="form-control" 
								name="document" id="upLoad" onchange="checkfile(this);filesize(this);"
								placeholder="upload"> 
					    	</td>
					   </tr> -->
		        <tr>
		        	<td colspan="3">
		        	 <div class="text-center mt-2">
		        	 <button type="submit" class="btn btn-primary" id = "updateId">Update</button>
		        	 <button type="button" class="btn btn-info" onclick="history.back()">Back</button>
		        	 </div>
		        	 </td>
		        </tr>
    </tbody>
    
</table>
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
// $('#underTakingGiven').change(function(){
// 	var utGivenForReg = $(this).val();
// 	if(utGivenForReg == "No") {
// 		$("#underTakingGivenDate").val("");
// 	    $("#utDateDiv").hide();
// 	}else{
// 	    $("#utDateDiv").show();
// 	}
// });

$('#eligibleForReg').change(function(){
	var eligForReg = $(this).val();
	if(eligForReg == "No" || eligForReg == "") {
		$(".validateClass").each(function() {
// 			$(this).val("");
			$(this).css("border-color", "");
		});
	    $(".optionsDiv").hide();
	}else{
	    $(".optionsDiv").show();
	}
});

$( function() {
	$( "#underTakingGivenDate" ).datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: 'dd/mm/yy',
	    yearRange:"-112:+0",
	});
	
	var eligibleForReg = $("#eligibleForReg").val();
	
	if(eligibleForReg=="Yes"){
		$(".optionsDiv").show();
	}else{
		$(".optionsDiv").hide();
	}
	
// 	var underTakingGiven = $("#underTakingGiven").val();
	
// 	if(underTakingGiven=="Yes"){
// 		$("#utDateDiv").show();
// 	}else{
// 		$("#utDateDiv").hide();
// 	}
}); 
function integersOnly(evt) {
	var theEvent = evt || window.event;
	var key = theEvent.keyCode || theEvent.which;
	var keyVal = String.fromCharCode(key);
	var regex = /[1-9]/;
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
	
	var eligibleForReg = $("#eligibleForReg").val();
		if(eligibleForReg=='' || eligibleForReg==0){
			alert("Please Select 'If agreed for Regularization' ");
			$("#eligibleForReg").focus();
			return false;
		}else if(eligibleForReg=="Yes"){
		$(".validateClass").each(function() {
			  if($(this).val().trim()==''){
				  i++;
				  $(this).css("border-color", "red");
			  }else{
				  $(this).css("border-color", "");
			  }
		});
	}
	
	if(i==0){
// 		if($("#underTakingGiven").val()=='' || $("#underTakingGiven").val()==0){
// 			alert("Please Select Under taking given for regularization");
// 			return false;
// 		}else if($("#eligibleForReg").val()=='' || $("#eligibleForReg").val()==0){
// 			alert("Please Select Eligible For Regularization ");
// 			return false;
// 		}
		 if( !confirm('Are you sure you want to update?') ) 
			 event.preventDefault();
	}else{
		alert("Please enter all required fields");
		 event.preventDefault();
	} 
});


function checkPriority(id){
	var hodsCnt = '${hodsCnt}';
	if($("#priority_"+id).val()!=""){
		if(parseInt($("#priority_"+id).val())>hodsCnt){
			alert("You have '"+hodsCnt+"' priorities only.");
			 $("#priority_"+id).val("");
			 $("#priority_"+id).css("border-color", "red");
			 $("#priority_"+id).focus();
			 return false;
		}else{
			for (var i = 0; i < hodsCnt; i++) {
				if(i!=id){
					if($("#priority_"+i).val()==$("#priority_"+id).val()){
						  alert("You have already entered priority '"+$("#priority_"+id).val()+"'");
						  $("#priority_"+id).val("");
						  $("#priority_"+id).css("border-color", "red");
						  $("#priority_"+id).focus();
						  return false;
					  }else{
						  $("#priority_"+id).css("border-color", "");
					  }
				}
			}
		}
	}
}
</script>