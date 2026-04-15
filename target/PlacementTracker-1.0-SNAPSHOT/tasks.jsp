<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
Integer userObj = (Integer) session.getAttribute("user_id");
if(userObj == null){
    response.sendRedirect("login.jsp");
    return;
}
int user_id = userObj;
%>

<jsp:include page="includes/header.jsp" />

<div class="row mb-5 anim-slide-up">
    <div class="col-12">
        <div class="d-flex align-items-center justify-content-between">
            <div>
                <h1 class="display-6 fw-bold mb-1"><span class="text-gradient">Task Navigator</span></h1>
                <p class="text-muted">Orchestrate your goals and maintain peak productivity.</p>
            </div>
            <a href="dashboard.jsp" class="btn btn-light rounded-pill px-4 shadow-sm"><i class="bi bi-arrow-left me-2"></i>Back</a>
        </div>
    </div>
</div>

<div class="row g-4 mb-5 anim-slide-up" style="animation-delay: 0.1s;">
    <!-- ADD TASK -->
    <div class="col-lg-6">
        <div class="floating-card h-100">
            <h5 class="fw-bold mb-4"><i class="bi bi-calendar-plus-fill me-2 text-primary"></i>Define Objective</h5>
            <form action="AddTaskServlet" method="post" autocomplete="off" class="row g-3">
                <div class="col-md-12">
                    <label class="form-label small fw-bold text-secondary">Task Identification</label>
                    <input type="text" name="task_name" class="form-control" placeholder="e.g. Architect Database Schema" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Target Completion</label>
                    <input type="date" name="deadline" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Initial Phase</label>
                    <select name="status" class="form-select">
                        <option value="Pending">Pending Analysis</option>
                        <option value="Completed">Execution Completed</option>
                    </select>
                </div>
                <div class="col-12 mt-4">
                    <button class="btn btn-primary w-100 py-3 shadow-lg">Allocate Resources</button>
                </div>
            </form>
        </div>
    </div>

    <!-- FILTERS -->
    <div class="col-lg-6">
        <div class="floating-card h-100 border-start border-info border-5">
            <h5 class="fw-bold mb-4"><i class="bi bi-funnel-fill me-2 text-info"></i>Refine Viewport</h5>
            <form method="get" class="row g-3">
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Phase Filter</label>
                    <select name="status" class="form-select">
                        <option value="">All Phases</option>
                        <option value="Pending" <%= "Pending".equals(request.getParameter("status")) ? "selected" : "" %>>Active Pending</option>
                        <option value="Completed" <%= "Completed".equals(request.getParameter("status")) ? "selected" : "" %>>Archived Completed</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Temporal Range</label>
                    <input type="date" name="deadline" class="form-control" value="<%= request.getParameter("deadline") != null ? request.getParameter("deadline") : "" %>">
                </div>
                <div class="col-12 mt-4 d-flex gap-2">
                    <button class="btn btn-primary bg-info border-0 flex-grow-1 py-3 fw-bold shadow-lg"><i class="bi bi-search me-2"></i>Execute Query</button>
                    <a href="tasks.jsp" class="btn btn-light px-3 py-3 rounded-3"><i class="bi bi-arrow-counterclockwise"></i></a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- TASKS TABLE -->
<div class="row anim-slide-up" style="animation-delay: 0.2s;">
    <div class="col-12">
        <div class="floating-card p-0 overflow-hidden">
            <div class="p-4 border-bottom bg-light bg-opacity-50">
                <h5 class="fw-bold mb-0">Project Roadmap</h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Task Specification</th>
                            <th>Target Date</th>
                            <th class="text-center">Status</th>
                            <th class="pe-4 text-end">Management</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try {
                            Connection con = DBConnection.getConnection();
                            String statusFilter = request.getParameter("status");
                            String deadlineFilter = request.getParameter("deadline");
                            PreparedStatement ps;

                            String query = "SELECT * FROM tasks WHERE user_id=?";
                            if(statusFilter != null && !statusFilter.isEmpty()) query += " AND status=?";
                            if(deadlineFilter != null && !deadlineFilter.isEmpty()) query += " AND deadline=?";
                            query += " ORDER BY deadline ASC";

                            ps = con.prepareStatement(query);
                            ps.setInt(1, user_id);
                            int paramIdx = 2;
                            if(statusFilter != null && !statusFilter.isEmpty()) ps.setString(paramIdx++, statusFilter);
                            if(deadlineFilter != null && !deadlineFilter.isEmpty()) ps.setString(paramIdx++, deadlineFilter);

                            ResultSet rs = ps.executeQuery();
                            boolean hasData = false;
                            while(rs.next()){
                                hasData = true;
                                String status = rs.getString("status");
                                String badgeClass = status.equalsIgnoreCase("Completed") ? "text-success bg-success bg-opacity-10" : "text-warning bg-warning bg-opacity-10";
                        %>
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                        <i class="bi bi-check2-square text-primary"></i>
                                    </div>
                                    <span class="fw-bold text-dark"><%= rs.getString("task_name") %></span>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center text-muted small">
                                    <i class="bi bi-calendar3 me-2 text-primary opacity-50"></i>
                                    <%= rs.getDate("deadline") %>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="badge <%= badgeClass %> rounded-pill px-3 py-2 fw-medium"><%= status %></span>
                            </td>
                            <td class="pe-4 text-end">
                                <div class="dropdown">
                                    <button class="btn btn-light rounded-circle shadow-sm" style="width: 36px; height: 36px; padding: 0;" data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end floating-card border-0 shadow-xl p-2" style="min-width: 150px;">
                                        <li><a class="dropdown-item rounded py-2" href="editTask.jsp?id=<%= rs.getInt("task_id") %>"><i class="bi bi-pencil-square me-2"></i>Edit Task</a></li>
                                        <li><hr class="dropdown-divider opacity-10"></li>
                                        <% String deleteUrl = "DeleteTaskServlet?id=" + rs.getInt("task_id"); %>
                                        <li><a class="dropdown-item text-danger rounded py-2" href="#" onclick="confirmAction(event, 'Archive this performance record?', '<%= deleteUrl %>')"><i class="bi bi-archive-fill me-2"></i>Delete</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            if(!hasData){
                                out.println("<tr><td colspan='4' class='text-center py-5'><i class='bi bi-wind fs-1 d-block mb-3 text-muted opacity-50'></i><p class='text-muted'>No active objectives found. Adjust your view or add a task.</p></td></tr>");
                            }
                            con.close();
                        } catch(Exception e){
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />