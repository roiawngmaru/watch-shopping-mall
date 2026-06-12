<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Locale" %>
<%
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) { response.sendRedirect("login.jsp"); return; }

    @SuppressWarnings("unchecked")
    ArrayList<HashMap<String, Object>> cart =
        (ArrayList<HashMap<String, Object>>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) { response.sendRedirect("cart.jsp"); return; }

    double total = 0;
    for (HashMap<String, Object> item : cart)
        total += (Double) item.get("price") * (Integer) item.get("quantity");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Watch Shop</title>
    <style>
        .card-input { letter-spacing: 2px; font-size: 1.1rem; }
        .card-brand { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 1.4rem; }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="menu.jsp" />

    <div class="container my-5" style="max-width:850px;">
        <h3 class="fw-bold mb-4"><i class="bi bi-bag-check me-2"></i>Checkout</h3>

        <div class="row g-4">

            <!-- Left: Form -->
            <div class="col-md-7">
                <form action="processCheckout.jsp" method="post" id="checkoutForm" onsubmit="return validateCard()">
                    <input type="hidden" name="paymentMethod" value="CreditCard">

                    <!-- Shipping -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-dark text-white fw-bold py-3">
                            <i class="bi bi-truck me-2"></i>Shipping Information
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Full Name</label>
                                <input type="text" name="fullName" class="form-control" required placeholder="Your full name">
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Phone</label>
                                <input type="tel" name="phone" class="form-control" required placeholder="09xxxxxxxxx">
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Address</label>
                                <input type="text" name="address" class="form-control" required placeholder="Street address">
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label class="form-label fw-semibold small">City</label>
                                    <input type="text" name="city" class="form-control" required placeholder="City">
                                </div>
                                <div class="col">
                                    <label class="form-label fw-semibold small">Postal Code</label>
                                    <input type="text" name="postal" class="form-control" required placeholder="Postal">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Credit/Debit Card -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-header bg-dark text-white fw-bold py-3">
                            <i class="bi bi-credit-card-2-front me-2"></i>Credit / Debit Card
                        </div>
                        <div class="card-body">

                            <!-- Card Number -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Card Number</label>
                                <div class="position-relative">
                                    <input type="text" id="cardNumber" name="cardNumber"
                                           class="form-control card-input pe-5"
                                           placeholder="1234 5678 9012 3456"
                                           maxlength="19" required
                                           oninput="formatCard(this); detectBrand(this.value);">
                                    <span class="card-brand" id="cardBrand">💳</span>
                                </div>
                            </div>

                            <!-- Card Holder -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold small">Card Holder Name</label>
                                <input type="text" name="cardHolder" id="cardHolder"
                                       class="form-control" placeholder="Name on card" required>
                            </div>

                            <!-- Expiry + CVV -->
                            <div class="row">
                                <div class="col mb-3">
                                    <label class="form-label fw-semibold small">Expiry Date</label>
                                    <input type="text" name="expiry" id="expiry"
                                           class="form-control" placeholder="MM/YY"
                                           maxlength="5" required
                                           oninput="formatExpiry(this)">
                                </div>
                                <div class="col mb-3">
                                    <label class="form-label fw-semibold small">CVV</label>
                                    <input type="password" name="cvv" id="cvv"
                                           class="form-control" placeholder="•••"
                                           maxlength="3" required>
                                </div>
                            </div>

                            <!-- Error message -->
                            <div id="cardError" class="alert alert-danger small py-2 d-none"></div>

                            <!-- Card icons -->
                            <div class="d-flex gap-2 mt-2">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Visa.svg" height="28" title="Visa">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg" height="28" title="MasterCard">
                            </div>
                        </div>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-dark btn-lg fw-bold">
                            <i class="bi bi-lock-fill me-1"></i>Pay $<%= String.format(Locale.US,"%.2f",total) %>
                        </button>
                    </div>
                </form>
            </div>

            <!-- Right: Order Summary -->
            <div class="col-md-5">
                <div class="card border-0 shadow-sm sticky-top" style="top:20px;">
                    <div class="card-header bg-dark text-white fw-bold py-3">
                        <i class="bi bi-receipt me-2"></i>Order Summary
                    </div>
                    <div class="card-body">
                        <% for (HashMap<String, Object> item : cart) {
                            double sub = (Double) item.get("price") * (Integer) item.get("quantity");
                        %>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <img src="<%= item.get("imageUrl") %>"
                                     style="width:45px;height:45px;object-fit:cover;border-radius:6px;"
                                     onerror="this.src='https://via.placeholder.com/45?text=W'">
                                <div>
                                    <p class="mb-0 fw-semibold small"><%= item.get("productName") %></p>
                                    <span class="text-muted small">x<%= item.get("quantity") %></span>
                                </div>
                            </div>
                            <span class="fw-bold small">$<%= String.format(Locale.US,"%.2f",sub) %></span>
                        </div>
                        <% } %>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Shipping</span>
                            <span class="text-success fw-semibold">FREE</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold fs-5">
                            <span>Total</span>
                            <span class="text-danger">$<%= String.format(Locale.US,"%.2f",total) %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function formatCard(input) {
            let val = input.value.replace(/\D/g, '').substring(0, 16);
            input.value = val.replace(/(.{4})/g, '$1 ').trim();
        }

        function formatExpiry(input) {
            let val = input.value.replace(/\D/g, '').substring(0, 4);
            if (val.length >= 2) val = val.substring(0, 2) + '/' + val.substring(2);
            input.value = val;
        }

        function detectBrand(val) {
            val = val.replace(/\s/g, '');
            let brand = '💳';
            if (/^4/.test(val)) brand = '💙 Visa';
            else if (/^5[1-5]/.test(val)) brand = '🔴 MC';
            document.getElementById('cardBrand').innerText = brand;
        }

        function validateCard() {
            const num = document.getElementById('cardNumber').value.replace(/\s/g, '');
            const exp = document.getElementById('expiry').value;
            const cvv = document.getElementById('cvv').value;
            const err = document.getElementById('cardError');

            if (num.length !== 16) {
                err.textContent = 'Card number must be 16 digits.';
                err.classList.remove('d-none'); return false;
            }
            if (!/^\d{2}\/\d{2}$/.test(exp)) {
                err.textContent = 'Enter expiry as MM/YY.';
                err.classList.remove('d-none'); return false;
            }
            if (cvv.length !== 3) {
                err.textContent = 'CVV must be 3 digits.';
                err.classList.remove('d-none'); return false;
            }
            err.classList.add('d-none');
            return true;
        }
    </script>
</body>
</html>
