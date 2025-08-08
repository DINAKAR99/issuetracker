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

                            #issueTrackerReportTable_wrapper .dataTables_filter {
                                position: absolute;
                                bottom: 0.5px;
                            }

                            table.dataTable {
                                margin: 0;
                            }
                        </style>
                    </head>

                    <body>

                        <div class="m-2">
                            <div class="card">
                                <div class="card-header">
                                    <h2 style="font-size: 18px !important;color: white;text-align: center;">Ticketing System Approval</h2>
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
                                                id="issueTrackerReportTable">
                                                <thead>
                                                    <tr>
                                                        <th style="max-width: 50px !important;">S.No.</th>
                                                        <th>Ticket No.</th>
                                                        <th>District</th>
														<th>Mandal</th>
														<th>Gram Panchayat</th>
                                                        <th>Raised on</th>
                                                        <th>Officer Name / Designation</th>
                                                        <!-- <th>Designation</th> -->
                                                        <th>Issue Type</th>
                                                        <!-- <th>Priority</th> -->
                                                        <th>Module/Submodule/Service</th>
                                                        <!-- <th>Sub Module</th> -->
                                                        <!-- <th>Service</th> -->
                                                        <!-- <th>Issue Description</th> -->
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="reportData" items="${issueTrackerReport}"
                                                        varStatus="row">
                                                        <tr>
                                                            <td style="max-width: 50px !important;">${row.index + 1}
                                                            </td>
                                                            <td> <a href="javascript:void(0)" class="text-primary"
                                                                    data-toggle="tooltip" title="Ticketing System Details"
                                                                    onclick="urlPostSubmit('issueTrackerDetails', ['trackerId', 'view'], ['${reportData.issue_tracker_id}', '0'])">
                                                                    ${reportData.issue_tracker_id}
                                                                </a></td>
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
                                                            <!-- <td>${reportData.designation}</td> -->
                                                            <td>${reportData.issue_type}</td>
                                                            <!-- <td>${reportData.priority}</td> -->
                                                            <td style="text-align: start;">
                                                                <b>Module :&nbsp;</b>${reportData.module_name} <br>
                                                                <b>Sub-Module :&nbsp;</b> 
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.submodule_name}">-<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.submodule_name} <br></c:otherwise>
                                                                </c:choose>
                                                               
                                                                <b>Service :&nbsp;</b> 
                                                                <c:choose>
                                                                    <c:when test="${empty reportData.service_name}">-<br>
                                                                    </c:when>
                                                                    <c:otherwise>${reportData.service_name} <br></c:otherwise>
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
                                                                    <span style="font-size: 11px !important;color: rgb(167, 97, 35);">to ${reportData.assignee}</span>
                                                                </c:if>
                                                                
                                                            </td>

                                                            <td>
                                                                <c:if test="${reportData.status eq 'closed'}">
                                                                    -
                                                                </c:if>
                                                                <c:if test="${reportData.status ne 'closed'}">
                                                                    <a href="javascript:void(0)" class="text-primary"
                                                                        data-toggle="tooltip"
                                                                        title="Ticketing System Details"
                                                                        onclick="urlPostSubmit('issueTrackerDetails', ['trackerId', 'view'], ['${reportData.issue_tracker_id}', '1'])"><i
                                                                            class="fa fa-edit fa-lg"
                                                                            aria-hidden="false">
                                                                        </i></a>
                                                                </c:if>

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