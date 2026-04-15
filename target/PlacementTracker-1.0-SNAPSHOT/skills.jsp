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
                <h1 class="display-6 fw-bold mb-1"><span class="text-gradient">Skill Inventory</span></h1>
                <p class="text-muted">Master your competencies and track your professional growth.</p>
            </div>
            <a href="dashboard.jsp" class="btn btn-light rounded-pill px-4 shadow-sm"><i class="bi bi-arrow-left me-2"></i>Back</a>
        </div>
    </div>
</div>

<div class="row g-4 anim-slide-up" style="animation-delay: 0.1s;">
    <!-- ADD SKILL FORM -->
    <div class="col-lg-4">
        <div class="floating-card h-100">
            <h5 class="fw-bold mb-4"><i class="bi bi-plus-circle-fill me-2 text-primary"></i>Register New Skill</h5>
            <form action="AddSkillServlet" method="post" autocomplete="off">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Skill Nomenclature</label>
                    <input type="text" name="skill_name" class="form-control" placeholder="e.g. Java, Cloud Architecture" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">Expertise Depth</label>
                    <select name="level" class="form-select">
                        <option value="Beginner">Fundamental (Beginner)</option>
                        <option value="Intermediate">Intermediate</option>
                        <option value="Advanced">Advanced Mastery</option>
                        <option value="Expert">Subject Matter Expert</option>
                    </select>
                </div>
                <button class="btn btn-primary w-100 py-3 shadow-lg">Integrate Skill</button>
            </form>
        </div>
    </div>

    <!-- SKILLS LIST -->
    <div class="col-lg-8">
        <div class="floating-card p-0 overflow-hidden h-100">
            <div class="p-4 border-bottom bg-light bg-opacity-50">
                <h5 class="fw-bold mb-0">Active Competencies</h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Skill Identity</th>
                            <th class="text-center">Expertise</th>
                            <th class="pe-4 text-end">Operations</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try (Connection con = DBConnection.getConnection()) {
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM skills WHERE user_id=? ORDER BY skill_id DESC");
                            ps.setInt(1, user_id);
                            ResultSet rs = ps.executeQuery();
                            boolean hasData = false;
                            while(rs.next()){
                                hasData = true;
                                String level = rs.getString("level");
                                String badgeClass = "text-primary bg-primary bg-opacity-10";
                                if(level.equalsIgnoreCase("Advanced")) badgeClass = "text-warning bg-warning bg-opacity-10";
                                if(level.equalsIgnoreCase("Beginner")) badgeClass = "text-info bg-info bg-opacity-10";
                                if(level.equalsIgnoreCase("Expert")) badgeClass = "text-success bg-success bg-opacity-10";
                        %>
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                        <i class="bi bi-cpu-fill text-primary"></i>
                                    </div>
                                    <span class="fw-bold text-dark"><%= rs.getString("skill_name") %></span>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="badge <%= badgeClass %> rounded-pill px-3 py-2 fw-medium"><%= level %></span>
                            </td>
                            <td class="pe-4 text-end">
                                <div class="dropdown">
                                    <button class="btn btn-light rounded-circle shadow-sm" style="width: 36px; height: 36px; padding: 0;" data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end floating-card border-0 shadow-xl p-2" style="min-width: 150px;">
                                        <li><a class="dropdown-item rounded py-2" href="editSkill.jsp?id=<%= rs.getInt("skill_id") %>"><i class="bi bi-pencil-square me-2"></i>Edit Detail</a></li>
                                        <li><hr class="dropdown-divider opacity-10"></li>
                                        <% String deleteUrl = "DeleteSkillServlet?id=" + rs.getInt("skill_id"); %>
                                        <li><a class="dropdown-item text-danger rounded py-2" href="#" onclick="confirmAction(event, 'Permanently decommission this skill record?', '<%= deleteUrl %>')"><i class="bi bi-trash3 me-2"></i>Remove</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            if(!hasData){
                                out.println("<tr><td colspan='3' class='text-center py-5'><i class='bi bi-layers fs-1 d-block mb-3 text-muted opacity-50'></i><p class='text-muted'>Your inventory is empty. Add a skill to begin.</p></td></tr>");
                            }
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