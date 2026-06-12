<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) { response.sendRedirect("login.jsp?error=locked"); return; }

    request.setCharacterEncoding("UTF-8");
    String action      = request.getParameter("action");
    String productName = request.getParameter("productName");
    String description = request.getParameter("description");
    String priceStr    = request.getParameter("price");
    String stockStr    = request.getParameter("stock");
    String catStr      = request.getParameter("categoryId");
    String imageUrl    = request.getParameter("imageUrl");

    double price = Double.parseDouble(priceStr);
    int stock    = Integer.parseInt(stockStr);
    int catId    = Integer.parseInt(catStr);

    if (imageUrl == null || imageUrl.trim().isEmpty()) imageUrl = "images/rolex.jpg";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DBConnection.getConnection();

        if ("add".equals(action)) {
            String sql = "INSERT INTO products (product_name, description, price, stock, category_id, image_url) VALUES (?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setInt(4, stock);
            pstmt.setInt(5, catId);
            pstmt.setString(6, imageUrl);
            pstmt.executeUpdate();
            response.sendRedirect("admin.jsp?msg=added");

        } else if ("edit".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String sql = "UPDATE products SET product_name=?, description=?, price=?, stock=?, category_id=?, image_url=? WHERE product_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productName);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setInt(4, stock);
            pstmt.setInt(5, catId);
            pstmt.setString(6, imageUrl);
            pstmt.setInt(7, productId);
            pstmt.executeUpdate();
            response.sendRedirect("admin.jsp?msg=updated");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin.jsp?msg=error");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn  != null) conn.close();  } catch (Exception e) {}
    }
%>
