    <div class="modal fade" id="confirmModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content text-center p-4">
            <h6 class="mb-3">
                Are you sure you want to delete this record?
            </h6>
            <div>
                <button class="btn btn-danger" onclick="confirmDelete()">Yes, Delete</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
            </div>
        </div>
    </div>

<script>
    let selectedId = null;
    function openConfirm(id) {
        selectedId = id;
        let modal = new bootstrap.Modal(document.getElementById('confirmModal'));
        modal.show();
    }
    function confirmDelete() {
        document.getElementById("idToDelete").value = selectedId;
        let modalEl = document.getElementById('confirmModal');
        let modal = bootstrap.Modal.getInstance(modalEl);
        modal.hide();
        document.getElementById("form").submit();
    }
</script>