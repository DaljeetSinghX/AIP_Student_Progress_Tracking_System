<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
String skillName = "";
String level = "";

try (Connection con = DBConnection.getConnection()) {
    PreparedStatement ps = con.prepareStatement("SELECT * FROM skills WHERE skill_id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if(rs.next()) {
        skillName = rs.getString("skill_name");
        level = rs.getString("level");
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
                    <i class="bi bi-pencil-fill fs-3 text-primary"></i>
                </div>
                <div>
                    <h4 class="fw-bold mb-0">Refine Skill</h4>
                    <p class="text-muted small mb-0">Adjust your expertise parameters.</p>
                </div>
            </div>

            <form action="UpdateSkillServlet" method="post" autocomplete="off">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Skill Specification</label>
                    <input type="text" name="skill_name" class="form-control" value="<%= skillName %>" required placeholder="e.g. Distributed Systems">
                </div>

                <div class="mb-5">
                    <label class="form-label small fw-bold text-secondary">Current Mastery Level</label>
                    <select name="level" class="form-select">
                        <option value="Beginner" <%= "Beginner".equals(level) ? "selected" : "" %>>Fundamental (Beginner)</option>
                        <option value="Intermediate" <%= "Intermediate".equals(level) ? "selected" : "" %>>Proficient (Intermediate)</option>
                        <option value="Advanced" <%= "Advanced".equals(level) ? "selected" : "" %>>Advanced Mastery</option>
                        <option value="Expert" <%= "Expert".equals(level) ? "selected" : "" %>>Subject Matter Expert</option>
                    </select>
                </div>

                <div class="d-grid gap-3">
                    <button type="submit" class="btn btn-primary py-3 fw-bold shadow-lg rounded-3">Synchronize Skill</button>
                    <a href="skills.jsp" class="btn btn-light py-3 border-0 rounded-3 text-muted fw-medium text-center">Discard Changes</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />