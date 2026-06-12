<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Watch Shop - Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<style>
    body { background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); min-height: 100vh; }
</style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-5">

                <%
                    String error   = request.getParameter("error");
                    String success = request.getParameter("success");
                %>

                <% if ("exists".equals(error)) { %>
                    <div class="alert alert-danger text-center">User ID already exists. Try another.</div>
                <% } %>
                <% if ("1".equals(success)) { %>
                    <div class="alert alert-success text-center">
                        Account created! <a href="login.jsp" class="alert-link">Sign in now</a>
                    </div>
                <% } %>

                <div class="card shadow border-0" style="border-radius:16px;">
                    <div class="card-body p-4">
                        <h5 class="text-center fw-bold mb-1">Create Account</h5>
                        <p class="text-center text-muted small mb-4">Join Luxury Watch today</p>

                        <form action="processRegister.jsp" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Full Name</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                    <input type="text" name="name" class="form-control" required placeholder="Your full name">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">User ID</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-at"></i></span>
                                    <input type="text" name="userId" class="form-control" required placeholder="Choose a unique ID">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                                    <input type="email" name="email" class="form-control" placeholder="Your email (optional)">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold small">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                                    <input type="password" name="password" class="form-control" required placeholder="Create a password">
                                </div>
                            </div>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-dark fw-bold py-2">
                                    <i class="bi bi-person-plus me-1"></i> Register
                                </button>
                            </div>
                            <p class="text-center text-muted small mb-0">
                                Already have an account?
                                <a href="login.jsp" class="text-dark fw-semibold">Sign in</a>
                            </p>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
