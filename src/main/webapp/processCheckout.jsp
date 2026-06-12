<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.sql.*, common.DBConnection" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) { response.sendRedirect("login.jsp"); return; }

    @SuppressWarnings("unchecked")
    ArrayList<HashMap<String, Object>> cart =
        (ArrayList<HashMap<String, Object>>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) { response.sendRedirect("cart.jsp"); return; }

    request.setCharacterEncoding("UTF-8");
    String fullName       = request.getParameter("fullName");
    String phone          = request.getParameter("phone");
    String address        = request.getParameter("address");
    String city           = request.getParameter("city");
    String postal         = request.getParameter("postal");
    String paymentMethod  = request.getParameter("paymentMethod");
    if (paymentMethod == null) paymentMethod = "COD";

    double total = 0;
    for (HashMap<String, Object> item : cart)
        total += (Double) item.get("price") * (Integer) item.get("quantity");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int orderId = -1;

    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false);

        // 1. Insert order
        String sql = "INSERT INTO orders (user_id, full_name, address, city, postal, phone, total_amount, status, payment_method) VALUES (?,?,?,?,?,?,?,'Pending',?)";
        pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, sessionUserId);
        pstmt.setString(2, fullName);
        pstmt.setString(3, address);
        pstmt.setString(4, city);
        pstmt.setString(5, postal);
        pstmt.setString(6, phone);
        pstmt.setDouble(7, total);
        pstmt.setString(8, paymentMethod);
        pstmt.executeUpdate();

        rs = pstmt.getGeneratedKeys();
        if (rs.next()) orderId = rs.getInt(1);
        pstmt.close();

        // 2. Insert order items + reduce stock
        for (HashMap<String, Object> item : cart) {
            pstmt = conn.prepareStatement(
                "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (?,?,?,?,?)"
            );
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, Integer.parseInt(item.get("productId").toString()));
            pstmt.setString(3, item.get("productName").toString());
            pstmt.setDouble(4, (Double) item.get("price"));
            pstmt.setInt(5, (Integer) item.get("quantity"));
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement(
                "UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?"
            );
            pstmt.setInt(1, (Integer) item.get("quantity"));
            pstmt.setInt(2, Integer.parseInt(item.get("productId").toString()));
            pstmt.setInt(3, (Integer) item.get("quantity"));
            pstmt.executeUpdate();
            pstmt.close();
        }

        conn.commit();
        session.removeAttribute("cart");
        response.sendRedirect("orderSuccess.jsp?orderId=" + orderId + "&payment=" + paymentMethod);

    } catch (Exception e) {
        if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
        e.printStackTrace();
        response.sendRedirect("checkout.jsp?error=1");
    } finally {
        try { if (rs    != null) rs.close();    } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn  != null) conn.close();  } catch (Exception e) {}
    }
%>
