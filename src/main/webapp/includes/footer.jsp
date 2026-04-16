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
<!-- Cursor Effects: Aura Glow and Shockwave -->
<style>
    .cursor-glow-aura {
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(147, 51, 234, 0.3) 0%, rgba(99, 102, 241, 0.1) 50%, transparent 70%);
        position: fixed;
        top: 0;
        left: 0;
        border-radius: 50%;
        pointer-events: none;
        z-index: 9997;
        will-change: transform;
    }

    .cursor-shockwave {
        position: fixed;
        border-radius: 50%;
        pointer-events: none;
        transform: translate(-50%, -50%);
        z-index: 9999;
        animation: shockwave-anim 0.8s cubic-bezier(0.165, 0.84, 0.44, 1) forwards;
    }

    @keyframes shockwave-anim {
        0% {
            width: 10px;
            height: 10px;
            background: rgba(147, 51, 234, 0.8);
            box-shadow: 0 0 0 0 rgba(147, 51, 234, 0.8),
                        0 0 0 0 rgba(99, 102, 241, 0.6);
            opacity: 1;
        }
        100% {
            width: 80px;
            height: 80px;
            background: rgba(147, 51, 234, 0);
            box-shadow: 0 0 0 50px rgba(147, 51, 234, 0),
                        0 0 0 100px rgba(99, 102, 241, 0);
            opacity: 0;
        }
    }
</style>

<script>
    // 1. Fluid Aura Glow around Mouse
    const glow = document.createElement('div');
    glow.className = 'cursor-glow-aura';
    document.body.appendChild(glow);

    let mouseX = window.innerWidth / 2;
    let mouseY = window.innerHeight / 2;
    let glowX = mouseX;
    let glowY = mouseY;
    
    window.addEventListener('mousemove', (e) => {
        mouseX = e.clientX;
        mouseY = e.clientY;
    }, true);

    function animateGlow() {
        // Fluid interpolation for smooth lagging effect
        glowX += (mouseX - glowX) * 0.12;
        glowY += (mouseY - glowY) * 0.12;
        
        // Offset by half size (200px) to center on cursor
        glow.style.transform = `translate(${glowX - 200}px, ${glowY - 200}px)`;
        requestAnimationFrame(animateGlow);
    }
    animateGlow();

    // 2. Multi-ring Shockwave Ripple on Click
    window.addEventListener('click', (e) => {
        const wave = document.createElement('div');
        wave.className = 'cursor-shockwave';
        
        wave.style.left = e.clientX + 'px';
        wave.style.top = e.clientY + 'px';
        document.body.appendChild(wave);
        
        setTimeout(() => wave.remove(), 800);
    }, true);
</script>
</body>
</html>
