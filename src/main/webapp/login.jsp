<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Smart Redirect: if user is already logged in, skip login page
    if (session.getAttribute("user_id") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<jsp:include page="includes/header.jsp" />

<style>
    body {
        background: linear-gradient(rgba(255, 255, 255, 0.4), rgba(255, 255, 255, 0.4)), 
                    url('images/picture4.jpg') no-repeat center center fixed !important;
        background-size: cover !important;
    }
    .login-container {
        padding-top: 5vh;
        padding-bottom: 5vh;
    }
</style>

<div class="row min-vh-100 align-items-center justify-content-center anim-slide-up login-container">
    <div class="col-md-10 col-lg-8">
        <div class="row g-0 floating-card p-0 shadow-2xl overflow-hidden">
            <!-- Left Branding Side -->
            <div class="col-lg-5 bg-primary p-5 d-none d-lg-flex flex-column justify-content-center text-white" 
                 style="background: linear-gradient(135deg, var(--primary), var(--aurelia-purple)) !important;">
                <div class="mb-5">
                    <div class="bg-white bg-opacity-20 rounded-pill d-inline-block px-3 py-1 small fw-bold mb-3">v2.0 Aurelia</div>
                    <h2 class="display-5 fw-bold mb-3">Student Progress <br><span class="opacity-75">Tracking</span></h2>
                    <p class="opacity-75">Your all-in-one portal for skill mastery, task management, and academic excellence.</p>
                </div>
                <div class="mt-auto">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <span class="small">Real-time Performance Analytics</span>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <span class="small">Interactive Skill Roadmaps</span>
                    </div>
                </div>
            </div>

            <!-- Right Auth Side -->
            <div class="col-lg-7 p-4 p-md-5 bg-white">
                <div class="text-center mb-4 d-lg-none">
                    <h3 class="fw-bold text-gradient">SPTS</h3>
                </div>

                <!-- NAV TABS -->
                <ul class="nav nav-tabs border-0 flex-nowrap mb-4 bg-light rounded-pill p-1 shadow-sm" id="authTabs" role="tablist">
                    <li class="nav-item flex-grow-1">
                        <button class="nav-link active border-0 rounded-pill w-100 py-2 small fw-bold" data-bs-toggle="pill" data-bs-target="#login" type="button">Login</button>
                    </li>
                    <li class="nav-item flex-grow-1">
                        <button class="nav-link border-0 rounded-pill w-100 py-2 small fw-bold" data-bs-toggle="pill" data-bs-target="#signup" type="button">Signup</button>
                    </li>
                    <li class="nav-item flex-grow-1">
                        <button class="nav-link border-0 rounded-pill w-100 py-2 small fw-bold" data-bs-toggle="pill" data-bs-target="#change" type="button">Reset</button>
                    </li>
                </ul>

                <!-- MESSAGES -->
                <%
                String msg = request.getParameter("msg");
                if(msg != null){
                    String alertClass = msg.contains("Invalid") || msg.contains("Not Found") ? "alert-danger" : "alert-success";
                    String iconClass = msg.contains("Invalid") || msg.contains("Not Found") ? "bi-exclamation-triangle" : "bi-check-circle";
                %>
                <div class="alert <%= alertClass %> border-0 rounded-4 mb-4 py-2 small shadow-sm d-flex align-items-center">
                    <i class="bi <%= iconClass %> me-2 fs-5"></i>
                    <span><%= msg %></span>
                </div>
                <% } %>

                <div class="tab-content" id="authTabsContent">
                    <!-- LOGIN -->
                    <div class="tab-pane fade show active" id="login" role="tabpanel">
                        <form action="AuthServlet" method="post" autocomplete="off">
                            <input type="hidden" name="action" value="login">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary">Email Address</label>
                                <input type="email" name="email" class="form-control" placeholder="name@college.com" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-secondary">Password</label>
                                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                            </div>
                            <button class="btn btn-primary w-100 py-3 mb-3">Authenticate Account</button>
                            <div class="text-center">
                                <a href="#" class="small text-decoration-none text-muted" data-bs-toggle="pill" data-bs-target="#signup">Don't have an account? Sign up</a>
                            </div>
                        </form>
                    </div>

                    <!-- SIGNUP -->
                    <div class="tab-pane fade" id="signup" role="tabpanel">
                        <form action="AuthServlet" method="post" autocomplete="off">
                            <input type="hidden" name="action" value="signup">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary">Full Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary">University Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-secondary">Create Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <button class="btn btn-primary w-100 py-3">Create Student ID</button>
                        </form>
                    </div>

                    <!-- RESET -->
                    <div class="tab-pane fade" id="change" role="tabpanel">
                        <form action="AuthServlet" method="post" autocomplete="off">
                            <input type="hidden" name="action" value="change">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary">Registered Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-secondary">New Security Key</label>
                                <input type="password" name="newPassword" class="form-control" required>
                            </div>
                            <button class="btn btn-primary w-100 py-3">Update Credentials</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />