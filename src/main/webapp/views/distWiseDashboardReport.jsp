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
  .total{
  	text-align: left;
	font-weight: bold;
  }
</style>
<div class="container">
 <c:if test="${reportType=='ageWise'}">
	<div>
	<h2 class="title pt-3"> District wise Age group wise report </h2>
	</div>
	<div class="text-right mt-2">
		<button type="button" class="btn btn-info" onclick="history.back()"><i class="fa fa-arrow-left" aria-hidden="true"></i>
		Back</button>
	</div>
	<div class="table table-striped ">
	    <table style="width: inherit;" id="distWiseReport">
		    <thead style="background-color: #d3d8df;">
		        <tr>	
		        		<th>S No</th>
		        		<th style="width: 380px;">District Name</th>
		                <th style="width: 300px;">Age < 20 </th>
		              	<th style="width: 300px;">Age 21 to 45</th>
		                <th style="width: 300px;">Age 46 to 61</th>
		                <th style="width: 300px;">Age 61+</th>
		                <th>Age Not Available</th>
		            </tr>
		    </thead>
		    <tbody>
			    <% int i=1; %>
			    <c:if test="${not empty distWiseList}">
			        <c:forEach items="${distWiseList}" var="dist">
			        		<tr>
			        			<td><%= i %></td>
					        	<td  style="color: #00549d;font-weight: bold;">${dist[0]}</td>
					        	<td class="sum">${dist[1]}</td>
						    	<td class="sum">${dist[2]}</td>
						    	<td class="sum">${dist[3]}</td>
					        	<td class="sum">${dist[4]}</td>
					        	<td class="sum">${dist[5]}</td>
			        		</tr>
			        		<% i=i+1; %>
			        </c:forEach>
			    </c:if>
		    </tbody>
		    <tfoot>
			    <tr style="background: #d0d8e9;">
			    <td colspan="2" style="text-align:center;font-weight: bold;">Total</td>
			    <td class="total"> </td>
			    <td class="total"></td>
			    <td class="total"></td>
			    <td class="total"></td>
			    <td class="total"></td>
			    </tr>
			</tfoot>
		</table>
		<br>
  </div>
</c:if>
<c:if test="${reportType=='graduates'}">
	<div>
	<h2 class="title pt-3"> District wise number of graduate & above VRAs and Revenue Dept vacancies</h2>
	</div>
	<div class="text-right mt-2">
		<button type="button" class="btn btn-info" onclick="history.back()"><i class="fa fa-arrow-left" aria-hidden="true"></i>
		Back</button>
	</div>
	<div class="table table-striped ">
	    <table style="width: inherit;"  id="distWiseReport">
		    <thead style="background-color: #d3d8df;">
		        <tr>	
		        		<th>S No</th>
		        		<th style="width: 380px;">District Name</th>
		                <th style="width: 300px;">Vacancies in Revenue Department </th>
		              	<th style="width: 300px;">VRAs with Graduation & Above </th>
		                <th style="width: 300px;">Difference</th>
		            </tr>
		    </thead>
		    <tbody>
			    <% int i=1; %>
			    <c:if test="${not empty distWiseList}">
			        <c:forEach items="${distWiseList}" var="dist">
			        		<tr>
			        			<td><%= i %></td>
					        	<td  style="color: #00549d;font-weight: bold;">${dist[0]}</td>
					        	<td class="sum">${dist[1]}</td>
						    	<td class="sum">${dist[2]}</td>
						    	<td class="sum">${dist[3]}</td>
			        		</tr>
			        		<% i=i+1; %>
			        </c:forEach>
			    </c:if>
		    </tbody>
		    <tfoot>
			    <tr style="background: #d0d8e9;">
			    <td colspan="2" style="text-align:center;font-weight: bold;">Total</td>
			    <td class="total"></td>
			    <td class="total"></td>
			    <td class="total"></td>
			    </tr>
			</tfoot>
		</table>
		<br>
  </div>
</c:if>
<c:if test="${reportType=='below45'}">
	<div>
	<h2 class="title pt-3"> District wise number of VRAs below 45 Yrs and Irrigation Dept + Laskar post vacancies</h2>
	</div>
	<div class="text-right mt-2">
		<button type="button" class="btn btn-info" onclick="history.back()"><i class="fa fa-arrow-left" aria-hidden="true"></i>
		Back</button>
	</div>
	<div class="table table-striped ">
	    <table style="width: inherit;" id="distWiseReport">
		    <thead style="background-color: #d3d8df;">
		        <tr>	
		        		<th>S No</th>
		        		<th style="width: 380px;">District Name</th>
		                <th style="width: 300px;">Vacancies in Irrigation Department / Laskar Post in All Depts</th>
		              	<th style="width: 300px;">VRAs with Age less than 45 Yrs </th>
		                <th style="width: 300px;">Difference</th>
		            </tr>
		    </thead>
		    <tbody>
			    <% int i=1; %>
			    <c:if test="${not empty distWiseList}">
			        <c:forEach items="${distWiseList}" var="dist">
			        		<tr>
			        			<td><%= i %></td>
					        	<td  style="color: #00549d;font-weight: bold;">${dist[0]}</td>
					        	<td class="sum">${dist[1]}</td>
						    	<td class="sum">${dist[2]}</td>
						    	<td class="sum">${dist[3]}</td>
			        		</tr>
			        		<% i=i+1; %>
			        </c:forEach>
			    </c:if>
		    </tbody>
		    <tfoot>
			    <tr style="background: #d0d8e9;">
			    <td colspan="2" style="text-align:center;font-weight: bold;">Total</td>
			    <td class="total"></td>
			    <td class="total"></td>
			    <td class="total"></td>
			    </tr>
			</tfoot>
		</table>
		<br>
  </div>
</c:if>
<c:if test="${reportType=='above65'}">
	<div>
	<h2 class="title pt-3"> District wise number of VRAs above 65 Yrs and Revenue Dept vacancies</h2>
	</div>
	<div class="text-right mt-2">
		<button type="button" class="btn btn-info" onclick="history.back()"><i class="fa fa-arrow-left" aria-hidden="true"></i>
		Back</button>
	</div>
	<div class="table table-striped ">
	    <table style="width: inherit;" id="distWiseReport">
		    <thead style="background-color: #d3d8df;">
		        <tr>	
		        		<th>S No</th>
		        		<th style="width: 380px;">District Name</th>
		                <th style="width: 300px;">Vacancies in Revenue Department</th>
		              	<th style="width: 300px;">VRAs with Age more than 65 Yrs</th>
		                <th style="width: 300px;">Difference</th>
		            </tr>
		    </thead>
		    <tbody>
			    <% int i=1; %>
			    <c:if test="${not empty distWiseList}">
			        <c:forEach items="${distWiseList}" var="dist">
			        		<tr>
			        			<td><%= i %></td>
					        	<td  style="color: #00549d;font-weight: bold;">${dist[0]}</td>
					        	<td class="sum">${dist[1]}</td>
						    	<td class="sum">${dist[2]}</td>
						    	<td class="sum">${dist[3]}</td>
			        		</tr>
			        		<% i=i+1; %>
			        </c:forEach>
			    </c:if>
		    </tbody>
		    <tfoot>
			    <tr style="background: #d0d8e9;">
			    <td colspan="2" style="text-align:center;font-weight: bold;">Total</td>
			    <td class="total"></td>
			    <td class="total"></td>
			    <td class="total"></td>
			    </tr>
			</tfoot>
		</table>
		<br>
  </div>
</c:if>
  <br><br><br><br>
</div>

<script>
$(document).ready(
		function() {
			function tally(selector) {
				$(selector).each(
						function() {
							var total = 0, column = $(this).siblings(
									selector).andSelf().index(this);
							$("#distWiseReport tbody tr").each(function() {
										total += parseFloat($(
												'.sum:eq(' + column + ')',
												this).html()) || 0;
									});
							$(this).html(total);
						});
			}
			tally('td.total');

		});
</script>
