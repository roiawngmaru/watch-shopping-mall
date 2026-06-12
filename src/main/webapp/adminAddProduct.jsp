<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) { response.sendRedirect("login.jsp?error=locked"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; }
        .sidebar { min-height: 100vh; background: #1a1a2e; width: 220px; position: fixed; top: 0; left: 0; padding-top: 20px; }
        .sidebar .brand { color: #f0c040; font-weight: bold; font-size: 1.1rem; padding: 16px 20px 30px; border-bottom: 1px solid #333; }
        .sidebar .nav-link { color: #ccc; padding: 12px 20px; display: block; text-decoration: none; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background: #0f3460; }
        .main-content { margin-left: 220px; padding: 30px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="brand"><i class="bi bi-shield-check me-2"></i>Admin Panel</div>
    <a href="admin.jsp" class="nav-link"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="adminProducts.jsp" class="nav-link"><i class="bi bi-box-seam me-2"></i>Products</a>
    <a href="adminAddProduct.jsp" class="nav-link active"><i class="bi bi-plus-circle me-2"></i>Add Product</a>
    <a href="main.jsp" class="nav-link"><i class="bi bi-shop me-2"></i>View Shop</a>
    <a href="logout.jsp" class="nav-link text-danger mt-5"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<div class="main-content">
    <h3 class="fw-bold mb-4"><i class="bi bi-plus-circle me-2"></i>Add New Product</h3>

    <div class="card border-0 shadow-sm" style="max-width:650px;">
        <div class="card-body p-4">
            <form action="adminProcessProduct.jsp" method="post">
                <input type="hidden" name="action" value="add">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Product Name</label>
                    <input type="text" name="productName" class="form-control" required placeholder="e.g. Rolex Submariner">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Description</label>
                    <textarea name="description" class="form-control" rows="3" required placeholder="Short description of the watch"></textarea>
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label fw-semibold">Price ($)</label>
                        <input type="number" name="price" class="form-control" step="0.01" min="0" required placeholder="0.00">
                    </div>
                    <div class="col">
                        <label class="form-label fw-semibold">Stock Quantity</label>
                        <input type="number" name="stock" class="form-control" min="0" required placeholder="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="">-- Select Category --</option>
                        <option value="1">Men's Watches</option>
                        <option value="2">Women's Watches</option>
                        <option value="3">Smart Watches</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Image URL</label>
                    <input type="text" name="imageUrl" class="form-control" placeholder="images/mywatch.jpg or https://...">
                    <div class="form-text">Local: <code>images/filename.jpg</code> — or paste an online image URL</div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-dark fw-bold px-4">
                        <i class="bi bi-plus-circle me-1"></i>Add Product
                    </button>
                    <a href="admin.jsp" class="btn btn-outline-secondary px-4">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
