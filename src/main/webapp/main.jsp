<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Watch Shopping Mall</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="menu.jsp" />

    <div class="container my-5 text-center py-5 bg-dark text-white rounded shadow">
        <h1 class="display-4 fw-bold">Welcome to Watch Shopping Mall</h1>
        <p class="lead text-light-50">Welcome to Web Market! Discover world-class premium timepieces.</p>
    </div>

    <div class="container my-5">
        <div class="row g-4 text-center">
            
            <div class="col-md-4">
                <div class="card h-100 p-4 shadow-sm border-0 bg-white">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="fs-1 mb-2">📁</div>
                            <h3 class="card-title fw-bold text-dark mb-3">Categories</h3>
                            <p class="card-text text-muted">Browse watches seamlessly by styles:  Men, Women ,or Smart Watches.</p>
                        </div>
                        <a href="categories.jsp" class="btn btn-dark mt-4 fw-bold py-2">Go to Categories</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 p-4 shadow-sm border-0 bg-white">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="fs-1 mb-2">⌚</div>
                            <h3 class="card-title fw-bold text-dark mb-3">Products</h3>
                            <p class="card-text text-muted">Explore our entire unique collections, specifications, and details.</p>
                        </div>
                        <a href="products.jsp?id=all" class="btn btn-secondary mt-4 fw-bold py-2">View All Products</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 p-4 shadow-sm border-0 bg-white">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <div class="fs-1 mb-2">🔒</div>
                            <h3 class="card-title fw-bold text-dark mb-3">Users Login</h3>
                            <p class="card-text text-muted">Sign in to your private account to manage orders and checkout safely.</p>
                        </div>
                        <a href="login.jsp" class="btn btn-outline-dark mt-4 fw-bold py-2">Go to Login</a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>