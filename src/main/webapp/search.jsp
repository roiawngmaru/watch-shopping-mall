<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DBConnection, java.util.Locale" %>
<%
    String query = request.getParameter("q");
    if (query == null) query = "";
    query = query.trim();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search - Watch Shop</title>
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5">
        <h4 class="fw-bold mb-4">
            <i class="bi bi-search me-2"></i>
            Search results for: "<%= query %>"
        </h4>

        <div class="row row-cols-1 row-cols-md-3 g-4">
        <%
        if (!query.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 0;
            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT * FROM products WHERE product_name LIKE ? OR description LIKE ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + query + "%");
                pstmt.setString(2, "%" + query + "%");
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    count++;
                    String imgUrl = rs.getString("image_url");
                    double price  = rs.getDouble("price");
                    int productId = rs.getInt("product_id");
        %>
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <img src="<%= imgUrl %>" class="card-img-top"
                             style="height:200px;object-fit:cover;"
                             onerror="this.src='https://via.placeholder.com/300x200?text=Watch'">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <div>
                                <h5 class="card-title fw-bold"><%= rs.getString("product_name") %></h5>
                                <p class="card-text text-muted small"><%= rs.getString("description") %></p>
                            </div>
                            <div class="mt-3">
                                <h5 class="text-danger fw-bold">$<%= String.format(Locale.US,"%.2f", price) %></h5>
                                <a href="productDetail.jsp?id=<%= productId %>"
                                   class="btn btn-sm btn-outline-dark mt-2 w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
        <%
                }
                if (count == 0) {
        %>
            <div class="col-12 text-center py-5">
                <i class="bi bi-search" style="font-size:3rem;color:#ccc;"></i>
                <p class="text-muted mt-3">No watches found for "<%= query %>"</p>
                <a href="products.jsp?id=all" class="btn btn-dark mt-2">Browse All Products</a>
            </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch(Exception e){}
                try { if (pstmt != null) pstmt.close(); } catch(Exception e){}
                try { if (conn != null) conn.close(); } catch(Exception e){}
            }
        }
        %>
        </div>
    </div>
</body>
</html>
