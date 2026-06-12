<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap" %>
<%
    String uri = request.getRequestURI();
    if (uri.endsWith("menu.jsp")) {
        response.sendRedirect("main.jsp");
        return;
    }
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand fw-bold text-warning" href="main.jsp">⌚ LUXURY WATCH</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-2">
        <li class="nav-item"><a class="nav-link" href="main.jsp"><i class="bi bi-house me-1"></i>Home</a></li>
        <li class="nav-item"><a class="nav-link" href="categories.jsp"><i class="bi bi-grid me-1"></i>Categories</a></li>
        <li class="nav-item"><a class="nav-link" href="products.jsp?id=all"><i class="bi bi-watch me-1"></i>Products</a></li>
      </ul>

      <!-- Search Bar -->
      <form action="search.jsp" method="get" class="d-flex me-auto">
        <div class="input-group">
          <input type="text" name="q" class="form-control form-control-sm"
                 placeholder="Search watches..."
                 value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>"
                 style="min-width:180px;">
          <button type="submit" class="btn btn-warning btn-sm">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </form>

      <div class="d-flex align-items-center gap-2 ms-2">
        <%
        String userId = (String) session.getAttribute("userId");
        @SuppressWarnings("unchecked")
        ArrayList<HashMap<String, Object>> cartItems =
            (ArrayList<HashMap<String, Object>>) session.getAttribute("cart");
        int cartCount = (cartItems != null) ? cartItems.size() : 0;

        if (userId != null) {
        %>
            <a href="orderHistory.jsp" class="btn btn-outline-light btn-sm">
                <i class="bi bi-clock-history me-1"></i>Orders
            </a>
            <a href="cart.jsp" class="btn btn-outline-warning btn-sm position-relative">
                <i class="bi bi-cart3"></i> Cart
                <% if (cartCount > 0) { %>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    <%= cartCount %>
                </span>
                <% } %>
            </a>
        <% } %>
        <% if (userId == null) { %>
            <a href="login.jsp" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-in-right me-1"></i>Login
            </a>
        <% } else { %>
            <span class="text-white small d-none d-lg-inline">Hi, <strong><%= userId %></strong></span>
            <a href="logout.jsp" class="btn btn-danger btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        <% } %>
      </div>
    </div>
  </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
