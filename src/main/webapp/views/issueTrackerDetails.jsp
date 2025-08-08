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
						<title>Issue Tracking Report</title>

						<!-- External CSS -->
						<link rel="stylesheet" href="<%=basePath%>resources/css/bootstrap.min.css">
						<link rel="stylesheet" href="<%=basePath%>resources/css/font-awesome4.2.min.css">
						<link rel="stylesheet" href="<%=basePath%>resources/custom.css">
						<link rel="stylesheet" href="<%=basePath%>resources/menu/sm-core-css.css">
						<link rel="stylesheet" href="<%=basePath%>resources/menu/sm-blue.css">
						<link rel="stylesheet" href="<%=basePath%>resources/css/google_poppins.css">
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
						<!-- Button to trigger the modal -->
						<button class="btn btn-primary" data-toggle="modal" data-target="#issueTrackingModal"
							hidden>Open Issue Tracking</button>

						<!-- Modal -->
						<div class="modal fade" style="z-index: 100000;backdrop-filter: brightness(0.7);"
							id="issueTrackingModal" tabindex="-1" role="dialog"
							aria-labelledby="issueTrackingModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg" role="document" style="min-width: 1000px;">

								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="issueTrackingModalLabel"
											style="text-align: center; width: 100%;">Issue Tracking Status Details</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true"
												style="color: white;font-size: 21px !important;">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<c:if test="${not empty msg}">

											<div class="alert alert-success mb-4" role="alert">
												<h2 class="alert-heading fw-bold"> Success!</h2>
												<p class="fs-5">${msg}</p>
											</div>
										</c:if>

										<form:form action="submitIssueStatus" method="post" id="issueTracker"
											modelAttribute="issueTrackerDTO" enctype="multipart/form-data">

											<input type="hidden" id="selectedIssueId" name="selectedIssueId"
												value="${issueDetails[0]['issue_tracker_id']}" />
											<input type="hidden" id="issueType" name="issueType"
												value="${issueDetails[0]['issue_tracker_id']}" />
											<input type="hidden" id="forward" name="forward" value="false" />
											<c:set var="isDisabled" value="${empty issueStatusDetails}" />

											<!-- Hidden input to store original value (set from backend) -->
											<input type="hidden" id="initialIssueType"
												value="${issueDetails[0]['issue_type']}" />
											<c:if test="${role eq 999}">
												<div class="row">
													<div class="col-md-6 d-flex"
														style="margin-left: 15px; ${view ne 1 ? 'pointer-events: none;' : ''}">
														<label class="issue-label">Issue Category:</label>

														<label>
															<input type="radio" name="issue_type" value="Technical"
																${issueDetails[0]['issue_type']=='Technical' ? 'checked'
																: '' } ${empty issueStatusDetails ? 'disabled' : '' } />
															<span style="margin-down: 2px;">Technical</span>
														</label>
														&nbsp;&nbsp;
														<label>
															<input type="radio" name="issue_type" value="Operational"
																${issueDetails[0]['issue_type']=='Operational'
																? 'checked' : '' } ${empty issueStatusDetails
																? 'disabled' : '' } />
															Operational
														</label>
													</div>
												</div>
											</c:if>

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
																<label class="issue-label">Email ID:</label> <span
																	class="issue-value">
																	${empty issueDetails[0]['email'] ? '-'
																	:issueDetails[0]['email']}


																</span>
															</div>
															<div class="col-md-6 d-flex">
																<label class="issue-label">Mobile No:</label> <span
																	class="issue-value">
																	${empty issueDetails[0]['phone'] ? '-' :
																	issueDetails[0]['phone']}
																</span>
															</div>
														</div>

														<div class="row">
															<div class="col-md-6 d-flex">
																<label class="issue-label">Ticketing System No:</label>
																<span
																	class="issue-value">${issueDetails[0]['issue_tracker_id']}</span>
															</div>
															<div class="col-md-6 d-flex">
																<label class="issue-label">Issue Date:</label> <span
																	class="issue-value">${issueDetails[0]['issue_created_date']}</span>
															</div>
														</div>

														<div class="row">
															<div class="col-md-6 d-flex">
																<label class="issue-label">Service Name:</label> <span
																	class="issue-value">
																	<c:choose>
																		<c:when
																			test="${empty  issueDetails[0]['service_name']}">
																			-
																		</c:when>
																		<c:otherwise>${issueDetails[0]['service_name']}
																		</c:otherwise>
																	</c:choose>
																</span>
															</div>
															<div class="col-md-6 d-flex">
																<label class="issue-label">Status:</label> <span
																	class="issue-value"
																	style="text-transform:capitalize !important">${issueDetails[0]['status']}</span>
															</div>
														</div>

														<div class="row">
															<!-- <div class="col-md-6 d-flex">
																<label class="issue-label">Priority:</label> <span
																	class="issue-value">${issueDetails[0]['priority']}</span>
															</div> -->
															<div class="col-md-6 d-flex">
																<label class="issue-label"
																	style="width: 41%;">Description:</label>
																<span
																	style=" overflow: auto;word-wrap: break-word;width: 60%;text-align: justify;">${issueDetails[0]['issue_description']}</span>
															</div>
														</div>
													</div>

												</c:if>
												<c:if test="${not empty issueStatusDetails}">
													<table class="table table-bordered table-striped"
														id="issueTrackerReportTable"
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
															<c:forEach var="reportData" items="${issueStatusDetails}"
																varStatus="row">
																<tr>
																	<td>${row.index + 1}</td>
																	<td>${reportData.action_by}</td>
																	<td style="text-transform:capitalize !important">
																		${reportData.status}
																		<br>
																		<c:if
																			test="${reportData.status eq 'forwarded'}">
																			<span
																				style="font-size: 11px !important;color: rgb(167, 97, 35);">
																				<c:if
																					test="${not empty reportData.assigned_to}">
																					to ${reportData.assigned_to}
																			</span>
																		</c:if>
												</c:if>

												</td>
												<td
													style="min-width: 40px !important;text-wrap: auto;word-wrap: break-word;">
													${reportData.action_time}</td>
												<td
													style="text-wrap: auto;word-wrap: break-word;text-align: justify;  ">
													<c:if test="${empty reportData.file_name }">
														-
													</c:if>
													<c:if test="${reportData.file_name ne ''}">
														<a href="${pageContext.request.contextPath}/download?filePath=${reportData.file_path}"
															target="_blank" class="mt-3">${reportData.file_name}</a>
													</c:if>
												</td>
												<td
													style="text-wrap: auto;word-wrap: break-word;text-align: justify;  ">
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

												<c:if test="${view eq 1}">
													<div class="row">
														<div class="col-md-7">
															<div class="form-group d-flex align-items-center">
																<label for="remarks" class="mr-3" style="width: 110px;">
																	Remarks: <span class="text-danger">*</span>
																</label>
																<div style="flex-grow: 1;">
																	<textarea oninput="cleanInput(event)" id="remarks"
																		name="remarks" maxlength="500"
																		class="form-control" rows="3"
																		required></textarea>
																	<small style="font-size: 9px !important;"
																		id="charCount" class=" mt-2">500 characters
																		remaining</small>
																</div>
															</div>

														</div>
													</div>

													<div class="row">
														<div class="col-md-6">
															<div class="form-group d-flex align-items-center">
																<label for="status" class="mr-3"
																	style="width: 150px;">Status:
																	<span class="text-danger">*</span></label>
																<select id="status" name="status" class="form-control"
																	onchange="checkStatus()" required
																	style="flex-grow: 1;">
																	<option value="0">--Select Status--</option>
																	<option value="In progress">In progess</option>
																	<option value="hold">Hold</option>
																	<option value="closed">Close</option>
																	<option value="rejected">Reject</option>
																	<option value="forwarded">Forward</option>
																</select>
															</div>
														</div>
														<div class="col-md-6">
															<div class="form-group d-flex align-items-center">
																<label for="fileAttach" class="mr-3"
																	style="width: 150px; ">File
																	Attach: </label> <input type="file" id="issueFile"
																	name="issueFile" class="form-control"
																	accept=".pdf, .jpg, .jpeg, .png, .gif"
																	style="flex-grow: 1;padding: 2px;"
																	onchange="return validFile('issueFile','5', '200', ['pdf','jpg','png'])">

															</div>
															<div style="margin-left: 150px;">
																<small class="text-danger"
																	style="font-size: 12px;">[Supported
																	formats: PDF, JPG, JPEG, PNG, GIF]</small>
															</div>

														</div>
													</div>
													<div class="row" id="forwardiv" style="display: none;">
														<div class="col-md-6">
															<div class="form-group d-flex align-items-center">
																<label for="status" class="mr-3"
																	style="width: 150px;">Forward To :
																	<span class="text-danger">*</span></label>
																<select id="forwardofficer" name="forwardofficer"
																	class="form-control" required style="flex-grow: 1;">
																	<option value="0">--Select--</option>
																	<c:forEach var="item" items="${forwardTo}">
																		<option value="${item.approver_userid}">
																			${item.approver_userid}</option>
																	</c:forEach>


																</select>
															</div>
														</div>

													</div>



													<div class="form-buttons d-flex justify-content-center">
														<button type="submit" class="btn btn-primary"
															onclick="return validateForm()">Submit</button>
													</div>

												</c:if>
											</div>
										</form:form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
						<!-- report -->

						<div class="m-2">
							<div class="card">
								<div class="card-header">
									<h2 style="font-size: 18px !important;color: white;text-align: center;">Issue
										Tracking Approval</h2>
								</div>

								<div class="card-body">
									<c:if test="${not empty msg}">
										<div class="msg-success">${msg}</div>
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
																	data-toggle="tooltip"
																	title="Ticketing System Details"
																	onclick="urlPostSubmit('issueTrackerDetails', ['trackerId', 'view'], ['${reportData.issue_tracker_id}', '0'])">
																	${reportData.issue_tracker_id}
																</a></td>
															<td>
																<c:choose>
																	<c:when test="${empty reportData.district_name}">
																		-<br>
																	</c:when>
																	<c:otherwise>${reportData.district_name} <br>
																	</c:otherwise>
																</c:choose>
															</td>
															<td>
																<c:choose>
																	<c:when test="${empty reportData.mandal_name}">
																		-<br>
																	</c:when>
																	<c:otherwise>${reportData.mandal_name} <br>
																	</c:otherwise>
																</c:choose>
															</td>
															<td>
																<c:choose>
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
																<b>Desg.:&nbsp; </b>${reportData.designation}
															</td>
															<!-- <td>${reportData.designation}</td> -->
															<td>${reportData.issue_type}</td>
															<!-- <td>${reportData.priority}</td> -->
															<td style="text-align: start;">
																<b>Module :&nbsp;</b>${reportData.module_name} <br>
																<b>Sub-Module :&nbsp;</b> ${reportData.submodule_name}
																<br>
																<b>Service :&nbsp;</b> ${reportData.service_name}
															</td>
															<!-- <td>${reportData.submodule_name}</td> -->
															<!-- <td>${reportData.service_name}</td> -->

															<!-- <td style="text-align: start;text-wrap: inherit;white-space: pre-wrap !important; 
						                                                            ">${reportData.issue_description}</td> -->
															<td style="text-transform:capitalize !important">
																${reportData.status}
																<br>
																<c:if test="${reportData.status eq 'forwarded'}">
																	<span
																		style="font-size: 11px !important;color: rgb(167, 97, 35);">
																		<c:if test="${not empty reportData.assignee}">
																			to ${reportData.assignee}
																	</span>
																</c:if>
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

						<!-- report -->
						<!-- Bootstrap JS -->
						<script
							src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
						<script>
							// Function to remove invalid characters
							function cleanInput(event) {
								const regex = /[^A-Za-z0-9\s"',-./:]/g; // Match any character that is NOT a letter, number, hyphen, or space
								const input = event.target.value;

								// Remove invalid characters
								event.target.value = input.replace(regex, '');
							}

							document.getElementById('remarks').addEventListener('input', updateCharCount);
							function updateCharCount() {
								const maxChars = 500;
								const textInput = document.getElementById('remarks');
								const charCount = document.getElementById('charCount');

								const remaining = maxChars - textInput.value.length;
								console.log(remaining);

								charCount.textContent = remaining + ` characters remaining`;
							}

						</script>
						<script>
							// document.getElementById('status').addEventListener('change', function () {
							// 		var statusValue = this.value;
							// 		var forwardDiv = document.getElementById('forwardiv');

							// 		if (statusValue === 'forwarded') {
							// 			forwardDiv.style.display = 'block';  // Show the div
							// 		} else {
							// 			forwardDiv.style.display = 'none';   // Hide the div
							// 		}
							// 	});

							function checkStatus() {

								// var statusValue = this.value;
								var statusValue = document.getElementById('status').value;
								var forwardDiv = document.getElementById('forwardiv');
								console.log("--------" + statusValue);

								if (statusValue === 'forwarded') {
									forwardDiv.style.display = 'block';  // Show the div
								} else {
									forwardDiv.style.display = 'none';   // Hide the div
								}
							}

							function validateForm() {
								var remarks = document.getElementById('remarks').value;
								var status = document.getElementById('status').value;
								//check if category is changed then true 
								const original = document.getElementById("initialIssueType").value;
								let current = document.querySelector('input[name="issue_type"]:checked')?.value;
								if (current == undefined) {
									current = original;
								}
								const isChanged = original !== current;
								if (isChanged) {
									document.getElementById('forwardofficer').value = current == 'Technical' ? 'CGGADMIN' : 'TSECADMIN';
									document.getElementById('status').value = 'forwarded';
									document.getElementById('remarks').value = document.getElementById('remarks').value === "" ? 'Forwarded ' : document.getElementById('remarks').value;
									document.getElementById('issueTracker').submit();
								}
								else if (remarks.trim() === "") {
									alert("Please enter Remarks.");
									return false;
								}

								else if (status === "0") {
									alert("Please select the Status.");
									return false;
								}
								else if (status === "forwarded") {

									var forwardofficer = document.getElementById('forwardofficer');
									if (forwardofficer.value.trim() === "0") {
										alert("Please select the Officer To Forward.");
										return false;
									}
								}

								document.getElementById('issueTracker').submit();
							}


							function validFile(id, minSizeKB, maxSizeKB, extns) {

								var fileName = "";
								var dots = "";
								var fileType = "";
								if ($("#" + id).val() == "" || $("#" + id).val() == null) {
									bootbox.alert("Please upload  file");
									return false;
								} else {
									file = $("#" + id).val().toLowerCase();
									extension = file.substring(file.lastIndexOf('.') + 1);
									if (!($.inArray(extension, extns) > -1)) {
										bootbox.alert("Please Upload " + extns + " files!");
										$("#" + id).val("");
										$("#" + id).focus();
										return false;
									}
									var s = parseInt(($("#" + id)[0].files[0].size))//1024;///1048576
									//  alert(s);
									if (parseInt(s) < parseInt(minSizeKB)) {
										bootbox.alert("Please Upload minimum " + minSizeKB
											+ "kb file!");
										$("#" + id).val("");
										$("#" + id).focus();
										return false;
									}
									if (parseInt(s) > parseInt(maxSizeKB)) {
										bootbox.alert("Please Upload between " + minSizeKB
											+ "kb - " + maxSizeKB + "kb file!");
										$("#" + id).val("");
										$("#" + id).focus();
										return false;
									}
								}

							}

							document.addEventListener("DOMContentLoaded", function () {

								document.querySelector('[data-target="#issueTrackingModal"]').click();
							});

						</script>
						<script>
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

						</script>
						<script>
							$(window).on('resize', function () {
								$('#issueTrackerReportTable2').DataTable().columns.adjust().draw();
							});
						</script>
					</body>

					</html>