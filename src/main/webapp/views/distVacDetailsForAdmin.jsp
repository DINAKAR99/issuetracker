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

	<div class="table table-striped ">
	    <table style="width: inherit;">
    <thead style="background-color: #d3d8df;">
        <tr>	
        		<th>S No</th>
        		<th style="width: 380px;">Name of the Department</th>
                <th style="width: 300px;">Post Category</th>
              	<th style="width: 380px;">Reporting Officer</th>
                <th style="width: 200px;">Min. Qualification</th>
                <th>Vacancies</th>
            </tr>
    </thead>
    <tbody>
	    <% int i=1; %>
	    <c:if test="${not empty authMst.vacDetailsList}">
	        <c:forEach items="${authMst.vacDetailsList}" var="vac">
	        		<tr>
	        			<td><%= i %></td>
			        	<td  style="color: #00549d;font-weight: bold;">${vac.hodName}</td>
			        	<td>${vac.postCategoryName}</td>
				    	<td>${vac.appointingAuth}</td>
				    	<td>${vac.minQualificationReq}</td>
			        	<td>${vac.vacancies}</td>
	        		</tr>
	        		<% i=i+1; %>
	        </c:forEach>
	    </c:if>
    </tbody>
    
</table>
		<br>
  </div>
  <br><br><br><br>
</div>
