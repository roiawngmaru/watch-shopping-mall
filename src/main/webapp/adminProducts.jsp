<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, dto.Product, java.util.ArrayList, java.util.Locale" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) { response.sendRedirect("login.jsp?error=locked"); return; }
    ProductDAO dao = new ProductDAO();
    ArrayList<Product> products = dao.getProducts("all");
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Products - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f4f6f9; }
        .sidebar { min-height: 100vh; background: #1a1a2e; width: 220px; position: fixed; top: 0; left: 0; padding-top: 20px; }
        .sidebar .brand { color: #f0c040; font-weight: bold; font-size: 1.1rem; padding: 16px 20px 30px; border-bottom: 1px solid #333; }
        .sidebar .nav-link { color: #ccc; padding: 12px 20px; display: block; text-decoration: none; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background: #0f3460; }
        .main-content { margin-left: 220px; padding: 30px; }
        .product-img { width: 55px; height: 55px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="brand"><i class="bi bi-shield-check me-2"></i>Admin Panel</div>
    <a href="admin.jsp" class="nav-link"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="adminProducts.jsp" class="nav-link active"><i class="bi bi-box-seam me-2"></i>Products</a>
    <a href="adminAddProduct.jsp" class="nav-link"><i class="bi bi-plus-circle me-2"></i>Add Product</a>
    <a href="main.jsp" class="nav-link"><i class="bi bi-shop me-2"></i>View Shop</a>
    <a href="logout.jsp" class="nav-link text-danger mt-5"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold mb-0"><i class="bi bi-box-seam me-2"></i>All Products</h3>
        <a href="adminAddProduct.jsp" class="btn btn-dark">
            <i class="bi bi-plus me-1"></i>Add New Product
        </a>
    </div>

    <% if ("deleted".equals(msg)) { %>
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i>Product deleted successfully.</div>
    <% } else if ("added".equals(msg)) { %>
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i>Product added successfully.</div>
    <% } else if ("updated".equals(msg)) { %>
        <div class="alert alert-success"><i class="bi bi-check-circle me-1"></i>Product updated successfully.</div>
    <% } %>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th class="ps-3">Image</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Product p : products) {
                    String cat = p.getCategoryId()==1 ? "Men" : p.getCategoryId()==2 ? "Women" : "Smart";
                %>
                    <tr>
                        <td class="ps-3">
                            <img src="<%= p.getImageUrl() %>" class="product-img"
                                 onerror="this.src='https://via.placeholder.com/55?text=?'">
                        </td>
                        <td class="fw-semibold"><%= p.getProductName() %></td>
                        <td><span class="badge bg-secondary"><%= cat %></span></td>
                        <td class="text-danger fw-bold">$<%= String.format(Locale.US,"%.2f",p.getPrice()) %></td>
                        <td>
                            <% if (p.getStock() > 0) { %>
                                <span class="badge bg-success"><%= p.getStock() %> left</span>
                            <% } else { %>
                                <span class="badge bg-danger">Out of Stock</span>
                            <% } %>
                        </td>
                        <td class="text-center">
                            <a href="adminEditProduct.jsp?id=<%= p.getProductId() %>"
                               class="btn btn-sm btn-outline-primary me-1">
                                <i class="bi bi-pencil"></i> Edit
                            </a>
                            <a href="adminDeleteProduct.jsp?id=<%= p.getProductId() %>"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('Delete <%= p.getProductName() %>?')">
                                <i class="bi bi-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
