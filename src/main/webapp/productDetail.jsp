<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.Locale" %>
<%
    String idParam = request.getParameter("id");

    // Redirect if no id given
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("products.jsp?id=all");
        return;
    }

    Product product = null;
    try {
        int productId = Integer.parseInt(idParam);
        ProductDAO dao = new ProductDAO();
        product = dao.getProductById(productId);
        if (product == null) {
            response.sendRedirect("products.jsp?id=all");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("products.jsp?id=all");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail - Watch Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="menu.jsp" />

    <div class="container my-5">
    <%
        if (product == null) {
    %>
        <div class="text-center my-5">
            <h4 class="text-muted">Product not found.</h4>
            <a href="products.jsp?id=all" class="btn btn-dark mt-3">Back to Products</a>
        </div>
    <%
        } else {
    %>
        <div class="row g-5 align-items-start">
            <div class="col-md-5">
                <img src="<%= product.getImageUrl() %>" class="img-fluid rounded shadow"
                     alt="<%= product.getProductName() %>"
                     style="width:100%; max-height:420px; object-fit:cover;"
                     onerror="this.src='https://via.placeholder.com/400x400?text=No+Image'">
            </div>
            <div class="col-md-7">
                <h2 class="fw-bold mb-1"><%= product.getProductName() %></h2>
                <p class="text-muted mb-3"><%= product.getDescription() %></p>

                <h3 class="text-danger fw-bold mb-3">$<%= String.format(Locale.US, "%.2f", product.getPrice()) %></h3>

                <div class="mb-3">
                    <%
                        if (product.getStock() > 0) {
                    %>
                        <span class="badge bg-success fs-6">In Stock (<%= product.getStock() %> left)</span>
                    <%
                        } else {
                    %>
                        <span class="badge bg-danger fs-6">Out of Stock</span>
                    <%
                        }
                    %>
                </div>

                <%
                    String sessionUserId = (String) session.getAttribute("userId");
                    if (sessionUserId != null && product.getStock() > 0) {
                %>
                <form action="processCart.jsp" method="post" class="d-flex align-items-center gap-3 mt-4">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    <input type="hidden" name="productName" value="<%= product.getProductName() %>">
                    <input type="hidden" name="price" value="<%= String.format(Locale.US, "%.2f", product.getPrice()) %>">
                    <input type="hidden" name="imageUrl" value="<%= product.getImageUrl() %>">
                    <label class="fw-semibold">Qty:</label>
                    <input type="number" name="quantity" value="1" min="1" max="<%= product.getStock() %>"
                           class="form-control" style="width:80px;">
                    <button type="submit" class="btn btn-dark fw-bold px-4">
                        <i class="bi bi-cart-plus me-1"></i> Add to Cart
                    </button>
                </form>
                <%
                    } else if (sessionUserId == null) {
                %>
                <div class="alert alert-warning mt-4">
                    Please <a href="login.jsp" class="alert-link">login</a> to add items to cart.
                </div>
                <%
                    }
                %>

                <a href="products.jsp?id=all" class="btn btn-outline-secondary mt-4">
                    <i class="bi bi-arrow-left me-1"></i> Back to Products
                </a>
            </div>
        </div>
    <%
        }
    %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
