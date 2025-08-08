<div class="container-fluid d-flex justify-content-center align-items-center mt-3" style="margin-top: 30px !important;">
    <div class="card shadow-lg border-0 rounded-4 p-4 text-center"
        style="max-width: 600px; width: 100%; background-color: white;">
        <div class="card-body">
            <div class="alert alert-success mb-4" role="alert">
                <h2 class="alert-heading fw-bold"> Success!</h2>
                <p class="fs-5">Your issue has been raised successfully.</p>
                <hr class="my-3">
                <p class="fw-semibold text-muted fs-5 " style="color: black !important;">Reference Ticket Number:</p>
                <p class="fs-4 fw-bold text-primary">${ticketNumber}</p>
            </div>
            <hr class="my-4">
            <div>
                <form id="viewTicketForm" method="POST" action="viewTicket">
                    <input type="hidden" name="ticketNumber" value="${ticketNumber}" />
                    <button type="button" class="btn btn-lg btn-primary px-4" onclick="submitForm()">View
                        Ticket</button>
                </form>



            </div>
        </div>
    </div>
</div>

<script>
    function submitForm() {
        document.getElementById('viewTicketForm').submit();
    }
</script>