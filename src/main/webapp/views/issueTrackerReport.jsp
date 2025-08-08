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
                        <title>Tickets Report</title>

                        <!-- External CSS -->
                        <link rel="stylesheet" href="<%= basePath %>resources/css/bootstrap.min.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/css/font-awesome4.2.min.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/custom.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/menu/sm-core-css.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/menu/sm-blue.css">
                        <link rel="stylesheet" href="<%= basePath %>resources/css/google_poppins.css">
                        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">

                        <!-- jQuery and DataTables JS -->
                        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
                        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
                        <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
                        <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>

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

                            table.dataTable {
                                margin: 0;
                            }

                            .dataTables_scroll {
                                /* margin-left: 1%; */
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

                            #issueTrackerReportTable_wrapper .dataTables_filter {
                                position: absolute;
                                bottom: 0.5px;
                            }
                        </style>
                    </head>

                    <body>
                        <div class="container-fluid mt-2">
                            <div class="card">
                                <div class="card-header">
                                    <h3 style="font-size: 20px !important;color: white;text-align: center;">${issueType}Tickets Report</h3>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty msg}">
                                        <div class="msg-success">${msg}</div>
                                    </c:if>

                                    <form:form action="getIssueDetails" method="post" id="issueTracker"
                                        modelAttribute="issueTrackerDTO">
                                        <div class="table-wrapper">
                                            <table class="table table-bordered table-striped"
                                                id="issueTrackerReportTable">
                                                <thead>
                                                    <tr>
                                                        <th>S.No.</th>
                                                        <th>Ticket No.</th>
														    <th>District</th>
														    <th>Mandal</th>
														    <th>Gram Panchayat</th>
                                                        <th>Issue Reported Date</th>
                                                        <th>Officer Name / Designation</th>
                                                        <!-- <th>Issue Description</th> -->
                                                        <th>Module/Submodule/Service</th>
                                                        <th>Status</th>
                                                        <!-- <th>Priority</th> -->
                                                        <th>Assigned to</th>
                                                        <th>Issue Resolved Date</th>
 
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="reportData" items="${issueTrackerReport}"
                                                        varStatus="row">
                                                        <tr>
                                                            <td>${row.index + 1}</td>
                                                            <td>
                                                                <a href="javascript:void(0)" class="text-primary"
                                                                    data-toggle="tooltip" title="Ticketing System Details"
                                                                    data-toggle="modal"
                                                                    data-target="#issueTrackingModal"
                                                                    onclick="urlPostSubmit('issueTrackerReportView', ['trackerId', 'view'], ['${reportData.issue_tracker_id}', '0'])">
                                                                    ${reportData.issue_tracker_id}
                                                                </a>

                                                            </td>
                                                            <td><c:choose>
                                                                    <c:when test="${empty reportData.district_name}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.district_name} <br>
                                                                    </c:otherwise>
                                                                </c:choose></td>
                                                            <td><c:choose>
                                                                    <c:when test="${empty reportData.mandal_name}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.mandal_name} <br>
                                                                    </c:otherwise>
                                                                </c:choose></td>
                                                            <td><c:choose>
                                                                    <c:when test="${empty reportData.gpname}">
                                                                        -<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.gpname} <br>
                                                                    </c:otherwise>
                                                                </c:choose></td>
                                                            <td>${reportData.issue_created_date}</td>
                                                            <td style="text-align: start;">
                                                                <b>Officer :&nbsp;</b>${reportData.created_by}<br />
                                                                <b>Desg.:&nbsp;</b>${reportData.designation}
                                                            </td>

                                                            <!-- <td
                                                                style="text-align: start;text-wrap: inherit;white-space: pre-wrap !important; ">
                                                                ${reportData.issue_description}</td> -->
                                                            <td style="text-align: start;">
                                                                <b>Module :&nbsp;</b> ${reportData.module_name} <br>
                                                                <b>Sub-Module :&nbsp;</b> 
                                                                 <c:choose>
                                                                    <c:when test="${empty reportData.submodule_name}">-
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.submodule_name}</c:otherwise>
                                                                </c:choose>
                                                                <br>
                                                                <b>Service :&nbsp;</b>  
                                                                 <c:choose>
                                                                    <c:when test="${empty reportData.service_name}">-
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.service_name}</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td style="text-transform:capitalize !important">
                                                                ${reportData.status}
                                                                <br>
                                                                <c:if test="${reportData.status eq 'forwarded'}">
                                                                    <span style="font-size: 11px !important;color: rgb(167, 97, 35);">to ${reportData.assignee}</span>
                                                                </c:if>
                                                            
                                                            </td>
                                                            <!-- <td>${reportData.priority}</td> -->
                                                            <td>${reportData.assignee}</td>
                                                            <!-- <td></td> -->
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
                            $('#issueTrackerReportTable').DataTable({
                                "paging": true,
                                "lengthMenu": [[10, 15, 25, 50, -1], [15, 25, 50, "All"]],
                                // "lengthMenu":true,
                                "searching": true,
                                "ordering": true,
                                "info": true,
                                "autoWidth": false,
                                "scrollX": true,
                                dom: '<"row"<"col-lg-6 text-left"f><"col-lg-6 text-right"Br><"col-lg-12"t><"col-lg-5"i><"col-lg-7"p>>',
                                buttons: [
                                    {
                                        extend: 'excel',
                                        text: '<i class="fa fa-file-excel-o ">  Excel</i>', // Excel icon
                                        title: 'Ticketing System Report',
                                        className: 'btn btn-secondary btn-sm', // Grey color
                                        filename: 'Issue_Tracker_Report_' + new Date().toISOString().slice(0, 10),
                                        exportOptions: {
                                            columns: ':visible'
                                        }
                                    }
                                ]
                            });
                            function urlPostSubmit(path, paramNames, paramValues) {

                                var myForm = document.createElement("form");
                                myForm.setAttribute("method", "post");
                                myForm.setAttribute("action", path);

                                var token = $('#_csrf').attr('content');
                                var csrfField = document.createElement("input");
                                csrfField.setAttribute("type", "hidden");
                                csrfField.setAttribute("name", "_csrf");
                                csrfField.setAttribute("value", token);
                                myForm.appendChild(csrfField);


                                for (var i = 0; i < paramNames.length; i++) {

                                    var customizedField = document.createElement("input");
                                    customizedField.setAttribute("type", "hidden");
                                    customizedField.setAttribute("name", paramNames[i]);
                                    customizedField.setAttribute("value", paramValues[i]);
                                    myForm.appendChild(customizedField);
                                }
                                document.body.appendChild(myForm);

                                myForm.submit();
                                return false;

                            }
                            $(window).on('resize', function () {
                                $('#issueTrackerReportTable').DataTable().columns.adjust().draw();
                            });

                        </script>
                    </body>

                    </html>