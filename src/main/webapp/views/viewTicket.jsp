<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div style="margin-left: 10px;margin-bottom: 40px;">
        <h2 style="margin-left: 50px;font-size: 15px !important;" class="mt-4">Ticket No :
            ${ticketDetails.issue_tracker_id}</h2>
        <hr>
        <div class="mx-4">
    <!-- Row 1 -->
    <div class="row mt-3 mb-2">
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="module">Module</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-3 ps-1">
            <div class="form-group mb-0">
                <input type="text" class="form-control" id="module" disabled="true" name="module"
                    value="${ticketDetails.module_name}" />
            </div>
        </div>
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="subModule">SubModule</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-3 ps-1">
            <div class="form-group mb-0">
                <input class="form-control" name="subModule" id="subModule"
                    value="${ticketDetails.submodule_name}" disabled="true" />
            </div>
        </div>
    </div>

    <!-- Row 2 -->
    <div class="row mb-2">
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="service">Service</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-3 ps-1">
            <div class="form-group mb-0">
                <input class="form-control" name="service" id="service" value="${ticketDetails.service_name}"
                    disabled="true" />
            </div>
        </div>
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="type">Type</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-3 ps-1">
            <div class="form-group mb-0">
                <input class="form-control" name="type" id="type" value="${ticketDetails.issue_type}"
                    disabled="true" />
            </div>
        </div>
    </div>

    <!-- Status -->
    <div class="row mb-2">
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="status">Status</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-3 ps-1">
            <div class="form-group mb-0">
                <input class="form-control" style="text-transform:capitalize !important" name="status"
                    id="status" value="${ticketDetails.status}" disabled="true" />
            </div>
        </div>
    </div>

    <!-- Description -->
    <div class="row mb-2">
        <div class="col-sm-1 pe-0">
            <label class="col-form-label font-weight-bold" for="description">Description</label>
        </div>
        <div class="col-sm-auto px-0" style="width: 10px;">
            <label class="col-form-label font-weight-bold">:</label>
        </div>
        <div class="col-sm-8 ps-1">
            <div class="form-group mb-0">
                <textarea class="form-control" name="description" id="description" rows="6" required="true"
                    disabled="true" placeholder="Enter Description">${ticketDetails.issue_description}</textarea>
            </div>
        </div>
    </div>

    <!-- Attachment -->
    <c:if test="${not empty ticketDetails.file_attachment_original_name}">
        <div class="row mb-2">
            <div class="col-sm-1 pe-0">
                <label class="col-form-label font-weight-bold" for="attachment">Attachment</label>
            </div>
            <div class="col-sm-auto px-0" style="width: 10px;">
                <label class="col-form-label font-weight-bold">:</label>
            </div>
            <div class="col-md-8 ps-1">
                <div class="form-group mb-0 mt-2">
                    <a href="${pageContext.request.contextPath}/download?filePath=${ticketDetails.file_path}"
                        target="_blank">${ticketDetails.file_attachment_original_name}</a>   
                </div>
            </div>
        </div>
    </c:if>
    
    <!-- Remarks -->
    <c:if test="${not empty ticketDetails.remarks}">
        <div class="row mb-2">
            <div class="col-sm-1 pe-0">
                <label class="col-form-label font-weight-bold" for="remarks">Remarks</label>
            </div>
            <div class="col-sm-auto px-0" style="width: 10px;">
                <label class="col-form-label font-weight-bold">:</label>
            </div>
            <div class="col-md-8 ps-1">
                <div class="form-group mb-0 mt-2">
                    ${ticketDetails.remarks}
                </div>
            </div>
        </div>
    </c:if>

    <!-- Submit Button -->
    <div class="row mt-4">
        <div class="col-12 text-center">
            <button type="button"
                onclick="window.location.href='${pageContext.request.contextPath}/raiseIssue'; return false;"
                class="btn btn-primary px-5" style="background-color: #e7d44f; color: black;">Go
                Home</button>
        </div>
    </div>
</div>
</div>
    <script type="text/javascript">
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>