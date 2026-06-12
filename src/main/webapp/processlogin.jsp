<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId    = request.getParameter("userId");
    String password  = request.getParameter("password");
    String loginType = request.getParameter("loginType");

    if (userId == null || userId.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {
        String t = "admin".equals(loginType) ? "admin" : "user";
        response.sendRedirect("login.jsp?tab=" + t + "&error=1");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId.trim());
        pstmt.setString(2, password.trim());
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String userRole = rs.getString("role");

            if ("admin".equals(loginType)) {
                if ("admin".equals(userRole)) {
                    session.setAttribute("userId", rs.getString("user_id"));
                    session.setAttribute("role", "admin");
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("login.jsp?tab=admin&error=locked");
                }
            } else {
                session.setAttribute("userId", rs.getString("user_id"));
                session.setAttribute("role", userRole);
                response.sendRedirect("main.jsp");
            }

        } else {
            String tab = "admin".equals(loginType) ? "admin" : "user";
            response.sendRedirect("login.jsp?tab=" + tab + "&error=1");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?error=1");
    } finally {
        try { if (rs    != null) rs.close();    } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn  != null) conn.close();  } catch (Exception e) {}
    }
%>
