<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <% String path=request.getContextPath(); String basePath=request.getScheme() + "://" +
                    request.getServerName() + ":" + request.getServerPort() + path + "/" ; %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Ticketing System Approval</title>

                        <!-- External CSS -->
                        <link rel="stylesheet" href="<%= basePath %>resources/css/bootstrap.min.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/css/font-awesome4.2.min.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/custom.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/menu/sm-core-css.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/menu/sm-blue.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/css/google_poppins.css">
                        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">


                    <style>
                        body {
                            font-family: 'Poppins', sans-serif;
                            background-color: #f4f6f9;
                        }
                    
                        .container {
                            margin-top: 30px;
                        }
                    
                        .card {
                            border-radius: 10px;
                            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
                        }
                    
                        .card-header {
                            background-color: #003366;
                            /* Dark blue */
                            color: #003366;
                            font-weight: bold;
                            border-radius: 10px 10px 0 0;
                    
                        }
                    
                        .table-wrapper {
                    
                            width: 100%;
                        }
                    
                        .table {
                            min-width: 1200px;
                            /* Ensures table does not shrink */
                            white-space: nowrap;
                            /* Prevents text from wrapping */
                        }
                    
                        .table th {
                            background-color: #003366;
                            /* Dark blue */
                            color: white;
                            text-align: center;
                            padding: 10px;
                        }
                    
                        .table td {
                            text-align: center;
                            padding: 10px;
                        }
                    
                        .msg-success {
                            text-align: center;
                            font-size: 14px;
                            color: green;
                            padding-top: 10px;
                        }
                    
                        .row {
                            margin-bottom: 5px;
                        }
                    
                        .form-buttons {
                            display: flex;
                            justify-content: flex-end;
                            margin-top: 20px;
                        }
                    
                        .issue-details-container {
                            margin-top: 10px;
                        }
                    
                        .issue-label {
                            width: 180px;
                            text-align: left;
                        }
                    
                        .issue-value {
                            flex: 1;
                            font-weight: bold;
                            text-align: left;
                        }
                    
                        /* Modal Styles */
                        .modal-dialog {
                            max-width: 800px;
                            margin: 30px auto;
                        }
                    
                        .modal-content {
                            border-radius: 10px;
                        }
                    
                        .modal-header {
                            background-color: #003366;
                            color: white;
                        }
                    
                        .modal-body {
                            padding: 30px;
                        }
                    
                        #issueTrackerReportTable2_wrapper .dataTables_filter {
                            position: absolute;
                            bottom: 0.5px;
                    
                        }
                    
                        table.dataTable {
                            margin: 0;
                        }
                    </style>
                    </head>

                    <body>

                        <!-- Modal -->
                        <button type="button" hidden class="btn btn-primary" data-toggle="modal" data-target="#issueTrackingModal">
                         
                        </button>
                        <div class="modal fade" style="z-index: 100000;backdrop-filter: brightness(0.7);" id="issueTrackingModal" tabindex="-1"
                            role="dialog" aria-labelledby="issueTrackingModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg" role="document" style="min-width: 1000px;">
                        
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="issueTrackingModalLabel" style="text-align: center; width: 100%;">Issue
                                            Tracking Status Details</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true" style="color: white;font-size: 21px !important;">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <c:if test="${not empty msg}">
                        
                                            <div class="alert alert-success mb-4" role="alert">
                                                <h2 class="alert-heading fw-bold"> Success!</h2>
                                                <p class="fs-5">${msg}</p>
                                            </div>
                                        </c:if>
                        
                                        <form:form action="submitIssueStatus" method="post" id="issueTracker" modelAttribute="issueTrackerDTO"
                                            enctype="multipart/form-data">
                        
                                            <input type="hidden" id="selectedIssueId" name="selectedIssueId"
                                                value="${issueDetails[0]['issue_tracker_id']}" />
                        
                                            <div class="table-wrapper">
                                                <c:if test="${not empty issueDetails}">
                                                    <div class="container issue-details-container">
                                                        <div class="row">
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Officer Name:</label> <span
                                                                    class="issue-value">${issueDetails[0]['created_by']}</span>
                                                            </div>
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Designation:</label> <span
                                                                    class="issue-value">${issueDetails[0]['designation']}</span>
                                                            </div>
                                                        </div>
                        
                                                        <div class="row">
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Email ID:</label> <span class="issue-value">
                                                                    ${empty issueDetails[0]['email'] ? '-'
                                                                    :issueDetails[0]['email']}
                        
                        
                                                                </span>
                                                            </div>
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Mobile No:</label> <span class="issue-value">
                                                                    ${empty issueDetails[0]['phone'] ? '-' :
                                                                    issueDetails[0]['phone']}
                                                                </span>
                                                            </div>
                                                        </div>
                        
                                                        <div class="row">
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Ticketing System No:</label>
                                                                <span class="issue-value">${issueDetails[0]['issue_tracker_id']}</span>
                                                            </div>
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Issue Date:</label> <span
                                                                    class="issue-value">${issueDetails[0]['issue_created_date']}</span>
                                                            </div>
                                                        </div>
                        
                                                        <div class="row">
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Service Name:</label> <span class="issue-value">
                                                                    <c:choose>
                                                                        <c:when test="${empty  issueDetails[0]['service_name']}">-
                                                                        </c:when>
                                                                        <c:otherwise>${issueDetails[0]['service_name']} </c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </div>
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Status:</label> <span class="issue-value"
                                                                    style="text-transform:capitalize !important">${issueDetails[0]['status']}</span>
                                                            </div>
                                                        </div>
                        
                                                        <div class="row">
                                                            <!-- <div class="col-md-6 d-flex">
                                                                <label class="issue-label">Priority:</label> <span
                                                                    class="issue-value">${issueDetails[0]['priority']}</span>
                                                            </div> -->
                                                            <div class="col-md-6 d-flex">
                                                                <label class="issue-label" style="width: 41%;">Description:</label>
                                                                <span
                                                                    style=" overflow: auto;word-wrap: break-word;width: 60%;text-align: justify;">${issueDetails[0]['issue_description']}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                </c:if>
                                                <c:if test="${not empty issueStatusDetails}">
                                                    <table class="table table-bordered table-striped" id="issueTrackerReportTable"
                                                        style="width: 100% !important ;table-layout: fixed !important;white-space:nowrap !important;min-width: auto !important; ">
                                                        <thead>
                                                            <tr>
                                                                <th>S.No.</th>
                                                                <th>Action By</th>
                                                                <th>Status</th>
                                                                <th>Date</th>
                                                                <th>Attachments</th>
                                                                <th>Remarks</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="reportData" items="${issueStatusDetails}" varStatus="row">
                                                                <tr>
                                                                    <td>${row.index + 1}</td>
                                                                    <td>${reportData.action_by}</td>
                                                                    <td style="text-transform:capitalize !important">
                                                                        ${reportData.status}
                                                                        <br>
                                                                        <c:if test="${reportData.status eq 'forwarded'}">
                                                                            <span style="font-size: 11px !important;color: rgb(167, 97, 35);">
                                                                                <c:if test="${not empty reportData.assigned_to}">
                                                                                    to ${reportData.assigned_to}
                                                                            </span>
                                                                        </c:if>
                                                                        </c:if>
                                                                    
                                                                    </td>
                                                                    <td style="min-width: 40px !important;text-wrap: auto;word-wrap: break-word;">
                                                                        ${reportData.action_time}</td>
                                                                    <td style="text-wrap: auto;word-wrap: break-word;text-align: justify;  ">
                                                                        <c:if test="${empty reportData.file_name }">
                                                                            -
                                                                        </c:if>
                                                                        <c:if test="${reportData.file_name ne ''}">
                                                                            <a href="${pageContext.request.contextPath}/download?filePath=${reportData.file_path}"
                                                                                target="_blank" class="mt-3">${reportData.file_name}</a>
                                                                        </c:if>
                                                                    </td>
                                                                    <td style="text-wrap: auto;word-wrap: break-word;text-align: justify;  ">
                                                                        <c:if test="${empty reportData.remarks }">
                                                                            -
                                                                        </c:if>
                                                                        <c:if test="${reportData.remarks ne ''}">
                                                                            ${reportData.remarks}
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:if> 
                                            </div>
                                        </form:form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- report -->
                        <div class="m-2">
                            <div class="card">
                                <div class="card-header">
                                    <h2 style="font-size: 18px !important;color: white;text-align: center;">${title}</h2>
                                </div>

                                <div class="card-body">
                                    <c:if test="${not empty msg}">
                                        <div class="alert alert-success mb-4" role="alert">
                                            <h2 class="alert-heading fw-bold"> Success!</h2>
                                            <p class="fs-5">${msg}</p>
                                        </div>
                                    </c:if>


                                    <form:form action="getIssueDetails" method="post" id="issueTracker"
                                        modelAttribute="issueTrackerDTO">
                                        <div class="table-wrapper">
                                            <table class="table table-bordered table-striped"
                                                id="issueTrackerReportTable2">
                                                <thead>
                                                    <tr>
                                                        <th style="max-width: 50px !important;">S.No.</th>
                                                        <th>Ticket No.</th>
                                                        <th>District</th>
                                                        <th>Mandal</th>
                                                        <th>Gram Panchayat</th>
                                                         <th>Raised on</th>
                                                        <th>Officer Name / Designation</th>
                                                         <th>Issue Type</th>
                                                        <!-- <th>Priority</th> -->
                                                        <th>Module/Submodule/Service</th> 
                                                        <th>Status</th>
                                                        <th>Closed on</th>
                                                     </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="reportData" items="${mainReport}"
                                                        varStatus="row">
                                                        <tr>
                                                            <td style="max-width: 50px !important;">${row.index + 1}
                                                            </td>
                                                            <td>
                                                                 
                                                                 <a href="javascript:void(0)" class="text-primary"
                                                                    data-toggle="tooltip" title="Ticketing System Details"
                                                                    onclick="urlPostSubmit('getInfo','${reportData.issue_tracker_id}')">
                                                                    ${reportData.issue_tracker_id}
                                                                </a>
                                                             </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.district_name}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.district_name} <br>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                               
                                                            </td>
                                                            <td><c:choose>
                                                                <c:when test="${empty reportData.mandal_name}">
                                                                    -<br>
                                                                </c:when>
                                                                <c:otherwise>${reportData.mandal_name} <br>
                                                                </c:otherwise>
                                                            </c:choose>
                                                             </td>
                                                             <td><c:choose>
                                                                <c:when test="${empty reportData.gpname}">
                                                                    -<br>
                                                                </c:when>
                                                                <c:otherwise>${reportData.gpname} <br>
                                                                </c:otherwise>
                                                            </c:choose>
                                                             </td>
                                                            <td>${reportData.issue_created_date}</td>
                                                            <td style="text-align: start;">
                                                                <b>Officer :&nbsp;</b>${reportData.created_by}<br />
                                                                <b>Desg.:&nbsp;</b>${reportData.designation}
                                                            </td>
                                                            <!-- <td>${reportData.designation}</td> -->
                                                            <td>${reportData.issue_type}</td>
                                                            <!-- <td>${reportData.priority}</td> -->
                                                            <td style="text-align: start;">
                                                                <b>Module :&nbsp;</b>${reportData.module_name} <br>
                                                                <b>Sub-Module :&nbsp;</b>
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.submodule_name}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.submodule_name} <br>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <b>Service :&nbsp;</b>
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.service_name}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.service_name} <br>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <!-- <td>${reportData.submodule_name}</td> -->
                                                            <!-- <td>${reportData.service_name}</td> -->

                                                            <!-- <td style="text-align: start;text-wrap: inherit;white-space: pre-wrap !important;  -->
                                                            <!-- ">${reportData.issue_description}</td> -->
                                                        <td style="text-transform:capitalize !important">
                                                            ${reportData.status}
                                                            <br>
                                                            <c:if test="${reportData.status eq 'forwarded'}">
                                                                <span style="font-size: 11px !important;color: rgb(167, 97, 35);">
                                                                    <c:if test="${not empty reportData.assignee}">
                                                                        to ${reportData.assignee}
                                                                </span>
                                                            </c:if>
                                                            </c:if>
                                                        
                                                        </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.resolved_on}">-
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.resolved_on}<br /> (time taken: ${reportData.duration})</c:otherwise>
                                                                </c:choose>
                                                            
                                                            </td>

                                                            

                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>


                                    </form:form>
                                </div>
                            </div>
                        </div>

                        <script>
                           document.addEventListener("DOMContentLoaded", function () {
                                // Check if the 'status' attribute is not empty or undefined
                                var issueStatusDetails = `${issueStatusDetails}`;
                                console.log(issueStatusDetails);
                                
                                if (typeof issueStatusDetails !== 'undefined' && issueStatusDetails !== '') {
                                    // Click the button if the 'status' attribute is present and not empty
                                    document.querySelector('[data-target="#issueTrackingModal"]').click();
                                }
                            });



                            $('#issueTrackerReportTable2').DataTable({
                                "paging": true,
                                "lengthMenu": [[10, 15, 25, 50, -1], [15, 25, 50, "All"]],
                                "searching": true,
                                "ordering": true,
                                "info": true,
                                "autoWidth": false,
                                "scrollX": true,
                                dom: '<"row"<"col-lg-6 text-left"f><"col-lg-6 text-right"Br><"col-lg-12"t><"col-lg-5"i><"col-lg-7"p>>',
                                buttons: [
                                    {
                                        extend: 'excel',
                                        text: '<i class="fa fa-file-excel-o">  Excel</i>', // Excel icon
                                        title: 'Ticketing System Report',
                                        className: 'btn btn-secondary btn-sm', // Grey color
                                        filename: 'Issue_Tracker_Report_' + new Date().toISOString().slice(0, 10),
                                        exportOptions: {
                                            columns: ':visible'
                                        }
                                    }
                                ],
                            });


                            function urlPostSubmit(path,ticketid) {
                                var status=`${status}`;
                                console.log(`${status}`);
                                
                                var myForm = document.createElement("form");
                                myForm.setAttribute("method", "post");
                                myForm.setAttribute("action", path);  
                                
                                var customizedField = document.createElement("input");
                                customizedField.setAttribute("type", "hidden");
                                customizedField.setAttribute("name", "status");
                                customizedField.setAttribute("value", status);
                                myForm.appendChild(customizedField);
                                var customizedField = document.createElement("input");
                                customizedField.setAttribute("type", "hidden");
                                customizedField.setAttribute("name", "trackerId");
                                customizedField.setAttribute("value", ticketid);
                                myForm.appendChild(customizedField);
                                document.body.appendChild(myForm);

                                myForm.submit();
                                return false;

                            }
                            $(window).on('resize', function () {
                                $('#issueTrackerReportTable2').DataTable().columns.adjust().draw();
                            });

                        </script>
                    </body>

                    </html>