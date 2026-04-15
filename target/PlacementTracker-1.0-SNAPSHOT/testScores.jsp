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
                <h1 class="display-6 fw-bold mb-1"><span class="text-gradient">Performance Insights</span></h1>
                <p class="text-muted">Analyze your academic achievements and score trajectory.</p>
            </div>
            <a href="dashboard.jsp" class="btn btn-light rounded-pill px-4 shadow-sm"><i class="bi bi-arrow-left me-2"></i>Back</a>
        </div>
    </div>
</div>

<div class="row g-4 mb-5 anim-slide-up" style="animation-delay: 0.1s;">
    <!-- ADD SCORE -->
    <div class="col-lg-7">
        <div class="floating-card h-100">
            <h5 class="fw-bold mb-4"><i class="bi bi-award-fill me-2 text-primary"></i>Archive Assessment</h5>
            <form action="AddTestServlet" method="post" autocomplete="off" class="row g-3">
                <div class="col-md-12">
                    <label class="form-label small fw-bold text-secondary">Assessment Identity</label>
                    <input type="text" name="test_name" class="form-control" placeholder="e.g. Advanced Java Certification" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Percentage Yield</label>
                    <div class="input-group">
                        <input type="number" name="score" class="form-control" min="0" max="100" placeholder="0-100" required>
                        <span class="input-group-text bg-light border-0 fw-bold">%</span>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-bold text-secondary">Certification Date</label>
                    <input type="date" name="date" class="form-control" required>
                </div>
                <div class="col-12 mt-4">
                    <button class="btn btn-primary w-100 py-3 shadow-lg">Commit Record</button>
                </div>
            </form>
        </div>
    </div>

    <!-- DATE FILTER -->
    <div class="col-lg-5">
        <div class="floating-card h-100 border-start border-info border-5">
            <h5 class="fw-bold mb-4"><i class="bi bi-search-heart-fill me-2 text-info"></i>Temporal Search</h5>
            <form method="get" class="row g-3">
                <div class="col-12">
                    <label class="form-label small fw-bold text-secondary">Select Reference Date</label>
                    <input type="date" name="filter_date" class="form-control" value="<%= request.getParameter("filter_date") != null ? request.getParameter("filter_date") : "" %>">
                </div>
                <div class="col-12 mt-4 d-flex gap-2">
                    <button class="btn btn-primary bg-info border-0 flex-grow-1 py-3 fw-bold shadow-lg">Locate Entries</button>
                    <% if(request.getParameter("filter_date") != null && !request.getParameter("filter_date").isEmpty()) { %>
                        <a href="testScores.jsp" class="btn btn-light px-3 py-3 rounded-3"><i class="bi bi-x-circle-fill text-muted"></i></a>
                    <% } %>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- SCORES TABLE -->
<div class="row anim-slide-up" style="animation-delay: 0.2s;">
    <div class="col-12">
        <div class="floating-card p-0 overflow-hidden">
            <div class="p-4 border-bottom bg-light bg-opacity-50">
                <h5 class="fw-bold mb-0">Academic Transcript</h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Assessment Title</th>
                            <th class="text-center">Reference Date</th>
                            <th class="text-center">Proficiency Bar</th>
                            <th class="pe-4 text-end">Control</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try (Connection con = DBConnection.getConnection()) {
                            String dateFilter = request.getParameter("filter_date");
                            PreparedStatement ps;
                            String query = "SELECT * FROM test_scores WHERE user_id=?";
                            if(dateFilter != null && !dateFilter.isEmpty()) query += " AND date=?";
                            query += " ORDER BY date DESC";

                            ps = con.prepareStatement(query);
                            ps.setInt(1, user_id);
                            if(dateFilter != null && !dateFilter.isEmpty()) ps.setString(2, dateFilter);

                            ResultSet rs = ps.executeQuery();
                            boolean hasData = false;
                            while(rs.next()){
                                hasData = true;
                                int score = rs.getInt("score");
                                String progressClass = "bg-primary";
                                if(score >= 80) progressClass = "bg-success";
                                else if(score < 50) progressClass = "bg-danger";
                        %>
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                        <i class="bi bi-patch-check-fill text-primary"></i>
                                    </div>
                                    <span class="fw-bold text-dark"><%= rs.getString("test_name") %></span>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="text-muted small fw-medium"><%= rs.getDate("date") %></span>
                            </td>
                            <td class="text-center" style="width: 25%;">
                                <div class="d-flex align-items-center justify-content-center">
                                    <div class="progress rounded-pill bg-light flex-grow-1 me-3" style="height: 10px;">
                                        <% String styleAttr = "width: " + score + "%;"; %>
                                        <div class="progress-bar <%= progressClass %> rounded-pill" style="<%= styleAttr %>"></div>
                                    </div>
                                    <span class="fw-bold text-dark small"><%= score %>%</span>
                                </div>
                            </td>
                            <td class="pe-4 text-end">
                                <div class="dropdown">
                                    <button class="btn btn-light rounded-circle shadow-sm" style="width: 36px; height: 36px; padding: 0;" data-bs-toggle="dropdown">
                                        <i class="bi bi-three-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end floating-card border-0 shadow-xl p-2" style="min-width: 150px;">
                                        <li><a class="dropdown-item rounded py-2" href="editTest.jsp?id=<%= rs.getInt("test_id") %>"><i class="bi bi-pencil-square me-2"></i>Modify Result</a></li>
                                        <li><hr class="dropdown-divider opacity-10"></li>
                                        <% String deleteUrl = "DeleteTestServlet?id=" + rs.getInt("test_id"); %>
                                        <li><a class="dropdown-item text-danger rounded py-2" href="#" onclick="confirmAction(event, 'Purge this assessment result from history?', '<%= deleteUrl %>')"><i class="bi bi-eraser-fill me-2"></i>Discard</a></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            if(!hasData){
                                out.println("<tr><td colspan='4' class='text-center py-5'><i class='bi bi-journal-x fs-1 d-block mb-3 text-muted opacity-50'></i><p class='text-muted'>No assessment records found. Time to achieve excellence!</p></td></tr>");
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