package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import dto.Product;
import common.DBConnection;

public class ProductDAO {

    public ArrayList<Product> getProducts(String catId) {
        ArrayList<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            if (conn == null) {
                System.out.println("Error: Database connection is null inside ProductDAO.");
                return list;
            }

            String sql = "SELECT * FROM products";

            if (catId != null && !catId.isEmpty() && !catId.equals("all")) {
                sql += " WHERE category_id = ?";
            }

            pstmt = conn.prepareStatement(sql);

            if (catId != null && !catId.isEmpty() && !catId.equals("all")) {
                pstmt.setInt(1, Integer.parseInt(catId));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product1 = new Product();
                product1.setProductId(rs.getInt("product_id"));
                product1.setProductName(rs.getString("product_name"));
                product1.setDescription(rs.getString("description"));
                product1.setPrice(rs.getDouble("price"));
                product1.setStock(rs.getInt("stock"));
                product1.setCategoryId(rs.getInt("category_id"));
                product1.setImageUrl(rs.getString("image_url"));
                list.add(product1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }

    public Product getProductById(int productId) {
        Product product = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM products WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImageUrl(rs.getString("image_url"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return product;
    }
}