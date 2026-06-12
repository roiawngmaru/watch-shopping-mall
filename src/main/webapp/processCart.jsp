<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Locale" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String productId   = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String priceStr    = request.getParameter("price");
    String qtyStr      = request.getParameter("quantity");
    String imageUrl    = request.getParameter("imageUrl");

    if (productId == null || priceStr == null || qtyStr == null) {
        response.sendRedirect("products.jsp?id=all");
        return;
    }

    double price = 0;
    int qty = 1;
    try {
        // Use Locale.US to handle decimal point correctly
        price = Double.parseDouble(priceStr.trim());
        qty   = Integer.parseInt(qtyStr.trim());
        if (qty < 1) qty = 1;
    } catch (NumberFormatException e) {
        response.sendRedirect("products.jsp?id=all");
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<HashMap<String, Object>> cart =
        (ArrayList<HashMap<String, Object>>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    // Check if product already in cart — update quantity
    boolean found = false;
    for (HashMap<String, Object> item : cart) {
        if (item.get("productId").equals(productId)) {
            item.put("quantity", (Integer) item.get("quantity") + qty);
            found = true;
            break;
        }
    }

    // Add new item to cart
    if (!found) {
        HashMap<String, Object> item = new HashMap<>();
        item.put("productId",   productId);
        item.put("productName", productName != null ? productName : "Unknown");
        item.put("price",       price);
        item.put("quantity",    qty);
        item.put("imageUrl",    imageUrl != null ? imageUrl : "");
        cart.add(item);
    }

    response.sendRedirect("cart.jsp");
%>
