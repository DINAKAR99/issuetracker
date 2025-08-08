<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<div class="container">
	<div>
	<h2 class="title pt-3"> VRA Update Details </h2>
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
	
	<form:form action="${pageContext.request.contextPath}/updateVraDetails" method="post" 
			modelAttribute="vraDet" enctype="multipart/form-data" id="vraDetId">

		<div class="row">
			<div class="form-group col-6">
			    <label for="nameOfIndividual">Name Of The VRA</label>
			    <input type="text" name="" class="form-control"
			    		  value="${vraDet.name}" autocomplete="off" readonly="readonly">
			 </div>
			        
	        <div class="form-group col-6">
			    <label for="">Father's/Husband's Name</label>
			    <input name="" class="form-control" value="${vraDet.fatherName}" 
		    		 autocomplete="off" readonly="readonly">
	 		 </div>
	  
	  	</div>
	  	<div class="row">
	        <div class="form-group col-6">
			    <label for="">Working District</label>
			    <input name="" class="form-control" value="${vraDet.distMaster.distName}" 
		    		 autocomplete="off" readonly="readonly">
	 		 </div>
	 		 <div class="form-group col-6">
			    <c:choose>
			    	<c:when test="${vraDet.mandalMaster.mandalName!='' && vraDet.mandalMaster.mandalName!=null}">
			    		<label for="">Working Mandal</label>
			    		<input type="text" name="" class="form-control mandalCode"
			    		  value="${vraDet.mandalMaster.mandalName}" autocomplete="off" readonly="readonly">
			    	</c:when>
			    	<c:otherwise>
			    		<label for="">Working Mandal <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    		<form:select path="mandalCode" class="form-control mandalCode" name="mandalCode" id="mandalCode"
							onchange="getSelectBox('workingVillage',this.value,'villageCode')">
							<form:option value="0">--Select Mandal--</form:option>
							<form:options items="${workingMandalsList}"></form:options>
						</form:select>
			    	</c:otherwise>
			    </c:choose>
			 </div>
	  
	  	</div>
	  	<div class="row">
	  			<div class="form-group col-6">
			    <label for="villageCode">Working Village <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    	<form:select path="villageCode"  id="villageCode" cssClass="form-control" autofocus="autofocus" class="required">
							 	<form:option disabled="disabled" value="0">--Select Village--</form:option>
							 	<form:options items="${workingVillagesList}"></form:options>
					</form:select>
			  </div>
			<div class="form-group col-6">
				    <label for="nativeDistrictCode">Native District <span class="text-red font-weight-bold " style="color: red;">*</span></label>
				    <form:select path="nativeDistrictCode"  id="nativeDistrictCode" cssClass="form-control" 
				    		onchange="getSelectBox('mandal',this.value,'nativeMandalCode')" autofocus="autofocus" >
							 	<form:option disabled="disabled" value="0">--Select District--</form:option>
							 	<form:options items="${districtsList}"></form:options>
					</form:select>
				</div>
	  	</div>
	  	<div class="row">
	  			<div class="form-group col-6">
			    <label for="nativeMandalCode">Native Mandal <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    	<c:choose>
			    		<c:when test="${vraDet.nativeMandalCode!=null && vraDet.nativeMandalCode!=''}">
			    			<form:select path="nativeMandalCode" class="form-control" name="nativeMandalCode" id="nativeMandalCode"
								onchange="getSelectBox('village',this.value,'nativeVillageCode')">
								<form:option value="0">--Select Mandal--</form:option>
								<form:options items="${nativeMandalsList}"></form:options>
							</form:select>
			    		</c:when>
			    		<c:otherwise>
			    			<form:select path="nativeMandalCode" class="form-control" name="nativeMandalCode" id="nativeMandalCode"
								onchange="getSelectBox('village',this.value,'nativeVillageCode')">
								<form:option value="0">--Select Mandal--</form:option>
							</form:select>
			    		</c:otherwise>
			    	</c:choose>
			  </div>
			<div class="form-group col-6">
				    <label for="nativeVillageCode">Native Village <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    	<c:choose>
			    		<c:when test="${vraDet.nativeVillageCode!=null && vraDet.nativeVillageCode!=''}">
			    			<form:select path="nativeVillageCode" class="form-control" name="nativeVillageCode" id="nativeVillageCode">
								<form:option value="0">--Select Village--</form:option>
								<form:options items="${nativeVillagesList}"></form:options>
							</form:select>
			    		</c:when>
			    		<c:otherwise>
			    			<form:select path="nativeVillageCode" class="form-control" name="nativeVillageCode" id="nativeVillageCode">
								<form:option value="0">--Select Village--</form:option>
							</form:select>
			    		</c:otherwise>
			    	</c:choose>
				</div>
	  	</div>
		<div class="row">
				<div class="form-group col-6">
				    <label for="dateOfJoining">Date Of Joining <span class="text-red font-weight-bold " style="color: red;">*</span></label>
				    <fmt:formatDate var="doa" pattern = "dd/MM/yyyy" value = "${vraDet.dateOfAppointmnet}" />
				    <input type="text" readonly="readonly" name="dateOfAppointmnet" class="form-control validateClass" onblur="validateDOB(this.id)" required 
				    placeholder="DD/MM/yyyy" id="dateOfJoining" value="${doa}"  autocomplete="off">
					
				 </div>
	        
		   	 <div class="form-group col-6">
			    <label for="dateOfBirth">Date Of Birth <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    <fmt:formatDate var="dob"  pattern = "dd/MM/yyyy" value = "${vraDet.dateOfBirth}" />
			    	<input name="dateOfBirth" readonly="readonly" class="form-control validateClass" id="dateOfBirth" onblur="validateDOB(this.id)"  placeholder="DD/MM/yyyy" value="${dob}"
			    		 autocomplete="off">
			  </div>
	  	</div>
  
  		<div class="row">
			<div class="form-group col-6">
			    <label for="gender">Gender <span class="text-red font-weight-bold " style="color: red;">*</span></label>
						<form:select path="gender"  id="gender" cssClass="form-control" autofocus="autofocus" >
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${genderTypes}"></form:options>
						</form:select>
			    
			  </div>
	        <div class="form-group col-6">
			    <label for="educationQualification">Educational Qualification <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    		 <form:select path="educationQualification"  id="educationQualification" cssClass="form-control" class="dropDownClass"  required="required" autofocus="autofocus" >
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${educationTypes}"></form:options>
						</form:select>
			    
			  </div>
  		</div>
  		<%-- <div class="row">
			<div class="form-group col-6">
			    <label for="underTakingGiven">Under taking given for regularization <span class="text-red font-weight-bold " style="color: red;">*</span></label>
						<form:select path="underTakingGiven"  id="underTakingGiven" cssClass="form-control" autofocus="autofocus">
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${yesOrNoTypes}"></form:options>
						</form:select>
			    
			  </div>
	        <div class="form-group col-6" id="utDateDiv" style="display: none;">
			    <label for="underTakingGivenDate">Under taking regularization date</label>
			    		  <fmt:formatDate var="dob"  pattern = "dd/MM/yyyy" value = "${vraDet.underTakingGivenDate}" />
				    	<input name="underTakingGivenDate" readonly="readonly" class="form-control" id="underTakingGivenDate"
				    	 	placeholder="DD/MM/yyyy" value="${dob}" autocomplete="off">
			  </div>
  		</div> --%>
  		<div class="row">
  			<%-- <div class="form-group col-6">
			    <label for="eligibleForReg">Eligible For Regularization <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			    		 <form:select path="eligibleForReg"  id="eligibleForReg" cssClass="form-control" class="dropDownClass"  required="required" autofocus="autofocus" >
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${yesOrNoTypes}"></form:options>
						</form:select>
			    
			  </div> --%>
				  <div class="form-group col-6">
				    	<label for="typeOfRecruitment">Type Of Recruitment <span class="text-red font-weight-bold " style="color: red;">*</span></label>
							<form:select path="typeOfRecruitment"  id="typeOfRecruitment" cssClass="form-control" autofocus="autofocus" >
									 	<form:option disabled="disabled" value="">--select--</form:option>
									 	<form:options items="${typeOfRecrTypes}"></form:options>
							</form:select>
				    
				  </div>
				<div class="form-group col-6">
			    	<label for="presentStatus">Present Status <span class="text-red font-weight-bold " style="color: red;">*</span></label>
						<form:select path="presentStatus"  id="presentStatus" cssClass="form-control" autofocus="autofocus" >
								 	<form:option disabled="disabled" value="">--select--</form:option>
								 	<form:options items="${statusTypes}"></form:options>
						</form:select>
			    
			  </div>
			 </div>
			<%-- <div class="row">
			  <div class="form-group col-6">
			    <label for="upLoad">Upload Undertaking Doc</label>
					<input type="file" class="form-control" 
						name="document" id="upLoad" onchange="checkfile(this);filesize(this);"
						placeholder="upload"> 
			    
			  </div>
			  <div class="form-group col-2">
			  <br><br>
			    	<c:choose>
        				<c:when test="${vraDet.underTakingDocument!=null}">
        					<a target="_blank" href="${pageContext.request.contextPath}/preview/${vraDet.underTakingDocument}">Uploaded Doc <i class="fa fa-eye" aria-hidden="true"></i>
        					</a> 
        					<input type="hidden" name="underTakingDocument" value="${vraDet.underTakingDocument}">
        				</c:when>
        				<c:otherwise>
        					<p style="color: darkblue;">File Not Uploaded</p>
        				</c:otherwise>
        			</c:choose>
			  </div>
			  <br>
			   <div class="form-group col-6">
			  	<span
						class="text-danger">* The type of the uploaded
						document should be in(.pdf,.doc,.docx,.jpg,.jpeg,.png,.JPG,.JPEG,.PNG,.PDF)
						format </span> <br />
					</div>
  		</div> --%>
  		<input type="hidden" name="sno" value="${vraDet.sno}">
  
		<div class="text-center mt-2">
			  <button type="submit" class="btn btn-primary" id = "updateId">Submit</button>
			  <button type="button" class="btn btn-info" onclick="history.back()">Back</button>
		 </div>
  
  	</form:form>
  	<br><br><br><br><br><br><br>
        </div>
<script type="text/javascript">
$( function() {
	$( "#dateOfJoining" ).datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: 'dd/mm/yy',
	    yearRange:"-112:+0",
	});
	$( "#dateOfBirth" ).datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: 'dd/mm/yy',
	    yearRange:"-122:-18",
	});
	$( "#underTakingGivenDate" ).datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: 'dd/mm/yy',
	    yearRange:"-112:+0",
	});
	
	var underTakingGiven = $("#underTakingGiven").val();
	
	if(underTakingGiven=="Yes"){
		$("#utDateDiv").show();
	}else{
		$("#utDateDiv").hide();
	}
}); 


$('#updateId').click(function(){
// 	var i = 0;
// 	$(".validateClass").each(function() {
// 		  if($(this).val().trim()==''){
// 			  i++;
// 			  $(this).css("border-color", "red");
// 		  }else{
// 			  $(this).css("border-color", "");
// 		  }
// 	});
	
// 	var doj = $("#dateOfJoining").val().trim();
// 	value = dateValue(doj);
// 	alert(value);
	
// 	if(i==0){
		
		if($("#mandalCode").val()==0){
			alert("Please Select Working Mandal");
			$("#mandalCode").focus();
			return false;
		}else if($("#villageCode").val()=='' || $("#villageCode").val()==0){
			alert("Please Select Working Village");
			$("#villageCode").focus();
			return false;
		}else if($("#nativeDistrictCode").val()=='' || $("#nativeDistrictCode").val()==0){
			alert("Please Select Native District");
			$("#nativeDistrictCode").focus();
			return false;
		}else if($("#nativeMandalCode").val()=='' || $("#nativeMandalCode").val()==0  ){
			alert("Please Select Native Mandal ");
			$("#nativeMandalCode").focus();
			return false;
		}else if($("#nativeVillageCode").val()=='' || $("#nativeVillageCode").val()==0){
			alert("Please Select Native Village");
			$("#nativeVillageCode").focus();
			return false;
		}else if($("#dateOfJoining").val()==''){
			alert("Please Select Date of Joining");
			$("#dateOfJoining").focus();
			return false;
		}else if($("#dateOfBirth").val()==''){
			alert("Please Select Date of Birth");
			$("#dateOfBirth").focus();
			return false;
		}else if($("#gender").val()=='' || $("#gender").val()==0){
			alert("Please Select Gender");
			$("#gender").focus();
			return false;
		}else if($("#educationQualification").val()=='' || $("#educationQualification").val()==0){
			alert("Please Select Educational Qualification");
			$("#educationQualification").focus();
			return false;
		}else if($("#typeOfRecruitment").val()=='' || $("#typeOfRecruitment").val()==0){
			alert("Please Select Type of Recruitment");
			$("#typeOfRecruitment").focus();
			return false;
		}else if($("#presentStatus").val()=='' || $("#presentStatus").val()==0){
			alert("Please Select Present Status");
			$("#presentStatus").focus();
			return false;
		}
		/*else if($("#underTakingGiven").val()=='' || $("#underTakingGiven").val()==0){
			alert("Please Select Under taking given for regularization");
			return false;
		}else if($("#eligibleForReg").val()=='' || $("#eligibleForReg").val()==0){
			alert("Please Select Eligible For Regularization ");
			return false;
		}*/else{
			 if( !confirm('Are you sure you want to submit?') ) 
				 event.preventDefault();
		}
		
// 	}else{
// 		alert("Please fill all the required fields");
// 		 event.preventDefault();
// 	} 
});

/* function validateDOB(id)
{
	var dob = $("#"+id).val().trim();
    var pattern = /^([0-9]{2})-([0-9]{2})-([0-9]{4})$/;
    if (dob == null || dob == "" || !pattern.test(dob)) {
    	alert("Please enter the field in required format 'dd/MM/yyyy'");
    	$("#"+id).val("");
        return false;
    }
    else {
        return true
    }
} */

function checkfile(ids) {
	 var validExts = new Array(".pdf", ".doc", ".docx", 
		".jpg", ".jpeg" , ".png" , ".JPG", ".JPEG" , ".PNG",".PDF");
	var fileExt = $("#upLoad").val();
// 	alert(fileExt);
	fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
	if (validExts.indexOf(fileExt) < 0) {
		alert("Invalid file selected, \n valid files are "+ validExts.toString() + " types.");
		$("#upLoad").val("");
		return false;
	} else if ($("#upLoad").get(0).files.length == 0) {

		alert("upload the file");
	}

}

	function filesize(input) {
		var x = input.value;
		if (!x == "") {
			var img = input.files[0].size;
			var imgsize = img / (1024);
			if (imgsize > 1024) {
				alert("Please Upload File Size Below 1MB");
				document.getElementById('upLoad').value = "";
			} else {
				return false;
			}
		}
	}
	
	$('#underTakingGiven').change(function(){
		var utGivenForReg = $(this).val();
		if(utGivenForReg == "No") {
			$("#underTakingGivenDate").val("");
		    $("#utDateDiv").hide();
		}else{
		    $("#utDateDiv").show();
		}
	});
	
	function getSelectBox(type, val, id) {
		if (type == "mandal") {
			$.post( "${pageContext.request.contextPath}/getMandals?district_id=" + val, function(data) {
				$("#"+id).html("<option value=''>--Select Mandal--</option>"+data);
				$("#nativeVillageCode").html("<option value=''>--Select Village--</option>");
			});
		}else if (type == "village") {
			$.post( "${pageContext.request.contextPath}/getVillages?mandal_id=" + val, function(data) {
				$("#" + id).html("<option value=''>--Select Village--</option>"+data);
			});
		}else if(type == "workingVillage"){
			$.post( "${pageContext.request.contextPath}/getWorkingVillages?mandal_id=" + val, function(data) {
				$("#" + id).html("<option value=''>--Select Village--</option>"+data);
			});
		}
		
	}
	
	
</script>