<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="dao.*" %>
<%@ page import="dto.*" %>
<%
    String catParam = request.getParameter("id");
    ProductDAO productDAO = new ProductDAO();
    ArrayList<Product> productList = null;

    if (catParam == null || catParam.isEmpty() || catParam.equals("all")) {
        productList = productDAO.getProducts("all");
    } else {
        productList = productDAO.getProducts(catParam);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Watch Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <h2 class="fw-bold text-center mb-4">Our Premium Products</h2>
        
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <%
                if (productList != null && !productList.isEmpty()) {
                    for (Product product : productList) {
            %>
                        <div class="col">
                            <div class="card h-100 shadow-sm border-0">
                                <img src="<%= product.getImageUrl() %>" class="card-img-top" alt="watch" style="height:200px; object-fit:cover;">
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <div>
                                        <h5 class="card-title fw-bold"><%= product.getProductName() %></h5>
                                        <p class="card-text text-muted small"><%= product.getDescription() %></p>
                                    </div>
                                    <div class="mt-3">
                                        <h5 class="text-danger fw-bold">$<%= String.format(Locale.US, "%.2f", product.getPrice()) %></h5>
                                        <a href="productDetail.jsp?id=<%= product.getProductId() %>" class="btn btn-sm btn-outline-dark mt-2 w-100">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                    <div class="col-12 text-center my-5">
                        <h4 class="text-muted">No watches found in this category.</h4>
                    </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>