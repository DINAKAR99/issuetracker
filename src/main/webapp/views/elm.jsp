<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Level Mapping</title>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
	<div class="container">
	<c:if test="${not empty successmsg}">
		<div class="alert alert-success alert-dismissible fade show text-center font-weight-bold" role="alert">
			${successmsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<c:if test="${not empty failmsg}">
		<div
			class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
			role="alert">
			${failmsg}
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
	</c:if>
	<form:form action="EmployeeLevelMap">
		
			<div>
				<h2 class="title pt-3">Employee Level Mapping</h2>
			</div>
			
			<div class="form-group">
				<label for=" projecttypeid" class="col-sm-2 col-form-label">Project Type:<font color="red" size="2">*</font>
				</label> <select name="projecttypeid" id="projecttypeid" required="required" Class="form-control" autofocus="autofocus"
					onchange="showfeilds()">
					<option value="">--select--</option>
					<c:if test="${not empty projects}">
						<c:forEach items="${projects}" var="p">
							<option value="${p.project_type_id}">${p.project_type_name}</option>
						</c:forEach>
					</c:if>
				</select> <span> <form:errors path="projectTypeId" cssClass="text-danger font-weight-bold"></form:errors></span>
			</div>
			<div id="p" align="center">
				<p></p>
			</div>
			<div class="form-group">
				<label for="level" class="col-sm-2 col-form-label">Level
					Count: <font color="red" size="2">*</font>
				</label> <input class="form-control" name="level" id="level"
					placeholder="Enter Level Count" required="required"
					onkeyup="showtable()" maxlength="2" />
				<!-- <select name="level" id="level"  required="required" onchange="showtable()">
        <option value=" ">---select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        </select> -->
			</div>

			<div class="form-group" id="table">
				<h1 align="center">Post List</h1>
				<table id="YourTableId" border="2" width="70%" cellpadding="2" align="center" class="table  table-bordered">
					<thead>
						<tr>
							<th class="yourTableTh">Level</th>
							<th class="yourTableTh">selected_employees</th>
							<th class="yourTableTh">Status</th>
						</tr>
					</thead>
					<tbody><tr><td><select id='employee1' class='empid' name='empid'>
								<option value=''>select--</option>
						</select></td></tr>
					</tbody>
				</table>
			</div>
			<div class="text-center mt-2">
				<button type="submit" class="btn btn-primary"
					onclick="return validateCheck();">Submit</button>
			</div>
	</form:form></div>
	<script type="text/javascript">
 function showtable(){
	 var t;
	 var levelids=[];
	 var projecttypeid=document.getElementById("projecttypeid").value;
	 var levelcount=document.getElementById("level").value;
	 if(projecttypeid == 0) {
		 alert("Please Select Project Type");
		 document.getElementById("level").value = "";
		 $("#level").attr("placeholder", "Enter Level Count");
		 return false;
	 }
	  $("#YourTableId > tbody"). empty();
	  var ptype=document.getElementById("projecttypeid").value;
	  console.log(ptype);
				$.post('ww?levelid='+levelcount+'&prtype='+ptype,function(data){
					var c=data.length
					acc=c-levelcount
					console.log("acc"+acc);
					console.log("lenght"+data.length);
		            for(var i=0;i<data.length;i++){
		            	var id=data[i].id;
		            	console.log("issd"+id);
		            	var un=data[i].username;
		            	var lid1=data[i].leid;
		            	var cid=data[i].currid;
		            	var sn=data[i].sname;
		            	console.log("snn"+sn);
		            	if(sn==null){
		            		sn='select status';
		            	}
		            		var ul=un;
		            		console.log("id"+i);
			            	var rows = "<tr>"  
					             + "<td class='yourTableTh'>"+"<select id='level_"+i+"' class='level1' name='levelid' ></select>"+"</td>"  
					             + "<td class='yourTableTh'>"+"<select id='employee1_"+i+"' class='empid1' name='empid' ></select>"+"<input type='hidden' value="+id+" name='id1'>"+"</td>" 
					             +"<td class='yourTableTh'>"+"<select id='status_"+i+"' class='statusid1' name='status'></select>"+"</td>"
					             + "</tr>";
			            	 $('#YourTableId tbody').append(rows); 
			            	 $("#employee1_"+i+"").append("<option class='optionVal' value='"+id+"'>"+ul+"</option>");
			            	 
			            	 $("#status_"+i+"").append("<option class='optionVal' value='"+cid+"'>"+sn+"</option>");
			            	 $("#level_"+i+"").append("<option class='optionVal' value='"+lid1+"'>"+lid1+"</option>");
			            	 t=lid1;
			            	 levelids[i]=lid1;
		            }
		            $.post('le?projectType='+ptype,function(data){
	            		 
	           			 
            			for(var i=0;i<data.length;i++){
            				
            				var lid=data[i].levelid;
            				
            				 $(".level1").append("<option class='optionVa' value='"+lid+"'>"+lid+"</option>");
            			}
            		}); 
		            $.post('getemp?projectType='+ptype,  function(data) {
						
						
						for( var i = 0; i<data.length; i++){
			         	 var id = data[i].id;
			         	 var name = data[i].userName;
			      $(".empid1").append("<option class='optionVal' value='"+id+"'>"+name+"</option>");
			      }
				 })
				   $.post('status',function(data){
		            	
            			for(var i=0;i<data.length;i++){
            				var lid=data[i].statusid;
            				var stname=data[i].statusname;
            				 $(".statusid1").append("<option class='optionVa' value='"+lid+"'>"+stname+"</option>");}
		            });
		          //  $(".statusid1").append("<option class='optionVal' value='"+1+"'>development completed</option>"+"<option class='optionVal' value='"+2+"'>DB Review In progress</option>"+"<option class='optionVal' value='"+3+"'>DB Review  completed</option>"+"<option class='optionVal' value='"+4+"'>Testing in progress</option>"+"<option class='optionVal' value='"+5+"'>Testing completed</option>"+"<option class='optionVal' value='"+6+"'>production in progress</option>"+"<option class='optionVal' value='"+8+"'>Completed</option>");

		            console.log("plx"+t);
		            console.log(levelids);
		            var ki=levelcount-t
		            console.log("kiiiii"+ki);
		            if(t<levelcount){
		            for(var k=1;k<=ki;k++){
		            	 var row = "<tr>"  
		                      + "<td class='yourTableTh'>"+"<select id='level' class='levelid' name='levelid'></select>"+"</td>"  
		                      + "<td class='yourTableTh'>"+"<select id='employee1' class='empid' name='empid'></select>"+"</td>" 
		                     + "<td class='yourTableTh'>"+"<select id='status' class='statusid' name='status'></select>"+"</td>" 
		                    + "</tr>";  
		                    

		            $('#YourTableId tbody').append(row);
		            }
		        //    $(".statusid").append("<option class='optionVal' value=''>select status</option>"+"<option class='optionVal' value='"+1+"'>development completed</option>"+"<option class='optionVal' value='"+2+"'>DB Review In progress</option>"+"<option class='optionVal' value='"+3+"'>DB Review  completed</option>"+"<option class='optionVal' value='"+4+"'>Testing in progress</option>"+"<option class='optionVal' value='"+5+"'>Testing completed</option>"+"<option class='optionVal' value='"+6+"'>production in progress</option>"+"<option class='optionVal' value='"+8+"'>Completed</option>");
		          $.post('status',function(data){
		            	 $(".statusid").empty();
            	         $(".statusid").append('<option value="">select status</option>');
            			for(var i=0;i<data.length;i++){
            				var lid=data[i].statusid;
            				var stname=data[i].statusname;
            				 $(".statusid").append("<option class='optionVa' value='"+lid+"'>"+stname+"</option>");}
		            });
		            $.post('le?projectType='+ptype,function(data){
	            		
	            			 $(".levelid").empty();
	            	         $(".levelid").append('<option value="">select the level</option>');
	            			for(var i=0;i<data.length;i++){
	            				var lid=data[i].levelid;
	            				 $(".levelid").append("<option class='optionVa' value='"+lid+"'>"+lid+"</option>");
	            			}
	            		}); 
		            $.post('getemp?projectType='+ptype,  function(data) {
			      		  console.log(level);
			      		  $(".empid").empty();
			                $(".empid").append('<option value="">Select New Employess</option>');
			      			for( var i = 0; i<data.length; i++){
			               	 var id = data[i].id;
			               	 var name = data[i].userName;
			               	 $(".empid").append("<option class='optionVal' value='"+id+"'>"+name+"</option>");

			            }
			      });
		            }
		            else if(c==0){
		            	for(var k=1;k<=levelcount;k++){
		            		 var row = "<tr>"  
			                      + "<td class='yourTableTh'>"+"<select id='level' class='levelid' name='levelid'></select>"+"</td>"  
			                      + "<td class='yourTableTh'>"+"<select id='employee1' class='empid' name='empid'></select>"+"</td>" 
			                     + "<td class='yourTableTh'>"+"<select id='status' class='statusid' name='status'></select>"+"</td>" 
			                    + "</tr>";  
			                    

			            $('#YourTableId tbody').append(row);
			           
		            	}
		            //	 $(".statusid").append("<option class='optionVal' value=''>select status</option>"+"<option class='optionVal' value='"+1+"'>development completed</option>"+"<option class='optionVal' value='"+2+"'>DB Review In progress</option>"+"<option class='optionVal' value='"+3+"'>DB Review  completed</option>"+"<option class='optionVal' value='"+4+"'>Testing in progress</option>"+"<option class='optionVal' value='"+5+"'>Testing completed</option>"+"<option class='optionVal' value='"+6+"'>production in progress</option>"+"<option class='optionVal' value='"+8+"'>Completed</option>");
		            $.post('status',function(data){
		            	 $(".statusid").empty();
            	         $(".statusid").append('<option value="">select status</option>');
            			for(var i=0;i<data.length;i++){
            				var lid=data[i].statusid;
            				var stname=data[i].statusname;
            				 $(".statusid").append("<option class='optionVa' value='"+lid+"'>"+stname+"</option>");}
		            });
				            $.post('le?projectType='+ptype,function(data){
			            		
			            			 $(".levelid").empty();
			            	         $(".levelid").append('<option value="">select the level</option>');
			            			for(var i=0;i<data.length;i++){
			            				var lid=data[i].levelid;
			            				 $(".levelid").append("<option class='optionVa' value='"+lid+"'>"+lid+"</option>");
			            			}
			            		}); 
				            $.post('getemp?projectType='+ptype,  function(data) {
					      		  console.log(level);
					      		  $(".empid").empty();
					                $(".empid").append('<option value="">Select New Employess</option>');
					      			for( var i = 0; i<data.length; i++){
					               	 var id = data[i].id;
					               	 var name = data[i].userName;
					               	 $(".empid").append("<option class='optionVal' value='"+id+"'>"+name+"</option>");

					            }
					      });
		            }
		           
				});
		
			
$("#table").show();
 }
  function showfeilds(){
	  $("#table").hide();
		 $("#level").val("");
		 $("#level").attr("placeholder", "Enter Level Count");
  }
 
 

 $(document).ready(function(){
	  $("#table").hide();
  });
  </script>
</body>
</html>