<div class="toast-container position-fixed top-0 end-0" style="padding: 5rem 1rem;">
    <div class="toast p-2" id="toast" role="alert" data-bs-delay="4000">
        <div class="toast-body">
            <div class="d-flex flex-column flex-grow-1 gap-2">
                <div class="d-flex align-items-center">
                    <span id="alertMsg" class="fw-semibold text-white"></span>
                    <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const alertEle = document.getElementById('alertMsg');
    const toastEle = document.getElementById("toast");
</script>