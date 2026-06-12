<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Watch Shop - Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
    body { background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); min-height: 100vh; }
    .nav-tabs .nav-link { color: #555; font-weight: 600; border: none; padding: 12px 30px; }
    .nav-tabs .nav-link.active { color: #000; border-bottom: 3px solid #000; background: transparent; }
    .nav-tabs { border-bottom: 1px solid #dee2e6; }
</style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-5">

                <%
                    String error = request.getParameter("error");
                    String tab   = request.getParameter("tab");
                    if (tab == null) tab = "user";
                %>

                <% if ("locked".equals(error)) { %>
                    <div class="alert alert-danger text-center">
                        <i class="bi bi-shield-x me-1"></i>Access denied. Admins only.
                    </div>
                <% } %>

                <div class="card shadow border-0" style="border-radius:16px; overflow:hidden;">
                    <div class="card-header bg-white pt-4 pb-0 text-center">
                        <h5 class="fw-bold mb-3">Welcome to Luxury Watch</h5>
                        <ul class="nav nav-tabs justify-content-center border-0">
                            <li class="nav-item">
                                <a class="nav-link <%= "user".equals(tab) ? "active" : "" %>"
                                   href="login.jsp?tab=user">
                                    <i class="bi bi-person me-1"></i>User Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <%= "admin".equals(tab) ? "active" : "" %>"
                                   href="login.jsp?tab=admin">
                                    <i class="bi bi-shield-lock me-1"></i>Admin Login
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="card-body p-4">
                        <% if ("1".equals(error)) { %>
                            <div class="alert alert-danger text-center small py-2">
                                <i class="bi bi-exclamation-circle me-1"></i>ID or Password is wrong
                            </div>
                        <% } %>

                        <!-- USER LOGIN -->
                        <% if ("user".equals(tab)) { %>
                        <form action="processlogin.jsp" method="post">
                            <input type="hidden" name="loginType" value="user">
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">User ID</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                    <input type="text" name="userId" class="form-control" required placeholder="Enter your ID">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold small">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                    <input type="password" name="password" class="form-control" required placeholder="Enter your password">
                                </div>
                            </div>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-dark fw-bold py-2">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Sign In
                                </button>
                            </div>
                            <p class="text-center text-muted small mb-0">
                                Don't have an account?
                                <a href="register.jsp" class="text-dark fw-semibold">Register here</a>
                            </p>
                        </form>

                        <!-- ADMIN LOGIN -->
                        <% } else { %>
                        <div class="text-center mb-3">
                            <span class="badge bg-dark px-3 py-2">
                                <i class="bi bi-shield-check me-1"></i>Admin Access Only
                            </span>
                        </div>
                        <form action="processlogin.jsp" method="post">
                            <input type="hidden" name="loginType" value="admin">
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Admin ID</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person-badge"></i></span>
                                    <input type="text" name="userId" class="form-control" required placeholder="Enter admin ID">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold small">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock-fill"></i></span>
                                    <input type="password" name="password" class="form-control" required placeholder="Enter admin password">
                                </div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-dark fw-bold py-2">
                                    <i class="bi bi-shield-lock me-1"></i>Admin Sign In
                                </button>
                            </div>
                        </form>
                        <% } %>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
