<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Watch Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5 text-center">
        <h2 class="fw-bold mb-4">Browse by Specific Categories</h2>
        <p class="text-muted mb-5">Please choose a category to see the products.</p>
        
        <div class="row g-4 justify-content-center text-center">
        
        
            <div class="col-md-3">
                <div class="card shadow-sm p-4 border-0">
                    <div class="fs-2 mb-2">🕺</div>
                    <h4 class="fw-bold">Men Watches</h4>
                    <a href="products.jsp?id=1" class="btn btn-sm btn-dark mt-3 w-100">Explore Collection</a>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="card shadow-sm p-4 border-0">
                    <div class="fs-2 mb-2">💃</div>
                    <h4 class="fw-bold">Women Watches</h4>
                    <a href="products.jsp?id=2" class="btn btn-sm btn-dark mt-3 w-100">Explore Collection</a>
                </div>
            </div>

           

            <div class="col-md-3">
                <div class="card shadow-sm p-4 border-0">
                    <div class="fs-2 mb-2">🤖</div>
                    <h4 class="fw-bold">Smart Watches</h4>
                    <a href="products.jsp?id=3" class="btn btn-sm btn-dark mt-3 w-100">Explore Collection</a>
                </div>
            </div>

        </div>
    </div>
</body>
</html>