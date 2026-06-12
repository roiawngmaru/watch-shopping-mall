<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId   = request.getParameter("userId");
    String password = request.getParameter("password");
    String name     = request.getParameter("name");
    String email    = request.getParameter("email");

    if (userId == null || userId.trim().isEmpty() ||
        password == null || password.trim().isEmpty() ||
        name == null || name.trim().isEmpty()) {
        response.sendRedirect("register.jsp?error=empty");
        return;
    }

    Connection conn  = null;
    PreparedStatement check  = null;
    PreparedStatement insert = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        // Check if user ID already exists
        check = conn.prepareStatement("SELECT user_id FROM users WHERE user_id = ?");
        check.setString(1, userId.trim());
        rs = check.executeQuery();

        if (rs.next()) {
            response.sendRedirect("register.jsp?error=exists");
        } else {
            insert = conn.prepareStatement(
                "INSERT INTO users (user_id, password, name, email, role) VALUES (?, ?, ?, ?, 'user')"
            );
            insert.setString(1, userId.trim());
            insert.setString(2, password.trim());
            insert.setString(3, name.trim());
            insert.setString(4, (email != null && !email.trim().isEmpty()) ? email.trim() : null);
            insert.executeUpdate();
            response.sendRedirect("register.jsp?success=1");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("register.jsp?error=exists");
    } finally {
        try { if (rs     != null) rs.close();     } catch (Exception e) {}
        try { if (check  != null) check.close();  } catch (Exception e) {}
        try { if (insert != null) insert.close();  } catch (Exception e) {}
        try { if (conn   != null) conn.close();   } catch (Exception e) {}
    }
%>
