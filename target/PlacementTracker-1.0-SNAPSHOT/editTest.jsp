<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
String testName = "";
int score = 0;
Date date = null;

try (Connection con = DBConnection.getConnection()) {
    PreparedStatement ps = con.prepareStatement("SELECT * FROM test_scores WHERE test_id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if(rs.next()) {
        testName = rs.getString("test_name");
        score = rs.getInt("score");
        date = rs.getDate("date");
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
                    <i class="bi bi-award-fill fs-3 text-primary"></i>
                </div>
                <div>
                    <h4 class="fw-bold mb-0">Adjust Record</h4>
                    <p class="text-muted small mb-0">Correct assessment telemetry.</p>
                </div>
            </div>

            <form action="UpdateTestServlet" method="post" autocomplete="off">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Assessment Specification</label>
                    <input type="text" name="test_name" class="form-control" value="<%= testName %>" required placeholder="e.g. System Design Interview">
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Corrected Performance (%)</label>
                    <div class="input-group">
                        <input type="number" name="score" class="form-control" value="<%= score %>" min="0" max="100" required>
                        <span class="input-group-text bg-light border-0 fw-bold">%</span>
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label small fw-bold text-secondary">Certification Date</label>
                    <input type="date" name="date" class="form-control" value="<%= date %>" required>
                </div>

                <div class="d-grid gap-3">
                    <button type="submit" class="btn btn-primary py-3 fw-bold shadow-lg rounded-3">Update Core Result</button>
                    <a href="testScores.jsp" class="btn btn-light py-3 border-0 rounded-3 text-muted fw-medium text-center">Discard Changes</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />