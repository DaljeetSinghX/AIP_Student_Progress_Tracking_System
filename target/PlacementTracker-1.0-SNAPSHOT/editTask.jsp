<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
String taskName = "";
Date deadline = null;
String status = "";

try (Connection con = DBConnection.getConnection()) {
    PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE task_id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if(rs.next()) {
        taskName = rs.getString("task_name");
        deadline = rs.getDate("deadline");
        status = rs.getString("status");
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>

<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center anim-slide-up">
    <div class="col-md-6 col-lg-4">
        <div class="floating-card shadow-2xl">
            <div class="d-flex align-items-center mb-5">
                <div class="bg-primary bg-opacity-10 p-3 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                    <i class="bi bi-calendar-range-fill fs-3 text-primary"></i>
                </div>
                <div>
                    <h4 class="fw-bold mb-0">Modify Objective</h4>
                    <p class="text-muted small mb-0">Update your project trajectory.</p>
                </div>
            </div>

            <form action="UpdateTaskServlet" method="post" autocomplete="off">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Task Specification</label>
                    <input type="text" name="task_name" class="form-control" value="<%= taskName %>" required placeholder="What needs orchestration?">
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Temporal Constraint (Deadline)</label>
                    <input type="date" name="deadline" class="form-control" value="<%= deadline %>" required>
                </div>

                <div class="mb-5">
                    <label class="form-label small fw-bold text-secondary">Operational Status</label>
                    <select name="status" class="form-select">
                        <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Phase: Pending Analysis</option>
                        <option value="In Progress" <%= "In Progress".equals(status) ? "selected" : "" %>>Phase: Active Execution</option>
                        <option value="Completed" <%= "Completed".equals(status) ? "selected" : "" %>>Phase: Finalized</option>
                    </select>
                </div>

                <div class="d-grid gap-3">
                    <button type="submit" class="btn btn-primary py-3 fw-bold shadow-lg rounded-3">Synchronize Objective</button>
                    <a href="tasks.jsp" class="btn btn-light py-3 border-0 rounded-3 text-muted fw-medium text-center">Discard Changes</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />