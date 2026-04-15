</div> <!-- End container from header.jsp -->

</div> <!-- End container from header.jsp -->

<footer class="footer mt-auto py-5 text-center">
    <div class="container">
        <div class="d-flex flex-column align-items-center">
            <div class="footer-separator mb-4" style="width: 50px; height: 3px; background: var(--primary); opacity: 0.2; border-radius: 10px;"></div>
            <p class="text-muted small fw-medium mb-1">&copy; 2026 <span class="text-primary fw-bold">Student Progress Tracking System</span></p>
            <p class="text-muted x-small opacity-75">Architecting Academic Excellence through Aurelia UI</p>
            <div class="d-flex gap-4 mt-3">
                <a href="#" class="text-muted text-decoration-none small hover-primary"><i class="bi bi-github me-1"></i>Repository</a>
                <a href="#" class="text-muted text-decoration-none small hover-primary"><i class="bi bi-patch-question-fill me-1"></i>Knowledge Base</a>
                <a href="mailto:support@placementtracker.com" class="text-muted text-decoration-none small hover-primary"><i class="bi bi-headset me-1"></i>Support Node</a>
            </div>
        </div>
    </div>
</footer>

<!-- Custom Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content floating-card border-0 p-3">
            <div class="modal-body text-center p-4">
                <div class="bg-primary bg-opacity-10 p-3 rounded-circle d-inline-block mb-4">
                    <i class="bi bi-question-lg fs-2 text-primary"></i>
                </div>
                <h4 class="fw-bold mb-2">Are you sure?</h4>
                <p class="text-muted mb-5" id="confirmModalBody">This action might be irreversible.</p>
                <div class="d-grid gap-3 d-sm-flex justify-content-center">
                    <button type="button" class="btn btn-light px-5 py-3 rounded-3 text-muted fw-bold" data-bs-dismiss="modal">Cancel</button>
                    <a id="confirmModalBtn" href="#" class="btn btn-primary px-5 py-3 rounded-3 fw-bold shadow-lg">Confirm Action</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmAction(event, message, targetUrl) {
        event.preventDefault();
        const modalBody = document.getElementById('confirmModalBody');
        const modalBtn = document.getElementById('confirmModalBtn');
        const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
        
        modalBody.textContent = message;
        modalBtn.href = targetUrl;
        modal.show();
    }
</script>

<!-- JS Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</body>
</html>
