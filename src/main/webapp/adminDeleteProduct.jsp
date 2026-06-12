<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection" %>
<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) { response.sendRedirect("login.jsp?error=locked"); return; }

    String idParam = request.getParameter("id");
    if (idParam == null) { response.sendRedirect("admin.jsp"); return; }

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        conn = DBConnection.getConnection();
        pstmt = conn.prepareStatement("DELETE FROM products WHERE product_id = ?");
        pstmt.setInt(1, Integer.parseInt(idParam));
        pstmt.executeUpdate();
        response.sendRedirect("admin.jsp?msg=deleted");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin.jsp");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn  != null) conn.close();  } catch (Exception e) {}
    }
%>
