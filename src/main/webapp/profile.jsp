<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
Integer userObj = (Integer) session.getAttribute("user_id");
if(userObj == null){
    response.sendRedirect("login.jsp");
    return;
}

int user_id = userObj;
String name="", email="";

try (Connection con = DBConnection.getConnection()) {
    PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id=?");
    ps.setInt(1, user_id);
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        name = rs.getString("name");
        email = rs.getString("email");
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>

<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center anim-slide-up">
    <div class="col-md-8 col-lg-5">
        <div class="floating-card p-0 overflow-hidden shadow-2xl">
            <!-- Header with Profile Info -->
            <div class="bg-primary bg-opacity-5 p-5 text-center border-bottom">
                <div class="mb-4 d-inline-block position-relative">
                    <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center text-white shadow-xl mx-auto" style="width: 120px; height: 120px; font-size: 3.5rem; background: linear-gradient(135deg, var(--primary) 0%, #a78bfa 100%); border: 4px solid #fff;">
                        <%= name.substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="position-absolute bottom-0 end-0 bg-white rounded-circle shadow p-2" style="transform: translate(25%, 25%); cursor: pointer;">
                        <i class="bi bi-camera-fill text-primary mb-0"></i>
                    </div>
                </div>
                <h2 class="fw-bold mb-1"><span class="text-gradient"><%= name %></span></h2>
                <p class="text-muted fw-medium mb-0"><%= email %></p>
            </div>

            <!-- Form Body -->
            <div class="card-body p-4 p-lg-5">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h5 class="fw-bold mb-0">Account Synthesis</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill small">Active Status</span>
                </div>
                
                <%
                String msg = request.getParameter("msg");
                if(msg != null){
                %>
                <div class="alert bg-success bg-opacity-10 text-success border-0 mb-4 py-3 rounded-4 small animate-bounce-in">
                    <i class="bi bi-check-circle-fill me-2"></i><%= msg %>
                </div>
                <% } %>

                <form action="UpdateProfileServlet" method="post" autocomplete="off">
                    <div class="mb-4">
                        <label class="form-label small fw-bold text-secondary">Display Nomenclature</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0 text-muted"><i class="bi bi-person-fill"></i></span>
                            <input type="text" name="name" value="<%= name %>" class="form-control" required>
                        </div>
                    </div>

                    <div class="mb-5">
                        <label class="form-label small fw-bold text-secondary">Primary Communications (Immutable)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0 text-muted"><i class="bi bi-envelope-at-fill"></i></span>
                            <input type="email" value="<%= email %>" class="form-control bg-light opacity-75" disabled>
                        </div>
                        <div class="form-text text-muted x-small mt-2 px-1">
                            <i class="bi bi-shield-lock-fill me-1 text-primary"></i> 
                            Protocol: Email modification restricted for authentication integrity.
                        </div>
                    </div>

                    <div class="d-grid gap-3">
                        <button class="btn btn-primary py-3 fw-bold shadow-lg rounded-3">Update Core Record</button>
                        <a href="dashboard.jsp" class="btn btn-light py-3 border-0 rounded-3 text-muted fw-medium">Return to Console</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
