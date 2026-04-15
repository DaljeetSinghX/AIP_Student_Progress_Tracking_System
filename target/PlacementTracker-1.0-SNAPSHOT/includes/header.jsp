<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Progress Tracking System</title>
    
    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<%
    String currentPath = request.getRequestURI();
    boolean isLoginPage = currentPath.endsWith("login.jsp") || currentPath.endsWith("index.html") || currentPath.endsWith("/");
    Integer userId = (Integer) session.getAttribute("user_id");
    String userName = (String) session.getAttribute("name");
%>

<% if (!isLoginPage) { %>
<nav class="navbar navbar-expand-lg aurelia-nav sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold text-dark" href="dashboard.jsp">
            <i class="bi bi-rocket-takeoff-fill me-2 text-primary"></i><span class="text-gradient">SPTS</span>
        </a>
        
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="bi bi-grid-fill fs-4"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("dashboard.jsp") ? "active" : "" %>" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("skills.jsp") ? "active" : "" %>" href="skills.jsp">Skills</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("tasks.jsp") ? "active" : "" %>" href="tasks.jsp">Tasks</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("testScores.jsp") ? "active" : "" %>" href="testScores.jsp">Scores</a>
                </li>
            </ul>
            
            <div class="dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center bg-light rounded-pill px-3 py-2 shadow-sm" href="#" role="button" data-bs-toggle="dropdown">
                    <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-weight: 600;">
                        <%= userName != null ? userName.substring(0, 1).toUpperCase() : "U" %>
                    </div>
                    <span class="fw-medium text-dark small"><%= userName %></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end floating-card border-0 mt-3 p-2 shadow-lg">
                    <li><a class="dropdown-item rounded" href="profile.jsp"><i class="bi bi-person me-2"></i> Profile</a></li>
                    <li><hr class="dropdown-divider opacity-10"></li>
                    <li><a class="dropdown-item text-danger rounded" href="LogoutServlet"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<% } %>

<div class="container pb-5 mt-4">
