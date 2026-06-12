<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection, java.util.Locale" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - Watch Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <h3 class="fw-bold mb-4"><i class="bi bi-clock-history me-2"></i>My Orders</h3>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean hasOrders = false;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(
                "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC"
            );
            pstmt.setString(1, sessionUserId);
            rs = pstmt.executeQuery();
        %>

        <% while (rs.next()) {
            hasOrders = true;
            int orderId = rs.getInt("order_id");
            String status = rs.getString("status");
            String badgeColor = "Pending".equals(status) ? "warning" :
                                "Shipped".equals(status) ? "primary" :
                                "Delivered".equals(status) ? "success" : "secondary";
        %>
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <div>
                    <span class="fw-bold">Order #<%= orderId %></span>
                    <span class="text-muted small ms-3"><%= rs.getTimestamp("order_date") %></span>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <span class="fw-bold text-danger">$<%= String.format(Locale.US,"%.2f", rs.getDouble("total_amount")) %></span>
                    <span class="badge bg-<%= badgeColor %> text-dark"><%= status %></span>
                </div>
            </div>
            <div class="card-body">
                <p class="text-muted small mb-2">
                    <i class="bi bi-truck me-1"></i>
                    <%= rs.getString("full_name") %> — <%= rs.getString("address") %>, <%= rs.getString("city") %>
                    (📞 <%= rs.getString("phone") %>)
                </p>

                <!-- Order Items -->
                <%
                PreparedStatement itemStmt = conn.prepareStatement(
                    "SELECT * FROM order_items WHERE order_id = ?"
                );
                itemStmt.setInt(1, orderId);
                ResultSet itemRs = itemStmt.executeQuery();
                %>
                <table class="table table-sm table-bordered mt-2 mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Qty</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% while (itemRs.next()) {
                        double sub = itemRs.getDouble("price") * itemRs.getInt("quantity");
                    %>
                        <tr>
                            <td><%= itemRs.getString("product_name") %></td>
                            <td>$<%= String.format(Locale.US,"%.2f", itemRs.getDouble("price")) %></td>
                            <td><%= itemRs.getInt("quantity") %></td>
                            <td class="fw-bold">$<%= String.format(Locale.US,"%.2f", sub) %></td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
                <% itemRs.close(); itemStmt.close(); %>
            </div>
        </div>
        <% } %>

        <% if (!hasOrders) { %>
            <div class="text-center py-5">
                <i class="bi bi-bag-x" style="font-size:4rem; color:#ccc;"></i>
                <p class="text-muted mt-3 fs-5">No orders yet.</p>
                <a href="products.jsp?id=all" class="btn btn-dark mt-2">Start Shopping</a>
            </div>
        <% } %>

        <%
        } catch (Exception e) { e.printStackTrace(); }
        finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
