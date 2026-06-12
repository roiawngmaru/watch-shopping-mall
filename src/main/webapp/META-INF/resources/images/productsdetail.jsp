<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 정보 - Watch Shop</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; margin: 40px; background-color: #f8f9fa; color: #333; }
    .container { max-width: 900px; margin: auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0px 4px 15px rgba(0,0,0,0.05); }
    h2 { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
    .product-box { display: flex; gap: 50px; margin-top: 20px; align-items: flex-start; }
    .product-image { max-width: 350px; width: 100%; height: auto; border-radius: 8px; border: 1px solid #ddd; }
    .product-info { flex: 1; }
    .price { font-size: 26px; color: #d9534f; font-weight: bold; margin: 10px 0; }
    
  
    .info-table { width: 100%; margin: 20px 0; border-collapse: collapse; }
    .info-table th, .info-table td { padding: 10px; text-align: left; border-bottom: 1px solid #eee; }
    .info-table th { width: 30%; color: #666; font-weight: 600; }
    .badge-stock { padding: 4px 8px; border-radius: 4px; font-size: 13px; font-weight: bold; }
    .in-stock { background-color: #e6f4ea; color: #137333; }
    .out-of-stock { background-color: #fce8e6; color: #c5221f; }
    
   
    .cart-form { margin-top: 25px; padding-top: 20px; border-top: 1px solid #ddd; }
    .quantity-input { width: 60px; padding: 8px; font-size: 16px; text-align: center; border: 1px solid #ccc; border-radius: 4px; margin-right: 10px; }
    .btn-cart { padding: 12px 24px; background: #007bff; color: white; border: none; font-size: 16px; font-weight: bold; border-radius: 5px; cursor: pointer; transition: 0.2s; }
    .btn-cart:hover { background: #0056b3; }
    .btn-cart:disabled { background: #ccc; cursor: not-allowed; }
    
    .btn-back { display: inline-block; margin-top: 30px; padding: 10px 20px; background: #333; color: white; text-decoration: none; border-radius: 5px; }
    .btn-back:hover { background: #555; }
</style>
</head>
<body>

<div class="container">
    <h2>시계 상세 정보 및 구매</h2>

    <%
       
        String idParam = request.getParameter("id");
        
       
        String productName = "등록되지 않은 상품";
        String productPrice = "0 원";
        String productDesc = "상세 설명이 없습니다.";
        String imgName = "default.jpg";
        
        String productColor = "-";
        int productStock = 0;
        String productOrigin = "-";

        if (idParam != null && !idParam.isEmpty()) {
            int productId = Integer.parseInt(idParam);
            
            if (productId == 1) {
                productName = "카시오 에디피스 (Casio Edifice)";
                productPrice = "150,000 원";
                productDesc = "크로노그래프 기능과 메탈 스트랩으로 스타일을 더한 세련된 비즈니스 워치입니다.";
                imgName = "casio.jpg";
                productColor = "실버 / 블랙 (Silver / Black)";
                productStock = 12; 
                productOrigin = "일본 (Japan)";
            } else if (productId == 2) {
                productName = "롤렉스 서브마리너 (Rolex Submariner)";
                productPrice = "25,000,000 원";
                productDesc = "오이스터 스틸과 세라크롬 베젤이 결합한 최고급 다이버 워치의 대명사입니다.";
                imgName = "Rolex submainer.jpg";
                productColor = "그린 / 블랙 (Green / Black)";
                productStock = 0;  
                productOrigin = "스위스 (Switzerland)";
            }
        }
    %>

    <div class="product-box">
       
        <div>
            <img src="META-INF/<%= imgName %>" alt="<%= productName %>" class="product-image" onerror="this.src='https://via.placeholder.com/350x350?text=No+Image';">
        </div>
        
        
        <div class="product-info">
            <h3><%= productName %></h3>
            <p class="price"><%= productPrice %></p>
            <p style="color: #666; font-size: 14px;"><%= productDesc %></p>
            
          
            <table class="info-table">
                <tr>
                    <th>선택 가능 색상</th>
                    <td><%= productColor %></td>
                </tr>
                <tr>
                    <th>제조국 (Origin)</th>
                    <td><%= productOrigin %></td>
                </tr>
                <tr>
                    <th>현재 재고 현황</th>
                    <td>
                        <% if (productStock > 0) { %>
                            <span class="badge-stock in-stock">재고 있음 (<%= productStock %>개 남음)</span>
                        <% } else { %>
                            <span class="badge-stock out-of-stock">품절 (Out of Stock)</span>
                        <% } %>
                    </td>
                </tr>
            </table>
            
           
            <form action="processCart.jsp" method="post" class="cart-form">
                <input type="hidden" name="productId" value="<%= idParam %>">
                
                <label for="quantity">수량: </label>
                <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= productStock == 0 ? 1 : productStock %>" class="quantity-input" <%= productStock == 0 ? "disabled" : "" %>>
                
                <% if (productStock > 0) { %>
                    <button type="submit" class="btn-cart">장바구니 담기 (Add to Cart)</button>
                <% } else { %>
                    <button type="button" class="btn-cart" disabled>품절된 상품입니다</button>
                <% } %>
            </form>
            
        </div>
    </div>

    <br>
    <a href="main.jsp" class="btn-back">← 쇼핑 계속하기</a>
</div>

</body>
</html>