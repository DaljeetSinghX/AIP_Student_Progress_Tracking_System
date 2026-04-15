<%@ page import="java.sql.*" %>
<%@ page import="com.placementtracker.db.DBConnection" %>

<%
Integer userObj = (Integer) session.getAttribute("user_id");
String name = (String) session.getAttribute("name");

if(userObj == null){
    response.sendRedirect("login.jsp");
    return;
}

int user_id = userObj;

int skillCount = 0;
double avgScore = 0;
int completed = 0;
int pending = 0;

try (Connection con = DBConnection.getConnection()) {
    PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM skills WHERE user_id=?");
    ps1.setInt(1, user_id);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) skillCount = rs1.getInt(1);

    PreparedStatement ps2 = con.prepareStatement("SELECT AVG(score) FROM test_scores WHERE user_id=?");
    ps2.setInt(1, user_id);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()) avgScore = rs2.getDouble(1);

    PreparedStatement ps3 = con.prepareStatement("SELECT status, COUNT(*) FROM tasks WHERE user_id=? GROUP BY status");
    ps3.setInt(1, user_id);
    ResultSet rs3 = ps3.executeQuery();

    while(rs3.next()){
        if(rs3.getString("status").equalsIgnoreCase("Completed"))
            completed = rs3.getInt(2);
        else
            pending = rs3.getInt(2);
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>

<jsp:include page="includes/header.jsp" />

<div class="row mb-5 anim-slide-up">
    <div class="col-12 d-lg-flex align-items-center justify-content-between">
        <div>
            <h1 class="display-6 fw-bold mb-1"><span class="text-gradient">Hello, <%= name %>!</span></h1>
            <p class="text-muted">Explore your academic journey and skill milestones.</p>
        </div>
        <div class="mt-3 mt-lg-0">
            <a href="tasks.jsp" class="btn btn-primary shadow-lg px-4"><i class="bi bi-plus-lg me-2"></i>Manage Tasks</a>
        </div>
    </div>
</div>

<!-- BENTO STATS -->
<div class="row g-4 mb-5 anim-slide-up" style="animation-delay: 0.1s;">
    <div class="col-md-4">
        <div class="floating-card h-100 d-flex align-items-center p-4" onclick="location.href='skills.jsp'" style="cursor: pointer;">
            <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-4 me-4">
                <i class="bi bi-lightning-charge-fill fs-3"></i>
            </div>
            <div>
                <div class="small fw-bold text-muted text-uppercase mb-1" style="letter-spacing: 0.05em;">Mastered Skills</div>
                <h2 class="fw-bold mb-0"><%= skillCount %></h2>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="floating-card h-100 d-flex align-items-center p-4" onclick="location.href='testScores.jsp'" style="cursor: pointer;">
            <div class="bg-info bg-opacity-10 text-info p-3 rounded-4 me-4">
                <i class="bi bi-graph-up fs-3"></i>
            </div>
            <div>
                <div class="small fw-bold text-muted text-uppercase mb-1" style="letter-spacing: 0.05em;">Grade Average</div>
                <h2 class="fw-bold mb-0"><%= String.format("%.1f", avgScore) %>%</h2>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="floating-card h-100 d-flex align-items-center p-4" onclick="location.href='tasks.jsp'" style="cursor: pointer;">
            <div class="bg-success bg-opacity-10 text-success p-3 rounded-4 me-4">
                <i class="bi bi-check-all fs-3"></i>
            </div>
            <div>
                <div class="small fw-bold text-muted text-uppercase mb-1" style="letter-spacing: 0.05em;">Tasks Completed</div>
                <h2 class="fw-bold mb-0"><%= completed %></h2>
            </div>
        </div>
    </div>
</div>

<div class="row g-4 mb-5 anim-slide-up" style="animation-delay: 0.2s;">
    <!-- CHART -->
    <div class="col-lg-8">
        <div class="floating-card h-100">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0">Performance Trend</h5>
                <div class="btn-group">
                    <button class="btn btn-sm btn-light rounded-pill px-3 active">Monthly</button>
                </div>
            </div>
            <canvas id="lineChart" style="max-height: 280px;" data-avg="<%= avgScore %>"></canvas>
        </div>
    </div>

    <!-- TASK DISTRIBUTION -->
    <div class="col-lg-4">
        <div class="floating-card h-100 text-center">
            <h5 class="fw-bold mb-4">Task Allocation</h5>
            <div class="d-flex justify-content-center align-items-center" style="height: 220px;">
                <canvas id="pieChart" data-completed="<%= completed %>" data-pending="<%= pending %>"></canvas>
            </div>
            <div class="mt-4 row g-2">
                <div class="col-6">
                    <div class="p-2 border rounded-3">
                        <div class="small text-muted">Active</div>
                        <div class="fw-bold text-primary"><%= pending %></div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-2 border rounded-3">
                        <div class="small text-muted">Success</div>
                        <div class="fw-bold text-success"><%= completed %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- SCHEDULE -->
<div class="row anim-slide-up" style="animation-delay: 0.3s;">
    <div class="col-12">
        <div class="floating-card">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h5 class="fw-bold mb-0">Weekly Academic Roadmap</h5>
                <button class="btn btn-sm btn-light rounded-circle"><i class="bi bi-three-dots"></i></button>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Module Day</th>
                            <th>Focus Area</th>
                            <th>Target Depth</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="fw-bold">Mon Resource</td>
                            <td>Algorithm Mastery</td>
                            <td style="width: 30%;">
                                <div class="progress rounded-pill bg-light" style="height: 8px;">
                                    <div class="progress-bar bg-primary rounded-pill" style="width: 85%"></div>
                                </div>
                            </td>
                            <td class="text-end">
                                <a href="#" class="text-primary text-decoration-none small fw-bold">Review</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-bold">Tue Resource</td>
                            <td>Full-Stack Integration</td>
                            <td>
                                <div class="progress rounded-pill bg-light" style="height: 8px;">
                                    <div class="progress-bar bg-purple rounded-pill" style="width: 65%; background: var(--aurelia-purple);"></div>
                                </div>
                            </td>
                            <td class="text-end">
                                <a href="#" class="text-primary text-decoration-none small fw-bold">Review</a>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-bold">Wed Resource</td>
                            <td>Cloud Fundamentals</td>
                            <td>
                                <div class="progress rounded-pill bg-light" style="height: 8px;">
                                    <div class="progress-bar bg-mint rounded-pill" style="width: 45%; background: var(--aurelia-mint);"></div>
                                </div>
                            </td>
                            <td class="text-end">
                                <a href="#" class="text-primary text-decoration-none small fw-bold">Review</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const ctxLine = document.getElementById('lineChart');
    const ctxPie = document.getElementById('pieChart');

    Chart.defaults.font.family = "'Outfit', sans-serif";
    Chart.defaults.color = "#64748b";

    new Chart(ctxLine, {
        type: 'line',
        data: {
            labels: ['M1', 'M2', 'M3', 'M4', 'M5'],
            datasets: [{
                label: 'Efficiency',
                data: [60, 75, 70, 80, parseFloat(ctxLine.dataset.avg)],
                borderColor: '#6366f1',
                borderWidth: 4,
                pointRadius: 4,
                pointBackgroundColor: '#fff',
                pointBorderColor: '#6366f1',
                pointBorderWidth: 2,
                tension: 0.4,
                fill: true,
                backgroundColor: (context) => {
                    const chart = context.chart;
                    const {ctx, chartArea} = chart;
                    if (!chartArea) return null;
                    const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
                    gradient.addColorStop(0, 'rgba(99, 102, 241, 0)');
                    gradient.addColorStop(1, 'rgba(99, 102, 241, 0.15)');
                    return gradient;
                }
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { grid: { color: '#f1f5f9' }, border: { display: false } },
                x: { grid: { display: false } }
            }
        }
    });

    new Chart(ctxPie, {
        type: 'doughnut',
        data: {
            labels: ['Success', 'Pending'],
            datasets: [{
                data: [parseInt(ctxPie.dataset.completed), parseInt(ctxPie.dataset.pending)],
                backgroundColor: ['#6366f1', '#f1f5f9'],
                borderWidth: 0,
                hoverOffset: 12
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            cutout: '80%',
            animation: { animateRotate: true, animateScale: true }
        }
    });
});
</script>

<jsp:include page="includes/footer.jsp" />