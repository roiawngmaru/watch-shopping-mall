<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, dto.Product" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) { response.sendRedirect("login.jsp?error=locked"); return; }

    String idParam = request.getParameter("id");
    if (idParam == null) { response.sendRedirect("admin.jsp"); return; }

    ProductDAO dao = new ProductDAO();
    Product p = dao.getProductById(Integer.parseInt(idParam));
    if (p == null) { response.sendRedirect("admin.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; }
        .sidebar { min-height: 100vh; background: #1a1a2e; width: 220px; position: fixed; top: 0; left: 0; padding-top: 20px; }
        .sidebar .brand { color: #f0c040; font-weight: bold; font-size: 1.1rem; padding: 16px 20px 30px; border-bottom: 1px solid #333; }
        .sidebar .nav-link { color: #ccc; padding: 12px 20px; display: block; text-decoration: none; }
        .sidebar .nav-link:hover { color: #fff; background: #0f3460; }
        .main-content { margin-left: 220px; padding: 30px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="brand"><i class="bi bi-shield-check me-2"></i>Admin Panel</div>
    <a href="admin.jsp" class="nav-link"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="adminProducts.jsp" class="nav-link"><i class="bi bi-box-seam me-2"></i>Products</a>
    <a href="adminAddProduct.jsp" class="nav-link"><i class="bi bi-plus-circle me-2"></i>Add Product</a>
    <a href="main.jsp" class="nav-link"><i class="bi bi-shop me-2"></i>View Shop</a>
    <a href="logout.jsp" class="nav-link text-danger mt-5"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<div class="main-content">
    <h3 class="fw-bold mb-4"><i class="bi bi-pencil me-2"></i>Edit Product</h3>

    <div class="card border-0 shadow-sm" style="max-width:650px;">
        <div class="card-body p-4">
            <!-- Preview current image -->
            <div class="text-center mb-4">
                <img src="<%= p.getImageUrl() %>" style="height:150px;object-fit:cover;border-radius:10px;"
                     onerror="this.src='https://via.placeholder.com/150?text=No+Image'">
            </div>

            <form action="adminProcessProduct.jsp" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Product Name</label>
                    <input type="text" name="productName" class="form-control" required value="<%= p.getProductName() %>">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Description</label>
                    <textarea name="description" class="form-control" rows="3" required><%= p.getDescription() %></textarea>
                </div>

                <div class="row mb-3">
                    <div class="col">
                        <label class="form-label fw-semibold">Price ($)</label>
                        <input type="number" name="price" class="form-control" step="0.01" min="0" required value="<%= p.getPrice() %>">
                    </div>
                    <div class="col">
                        <label class="form-label fw-semibold">Stock Quantity</label>
                        <input type="number" name="stock" class="form-control" min="0" required value="<%= p.getStock() %>">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="1" <%= p.getCategoryId()==1?"selected":"" %>>Men's Watches</option>
                        <option value="2" <%= p.getCategoryId()==2?"selected":"" %>>Women's Watches</option>
                        <option value="3" <%= p.getCategoryId()==3?"selected":"" %>>Smart Watches</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Image URL</label>
                    <input type="text" name="imageUrl" class="form-control" value="<%= p.getImageUrl() %>">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary fw-bold px-4">
                        <i class="bi bi-check-circle me-1"></i>Save Changes
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
