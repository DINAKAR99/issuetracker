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
   a{
		font-size: larger;
   }
   .bgColor{
   		background-color: #daedf9;
   }
</style>
<div class="container">
	<div>
	<h2 class="title pt-3"> Dashboard Report </h2>
	</div>

	<div class="table table-striped ">
	<br><br>
<p class="bgColor"><a href="${pageContext.request.contextPath}/distWiseReport?reportType=ageWise">
					District wise Age group wise report <i class="fa fa-arrow-right" aria-hidden="true"></i></a></p>
<p class="bgColor"><a href="${pageContext.request.contextPath}/distWiseReport?reportType=graduates">
					District wise number of graduate & above VRAs, Revenue Dept vacancies, Diff of both <i class="fa fa-arrow-right" aria-hidden="true"></i></a></p>
<p class="bgColor"><a href="${pageContext.request.contextPath}/distWiseReport?reportType=below45">
					District wise number of VRAs below 45 Yrs, Irrigation Dept + Laskar post vacancies, Diff of both <i class="fa fa-arrow-right" aria-hidden="true"></i></a></p>
<p class="bgColor"><a href="${pageContext.request.contextPath}/distWiseReport?reportType=above65">
					District wise number of VRAs above 65 Yrs, Revenue Dept vacancies, Diff of both <i class="fa fa-arrow-right" aria-hidden="true"></i></a></p>


		<br>
  </div>
  <br><br><br><br>
</div>
