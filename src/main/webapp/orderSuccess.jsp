<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) { response.sendRedirect("login.jsp"); return; }
    String orderIdParam = request.getParameter("orderId");
    String payment      = request.getParameter("payment");
    if (payment == null) payment = "COD";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmed - Watch Shop</title>
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5 text-center" style="max-width:580px;">
        <div class="card border-0 shadow-sm p-5">
            <i class="bi bi-check-circle-fill text-success mb-3" style="font-size:5rem;"></i>
            <h2 class="fw-bold">Order Confirmed!</h2>
            <p class="text-muted">Thank you, <strong><%= sessionUserId %></strong>! Your order has been placed successfully.</p>

            <div class="alert alert-light border mt-3">
                <div class="row">
                    <div class="col-6 text-start text-muted small">Order ID:</div>
                    <div class="col-6 text-end fw-bold">#<%= orderIdParam %></div>
                    <div class="col-6 text-start text-muted small mt-1">Payment:</div>
                    <div class="col-6 text-end fw-bold mt-1">
                        <%
                            String payIcon = "COD".equals(payment) ? "💵 Cash on Delivery" :
                                            "KBZPay".equals(payment) ? "📱 KBZ Pay" :
                                            "WavePay".equals(payment) ? "💳 Wave Pay" :
                                            "💳 Credit / Debit Card";
                        %>
                        <%= payIcon %>
                    </div>
                    <% if ("KBZPay".equals(payment) || "WavePay".equals(payment)) { %>
                    <div class="col-12 mt-2">
                        <div class="alert alert-warning small mb-0">
                            <i class="bi bi-exclamation-triangle me-1"></i>
                            Please transfer <strong>$<%= request.getParameter("total") %></strong> to <strong>09 7777 8888</strong> and send screenshot to confirm your order.
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <div class="d-flex gap-3 justify-content-center mt-4">
                <a href="orderHistory.jsp" class="btn btn-dark px-4">
                    <i class="bi bi-clock-history me-1"></i>My Orders
                </a>
                <a href="products.jsp?id=all" class="btn btn-outline-dark px-4">
                    <i class="bi bi-shop me-1"></i>Continue Shopping
                </a>
            </div>
        </div>
    </div>
</body>
</html>
