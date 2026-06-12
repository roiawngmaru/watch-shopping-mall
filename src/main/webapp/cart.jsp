<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Locale" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<HashMap<String, Object>> cart =
        (ArrayList<HashMap<String, Object>>) session.getAttribute("cart");

    // handle remove action
    String removeId = request.getParameter("remove");
    if (removeId != null && cart != null) {
        cart.removeIf(item -> item.get("productId").equals(removeId));
        response.sendRedirect("cart.jsp");
        return;
    }

    // handle clear action
    String clear = request.getParameter("clear");
    if ("1".equals(clear) && cart != null) {
        cart.clear();
        response.sendRedirect("cart.jsp");
        return;
    }

    double total = 0;
    if (cart != null) {
        for (HashMap<String, Object> item : cart) {
            total += (Double) item.get("price") * (Integer) item.get("quantity");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - Watch Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <h2 class="fw-bold mb-4"><i class="bi bi-cart3 me-2"></i>Your Cart</h2>

        <%
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="text-center py-5">
                <i class="bi bi-cart-x" style="font-size:4rem; color:#ccc;"></i>
                <p class="text-muted mt-3 fs-5">Your cart is empty.</p>
                <a href="products.jsp?id=all" class="btn btn-dark mt-2">Continue Shopping</a>
            </div>
        <%
            } else {
        %>
            <div class="table-responsive">
                <table class="table align-middle bg-white shadow-sm rounded">
                    <thead class="table-dark">
                        <tr>
                            <th>Product</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Qty</th>
                            <th>Subtotal</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (HashMap<String, Object> item : cart) {
                            double subtotal = (Double) item.get("price") * (Integer) item.get("quantity");
                    %>
                        <tr>
                            <td><img src="<%= item.get("imageUrl") %>" style="width:60px;height:60px;object-fit:cover;border-radius:6px;"
                                     onerror="this.src='https://via.placeholder.com/60?text=Watch'"></td>
                            <td class="fw-semibold"><%= item.get("productName") %></td>
                            <td>$<%= String.format(Locale.US, "%.2f", item.get("price")) %></td>
                            <td><%= item.get("quantity") %></td>
                            <td class="text-danger fw-bold">$<%= String.format(Locale.US, "%.2f", subtotal) %></td>
                            <td>
                                <a href="cart.jsp?remove=<%= item.get("productId") %>"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Remove this item?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <a href="cart.jsp?clear=1" class="btn btn-outline-secondary"
                   onclick="return confirm('Clear the entire cart?')">
                    <i class="bi bi-trash3 me-1"></i> Clear Cart
                </a>
                <div class="text-end">
                    <h4 class="fw-bold">Total: <span class="text-danger">$<%= String.format(Locale.US, "%.2f", total) %></span></h4>
                    <a href="checkout.jsp" class="btn btn-dark btn-lg mt-2 px-5">
                        <i class="bi bi-credit-card me-1"></i> Checkout
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
