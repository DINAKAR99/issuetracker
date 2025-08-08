<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.label{
	font-weight: bold;
}
</style>
<div class="container">
	<div>
	<h2 class="title pt-3">Update Vacancy Details </h2>
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
	
	<form:form action="${pageContext.request.contextPath}/updateVacancyDetails" method="post" 
			modelAttribute="vacDet"  id="vacDetId">

		<div class="row" style="justify-content: center;">
			<div class="form-group col-3">
				<label for="postCategoryName" class="label">Post Category<span class="text-red font-weight-bold" style="color: red;">*</span></label>
			</div>
			<div class="form-group col-6">
			    <input type="text" name="postCategoryName" id="postCategoryName" class="form-control validateClass" placeholder="Post Category Name"
			    onkeypress="javascript:return allowAlphabetsAndNumbersAndComma(event);" value="${vacDet.postCategoryName}" autocomplete="off">
			 </div>
	  	</div>
	  	<div class="row" style="justify-content: center;">
			<div class="form-group col-3">
				<label class="label">Vacancies <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			</div>
			<div class="form-group col-6">
			 </div>
	  	</div>
  	<c:forEach items="${districtsList}" var="dist" varStatus="i">
  		<div class="row" style="justify-content: center;">
  			<div class="form-group col-1">
  				<label for="">${dist.distCode}.</label>
			</div>
  			<div class="form-group col-3">
				<label for="">${dist.distName}</label>
			</div>
  			<div class="form-group col-5">
			   <c:set var="dist1" value="d${dist.distCode}"></c:set>
			    <input type="text" name="d${i.count}" id="postCategoryName_${i.count}" class="form-control vacanciesCount validateClass" 
			    	placeholder="Enter Vacancies" onkeyup="addTotalFinalVacancies();"  value="${vacDet[dist1]}"
			    	maxlength="4" onkeypress="javascript:return integersOnly(event);" autocomplete="off">
			 </div>
  		</div>
  	</c:forEach>
  		<div class="row" style="justify-content: center;">
  			<div class="form-group col-3">
				<label for="totalVacancies" class="label">Total Vacancies</label>
			</div>
  			<div class="form-group col-6">
			    <input type="text" name="totalVacancies" id="totVacanciesCountId" class="form-control"
			    	placeholder="Total Vacancies" value="${vacDet.totalVacancies}" autocomplete="off" readonly="readonly">
			    
			 </div>
  		</div>
  	  	<div class="row" style="justify-content: center;">
  	  		<div class="form-group col-3">
				<label for="minQualificationReq" class="label">Min Qualification Req <span class="text-red font-weight-bold " style="color: red;">*</span></label>
			</div>
  			<div class="form-group col-6">
					<form:select path="minQualificationReq"  id="minQualificationReq" cssClass="form-control" class="dropDownClass"  required="required" autofocus="autofocus" >
							 	<form:option disabled="disabled" value="">--select--</form:option>
							 	<form:options items="${educationTypes}"></form:options>
					</form:select>
			 </div>
  		</div>
  		<div class="row" style="justify-content: center;">
  			<div class="form-group col-3">
				<label for="appointingAuth" class="label">Reporting Officer <span class="text-red font-weight-bold" style="color: red;">*</span></label>
			</div>
  			<div class="form-group col-6">
			    <input type="text" name="appointingAuth" id="appointingAuth" class="form-control validateClass" placeholder="Appointing Authority Name"
			    	onkeypress="javascript:return allowAlphabetsAndNumbersAndComma(event);" value="${vacDet.appointingAuth}" autocomplete="off">
			 </div>
  		</div>
  	
  		<input type="hidden" name="sno" value="${vacDet.sno}">
  
		 <div class="text-center mt-2">
			  <button type="submit" class="btn btn-primary" id = "updateId">Submit</button>
			  <button type="button" class="btn btn-info" onclick="history.back()">Back</button>
		 </div>
  
  	</form:form>
  	<br><br><br><br><br><br><br>
        </div>
<script type="text/javascript">
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
$('#updateId').click(function(){
	var i = 0;
	$(".validateClass").each(function() {
// 		var date = 
		  if($(this).val().trim()==''){
			  i++;
			  $(this).css("border-color", "red");
		  }else{
			  $(this).css("border-color", "");
		  }
	});
	
	if(i==0){
		if($("#minQualificationReq").val().trim()==''){
			alert("Please Select Min Qualification Required");
		}else{
			 if( !confirm('Are you sure you want to submit?') ) 
				 event.preventDefault();
		}
	}else{
		alert("Please enter all required fields");
		 event.preventDefault();
	} 
});

function validateDOB(id)
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
}

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

function addTotalFinalVacancies(){
	var vac = "0";
	$(".vacanciesCount").each(function() {
		vac = Number(vac) + Number($(this).val());
	});
	$("#totVacanciesCountId").val(vac);
}
</script>