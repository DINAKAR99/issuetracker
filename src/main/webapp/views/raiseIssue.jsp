<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


    <div style="margin-left: 10px;">
        <h1 style="margin-left: 50px;font-size: 20px !important ; text-align: center;" class="mt-4">Report an Issue</h1>
        <hr>
        <div class="mx-5  ">
            <!-- <a
                href="${pageContext.request.contextPath}/download?filePath=/Uploads/IssueTracker/Files/27/AP2543_20250202161434.pdf">test
                download </a> -->
            <form:form modelAttribute="issue" method="post" enctype="multipart/form-data" id="Issueform"
                action="submitIssue">

                <!-- Row 1 -->
                <div class="row m-0 mt-4 ">
                    <div class="offset-md-1">
                    </div>
                   
                    <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="type">Type</label><span class="text-danger">&nbsp;*</span>
                    </div>
                    <label class="col-form-label font-weight-bold" for="type">&nbsp;&nbsp;:</label>
                    <div class="col-sm-3 mt-2">
                        <div class="form-group d-flex align-items-center">
                            <form:radiobutton path="type" id="typeNonTechnical" value="Operational" checked="checked" required="true"  class="mr-1" />
                            <label for="typeNonTechnical" class="mb-0">Operational</label> &nbsp; &nbsp; &nbsp;
                            <form:radiobutton path="type" id="typeTechnical" value="Technical" required="true" class="mr-1" />
                            <label for="typeTechnical" class="mb-0 mr-3">Technical</label>
                            
                        </div>
                    </div>
                    <div class="offset-md-1">
                    </div>
                   <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId">Module&nbsp;<span
                                class="text-danger">*</span></label>
                    </div>
                    <!-- <div class="col-sm-1"> -->
                    <label class="col-form-label font-weight-bold" for="moduleId">:</label>
                    <!-- </div> -->
                    <div class="col-sm-3">
                        <div class="form-group">
                            <form:select class="selectbox2 form-control " required="true" path="module" id="module">
                                <form:option value="">-select-</form:option>
                            </form:select>
                        </div>
                    </div>
                </div>

                <!-- Row 2 -->
                <div class="row  m-0   ">

                      <div class="offset-md-1">
                    </div>
                      <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId"
                            style="min-width: 74px;">Sub-Module&nbsp; 
                        </label>
                    </div>
                    <!-- <div class="col-sm-1"> -->
                    <label class="col-form-label font-weight-bold" for="moduleId">&nbsp;&nbsp;:</label>
                    <!-- </div> -->
                    <div class="col-sm-3">
                        <div class="form-group">
                            <!-- <label for="subModule">Sub Module</label> -->
                            <form:select class="selectbox2 form-control"   path="subModule"
                                id="subModule">
                                <form:option value="0">-select-</form:option>
                            </form:select>
                        </div>
                    </div>
                    <div class="offset-md-1">
                    </div>
                 


                    <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId">Service&nbsp; </label>
                    </div>
                    <!-- <div class="col-sm-1"> -->
                    <label class="col-form-label font-weight-bold" for="moduleId">:</label>
                    <!-- </div> -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <!-- <label for="service">Service</label> -->
                            <form:select class="selectbox2 form-control"   path="service" id="service">
                                <form:option value="0">-select-</form:option>

                            </form:select>
                        </div>
                    </div>
                </div>

                <!-- Priority -->
                <!-- <div class="row  m-0  ">
                    <div class="offset-md-1">
                    </div>
                    <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId">Priority&nbsp;<span
                                class="text-danger">*</span>
                        </label>
                    </div> -->
                    <!-- <div class="col-sm-1"> -->
                    <!-- <label class="col-form-label font-weight-bold" for="moduleId">:</label>
                     <div class="col-sm-3">
                        <div class="form-group">
                             <form:select class="selectbox2 form-control" required="true" path="priority" id="priority">
                                <form:option value="">-select-</form:option>
                                <form:option value="Low">Low</form:option>
                                <form:option value="Medium">Medium</form:option>
                                <form:option value="High">High</form:option>
                            </form:select>
                        </div>
                    </div>
                </div> -->

                <!-- Description -->
                <div class="row  m-0  ">
                    <div class="offset-md-1">
                    </div>
                    <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId">Description&nbsp;<span
                                class="text-danger">*</span></label>
                    </div>
                    <!-- <div class="col-sm-1"> -->
                    <label class="col-form-label font-weight-bold" for="moduleId">:</label>
                    <!-- </div> -->
                    <div class="col-sm-8">
                        <div class="form-group">
                            <!-- <label for="description">Description</label> -->
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <form:textarea class="form-control" required="true" path="description"
                                            id="description" rows="5" placeholder="Enter Description" oninput="cleanInput(event)" maxlength="500" />
                                        <div id="charCount" class=" mt-2">500 characters remaining</div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Attachment -->
                <div class="row m-0">
                    <div class="offset-md-1">
                    </div>
                    <div class="col-sm-1">
                        <label class="col-form-label font-weight-bold" for="moduleId">Attachment&nbsp; </label>
                    </div>
                    <!-- <div class="col-sm-1"> -->
                    <label class="col-form-label font-weight-bold" for="moduleId"> :</label>
                    <!-- </div> -->
                    <div class="col-md-3">
                        <div class="form-group">
                            <input type="file" name="file_doc" id="file_doc" class="form-control py-1" />
                            <span style="width: 300px;color: red;font-size: 10px !important;display: block;">
                                Only JPG, JPEG, PNG, PDF,Excel and Word files are allowed <br>
                                (File Size Max: 1MB)
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="row d-flex justify-content-center text-center mb-1">
                    <button type="submit" class="btn btn-primary px-5">Submit</button>
                </div>


            </form:form>
        </div>
    </div>

    <script type="text/javascript">
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>

    <script>

        $(document).ready(function () {
            $.validator.addMethod('filesize', function (value, element, param) {
                return this.optional(element) || (element.files[0].size <= param)
            }, 'File size must be less than 1 mb');
            $.validator.addMethod('reture', function (value, element, param) {
                return  true
            }, 'error');
            $.validator.addMethod('fileextension', function (value, element, param) {
                var fileExtension = value.split('.').pop().toLowerCase(); // Get the file extension
                return this.optional(element) || param.indexOf(fileExtension) !== -1; // Check if the file extension is in the allowed list
            }, 'Invalid file extension. Only {0} files are allowed.');
        })
        // Initialize form validation on the myForm form element
        $("#Issueform").validate({
            // Specify validation rules
            rules: {
                module: {
                    required: true,

                },
                subModule: {
                    reture: 1,

                },
                service: {
                    reture: 1,

                },
                type: {
                    required: true,

                },
                priority: {
                    required: true,

                },
                description: {
                    required: true,

                },
                file_doc: {
                    fileextension: ["jpeg", "jpg", "png", "pdf", "xls", "xlsx", 'docx', 'doc'],
                    filesize: 1048576 // exact 1MB (1024 * 1024 bytes)
                }

            },
            // Specify validation error messages
            messages: {
                module: {
                    required: "Please Select Module",

                },
                subModule: {
                    reture: "Please Select Sub-Module",

                },
                service: {
                    reture: "Please Select Service",

                },
                type: {
                    required: "Please Select Type",

                },
                priority: {
                    required: "Please Select Priority ",

                },
                description: {
                    required: "Please Enter Description",

                },
                file_doc: {
                    fileextension: "Only JPG, PNG, PDF,XCEL  files are allowed",
                    filesize: "File size must not exceed 1 MB",
                },

            },
            // Add Bootstrap 4 styling to the error messages
            errorElement: "span",
            errorClass: "invalid-feedback",
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass("is-invalid").addClass("is-valid");
            },

            submitHandler: function (form) {
                // Submit the form
                if (confirm("Are you sure you want to submit ?")) {
                    form.submit();
                }
            },
        })

    </script>
    <script>
        // Function to remove invalid characters
        function cleanInput(event) {
        	   const regex = /[^A-Za-z0-9\s"',-./:]/g;
                const input = event.target.value;

                // Remove invalid characters
                event.target.value = input.replace(regex, '');
            }

    </script>
    <script>
        document.getElementById('description').addEventListener('input', updateCharCount);
        function updateCharCount() {
            const maxChars = 500;
            const textInput = document.getElementById('description');
            const charCount = document.getElementById('charCount');

            const remaining = maxChars - textInput.value.length;
            console.log(remaining);

            charCount.textContent = remaining + ` characters remaining`;
        }
        $(document).ready(function () {
            $.ajax({
                url: '${pageContext.request.contextPath}/getAllModules',
                type: 'GET',
                success: function (data) {
                    $('#module').empty();
                    $('#module').append('<option value="">-select-</option>');
                    $.each(data, function (index, module) {
                        console.log(module);

                        $('#module').append('<option value="' + module.id + '">' + module.moduleName + '</option>');
                    });
                }
            });
            // Fetch Submodules based on Module selection
            $('#module').change(function () {
                $('#service').empty();
                $('#service').append('<option value="0">-select-</option>');
                var moduleId = $(this).val();
                if (moduleId) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/getSubmodulesByModule/' + moduleId,
                        type: 'GET',
                        success: function (data) {
                            $('#subModule').empty();
                            $('#subModule').append('<option value="0">-select-</option>');
                            $.each(data, function (index, submodule) {
                                $('#subModule').append('<option value="' + submodule.id + '">' + submodule.submoduleName + '</option>');
                            });
                        }
                    });
                } else {
                    $('#subModule').empty().append('<option value="0">-select-</option>');
                }
            });

            // Fetch Services based on Submodule selection
            $('#subModule').change(function () {
                var submoduleId = $(this).val();
                if (submoduleId) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/getServicesBySubmodule/' + submoduleId,
                        type: 'GET',
                        success: function (data) {
                            $('#service').empty();
                            $('#service').append('<option value="0">-select-</option>');
                            $.each(data, function (index, service) {
                                $('#service').append('<option value="' + service.id + '">' + service.serviceName + '</option>');
                            });
                        }
                    });
                } else {
                    $('#service').empty().append('<option value="0">-select-</option>');
                }
            });

        });

    </script>