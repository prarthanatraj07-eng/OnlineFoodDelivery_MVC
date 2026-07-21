<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Secure Checkout — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <h1>Secure Checkout 🔐</h1>
              <p>Complete your order in just a few clicks</p>
            </div>
          </div>

          <div class="main-content">
            <div class="container">

              <c:if test="${not empty error}">
                <div class="alert alert-danger">
                  <c:out value="${error}" />
                </div>
              </c:if>

              <div class="row">

                <%-- Left: Address, Instructions, Payment --%>
                  <div class="col-7">
                    <form method="post" action="${pageContext.request.contextPath}/checkout" id="checkoutForm">

                      <%-- 1. Delivery Address --%>
                        <div class="card">
                          <div class="card-header">📍 Delivery Address</div>

                          <div class="address-option">
                            <label>
                              <input type="radio" name="addressType" value="saved" checked>
                              <div>
                                <span class="address-badge">🏠 Home / Default</span>
                                <p class="mb-0 small fw-bold mt-1">
                                  <c:out value="${userAddress}" />
                                </p>
                              </div>
                            </label>
                          </div>

                          <div class="address-option">
                            <label>
                              <input type="radio" name="addressType" value="work">
                              <div>
                                <span class="address-badge" style="background:#7f8c8d;">💼 Work Office</span>
                                <p class="mb-0 small text-muted mt-1">Tech Park, Tower B, 4th Floor, Bangalore</p>
                              </div>
                            </label>
                          </div>

                          <div class="address-option">
                            <label>
                              <input type="radio" name="addressType" value="other">
                              <div style="flex-grow:1;">
                                <span class="address-badge" style="background:#2980b9;">📍 Enter Custom Address</span>
                                <textarea name="deliveryAddress" class="form-control mt-2" rows="2"
                                  placeholder="Enter your custom delivery address here...">${userAddress}</textarea>
                              </div>
                            </label>
                          </div>

                          <%-- Hidden fallback for saved/work selections --%>
                            <input type="hidden" name="savedAddress" value="${userAddress}">
                            <input type="hidden" name="workAddress" value="Tech Park, Tower B, 4th Floor, Bangalore">
                        </div>

                        <%-- 2. Delivery Instructions --%>
                          <div class="card">
                            <div class="card-header">🛵 Delivery Instructions</div>
                            <div class="instruction-options">
                              <div class="instruction-check">
                                <label><input type="checkbox" name="instructions" value="Leave at door"> Leave at
                                  door</label>
                              </div>
                              <div class="instruction-check">
                                <label><input type="checkbox" name="instructions" value="Avoid calling"> Avoid
                                  calling</label>
                              </div>
                              <div class="instruction-check">
                                <label><input type="checkbox" name="instructions" value="Do not ring doorbell"> Don't
                                  ring doorbell</label>
                              </div>
                              <div class="instruction-check">
                                <label><input type="checkbox" name="instructions" value="Pet at home"> 🐕 Pet at
                                  home</label>
                              </div>
                            </div>
                          </div>

                          <%-- 3. Payment Method --%>
                            <div class="card">
                              <div class="card-header">💳 Payment Method</div>
                              <div class="payment-option">
                                <label>
                                  <input type="radio" name="paymentMethod" value="UPI" checked>
                                  <div>
                                    <strong>📱 UPI Instant</strong>
                                    <small>GPay, PhonePe, Paytm</small>
                                  </div>
                                </label>
                              </div>
                              <div class="payment-option">
                                <label>
                                  <input type="radio" name="paymentMethod" value="CARD">
                                  <div>
                                    <strong>💳 Credit / Debit Card</strong>
                                    <small>Visa, Mastercard, RuPay</small>
                                  </div>
                                </label>
                              </div>
                              <div class="payment-option">
                                <label>
                                  <input type="radio" name="paymentMethod" value="WALLET">
                                  <div>
                                    <strong>💰 Express Wallet</strong>
                                    <small>Balance: ₹500.00</small>
                                  </div>
                                </label>
                              </div>
                              <div class="payment-option">
                                <label>
                                  <input type="radio" name="paymentMethod" value="COD">
                                  <div>
                                    <strong>💵 Cash on Delivery</strong>
                                    <small>Pay cash or UPI at door</small>
                                  </div>
                                </label>
                              </div>
                            </div>

                            <button type="submit" class="btn btn-success btn-block btn-lg">
                              🚀 Place Order (₹
                              <fmt:formatNumber value="${cartTotal}" pattern="#,##0.00" />)
                            </button>
                    </form>
                  </div>

                  <%-- Right: Coupon + Summary --%>
                    <div class="col-5">

                      <%-- Coupon Box --%>
                        <div class="card">
                          <div class="card-header">🏷️ Promo Coupon</div>
                          <c:if test="${not empty appliedCoupon}">
                            <div class="coupon-applied mb-2">
                              <span>✨ Applied <strong>${appliedCoupon}</strong>
                                (−₹
                                <fmt:formatNumber value="${cartDiscount}" pattern="#,##0" />)
                              </span>
                              <form method="post" action="${pageContext.request.contextPath}/cart" style="margin:0;">
                                <input type="hidden" name="action" value="removeCoupon">
                                <button type="submit" class="btn btn-sm btn-outline-danger">REMOVE</button>
                              </form>
                            </div>
                          </c:if>
                          <form method="post" action="${pageContext.request.contextPath}/cart">
                            <input type="hidden" name="action" value="applyCoupon">
                            <div class="coupon-row">
                              <input type="text" name="code" class="form-control" placeholder="Have a coupon code?"
                                required style="text-transform:uppercase;">
                              <button type="submit" class="btn btn-dark">APPLY</button>
                            </div>
                          </form>
                        </div>

                        <%-- Order Summary --%>
                          <div class="card">
                            <div class="card-header">Order Summary (${cartCount} Items)</div>

                            <c:forEach var="item" items="${cartItems}">
                              <div class="summary-row">
                                <span class="text-dark">
                                  <c:out value="${item.quantity}" /> ×
                                  <c:out value="${item.food.name}" />
                                </span>
                                <span class="fw-bold">₹
                                  <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                                </span>
                              </div>
                            </c:forEach>

                            <hr>
                            <div class="summary-row"><span>Item Total</span> <span class="fw-bold">₹
                                <fmt:formatNumber value="${cartSubtotal}" pattern="#,##0.00" />
                              </span></div>
                            <div class="summary-row">
                              <span>Delivery Fee</span>
                              <span class="fw-bold">
                                <c:choose>
                                  <c:when test="${cartDeliveryFee == 0}"><span class="text-success fw-bold">FREE</span>
                                  </c:when>
                                  <c:otherwise>₹${cartDeliveryFee}</c:otherwise>
                                </c:choose>
                              </span>
                            </div>
                            <div class="summary-row"><span>Platform Fee</span> <span class="fw-bold">₹
                                <fmt:formatNumber value="${cartPlatformFee}" pattern="#,##0.00" />
                              </span></div>
                            <div class="summary-row"><span>GST &amp; Taxes (5%)</span> <span class="fw-bold">₹
                                <fmt:formatNumber value="${cartGst}" pattern="#,##0.00" />
                              </span></div>
                            <c:if test="${cartDiscount > 0}">
                              <div class="summary-row discount">
                                <span>Coupon Discount</span>
                                <span>−₹
                                  <fmt:formatNumber value="${cartDiscount}" pattern="#,##0.00" />
                                </span>
                              </div>
                            </c:if>
                            <div class="summary-row total">
                              <span>Grand Total</span>
                              <span style="color:#2980b9;">₹
                                <fmt:formatNumber value="${cartTotal}" pattern="#,##0.00" />
                              </span>
                            </div>

                            <div class="alert alert-info mt-3 mb-0" style="font-size:0.85rem;">
                              🕒 Estimated Delivery: <strong>25–30 Mins</strong>
                            </div>
                          </div>
                    </div>
              </div>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>