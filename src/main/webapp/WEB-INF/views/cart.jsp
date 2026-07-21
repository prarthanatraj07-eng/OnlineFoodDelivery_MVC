<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Cart — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <h1>My Food Cart 🛒</h1>
              <p>Review your items before checkout</p>
            </div>
          </div>

          <div class="main-content">
            <div class="container">

              <c:if test="${not empty error}">
                <div class="alert alert-danger">
                  <c:out value="${error}" />
                </div>
              </c:if>

              <c:choose>
                <c:when test="${empty cartItems}">
                  <div class="empty-state">
                    <span class="empty-icon">🛒</span>
                    <h3>Your Cart is Empty</h3>
                    <p>There is nothing in your cart yet. Explore our restaurant outlets and add some yummy dishes!</p>
                    <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary btn-lg">🍕 Browse
                      Restaurants &amp; Order</a>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="row">

                    <%-- Left Column: Cart Items --%>
                      <div class="col-7">
                        <div class="card">
                          <div class="card-header">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                              <span>Order Items (${cartCount})</span>
                            </div>
                          </div>

                          <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item">
                              <div style="display:flex; align-items:center; gap:10px; flex-grow:1;">
                                <span style="font-size:1.2rem;">${item.food.veg ? '🟢' : '🔴'}</span>
                                <div>
                                  <div class="fw-bold">${item.food.name}</div>
                                  <span class="text-muted small">₹
                                    <fmt:formatNumber value="${item.food.price}" pattern="#,##0.00" /> each
                                  </span>
                                </div>
                              </div>

                              <div class="cart-item-actions">
                                <%-- Qty - button --%>
                                  <div class="qty-controls">
                                    <form method="post" action="${pageContext.request.contextPath}/cart">
                                      <input type="hidden" name="action" value="update">
                                      <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                      <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                      <button type="submit" class="qty-btn">−</button>
                                    </form>
                                    <span class="qty-display">${item.quantity}</span>
                                    <form method="post" action="${pageContext.request.contextPath}/cart">
                                      <input type="hidden" name="action" value="update">
                                      <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                      <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                      <button type="submit" class="qty-btn">+</button>
                                    </form>
                                  </div>

                                  <span class="item-price">₹
                                    <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00" />
                                  </span>

                                  <%-- Remove button --%>
                                    <form method="post" action="${pageContext.request.contextPath}/cart"
                                      style="margin:0;">
                                      <input type="hidden" name="action" value="remove">
                                      <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                      <button type="submit" class="btn btn-sm btn-outline-danger"
                                        title="Remove Item">🗑️</button>
                                    </form>
                              </div>
                            </div>
                          </c:forEach>
                        </div>

                        <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-outline">← Add More
                          Items</a>
                      </div>

                      <%-- Right Column: Coupons + Summary --%>
                        <div class="col-5">

                          <%-- Coupons --%>
                            <div class="card">
                              <div class="card-header">🎁 Offers &amp; Coupons</div>

                              <c:if test="${not empty appliedCoupon}">
                                <div class="coupon-applied">
                                  <span>✨ Applied <strong>${appliedCoupon}</strong>
                                    (−₹
                                    <fmt:formatNumber value="${cartDiscount}" pattern="#,##0" />)
                                  </span>
                                  <form method="post" action="${pageContext.request.contextPath}/cart"
                                    style="margin:0;">
                                    <input type="hidden" name="action" value="removeCoupon">
                                    <button type="submit" class="btn btn-sm btn-outline-danger">REMOVE</button>
                                  </form>
                                </div>
                              </c:if>

                              <form method="post" action="${pageContext.request.contextPath}/cart">
                                <input type="hidden" name="action" value="applyCoupon">
                                <div class="coupon-row mb-3">
                                  <input type="text" name="code" class="form-control" placeholder="Enter promo code"
                                    required style="text-transform:uppercase;">
                                  <button type="submit" class="btn btn-dark">APPLY</button>
                                </div>
                              </form>

                              <c:if test="${not empty availableCoupons}">
                                <p class="small text-muted fw-bold mb-2">Available Promos:</p>
                                <div class="available-coupons">
                                  <c:forEach var="cp" items="${availableCoupons}">
                                    <div class="coupon-chip">
                                      <strong>🏷️ ${cp.code}</strong>
                                      <span class="text-muted small">${cp.description}</span>
                                    </div>
                                  </c:forEach>
                                </div>
                              </c:if>
                            </div>

                            <%-- Order Summary --%>
                              <div class="card">
                                <div class="card-header">Order Summary</div>
                                <div class="summary-row"><span>Item Total</span> <span class="fw-bold">₹
                                    <fmt:formatNumber value="${cartSubtotal}" pattern="#,##0.00" />
                                  </span></div>
                                <div class="summary-row">
                                  <span>Delivery Fee</span>
                                  <span class="fw-bold">
                                    <c:choose>
                                      <c:when test="${cartDeliveryFee == 0}"><span
                                          class="text-success fw-bold">FREE</span></c:when>
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
                                    <span>Promo Discount (${appliedCoupon})</span>
                                    <span>−₹
                                      <fmt:formatNumber value="${cartDiscount}" pattern="#,##0.00" />
                                    </span>
                                  </div>
                                </c:if>
                                <div class="summary-row total">
                                  <span>To Pay</span>
                                  <span style="color:#2980b9;">₹
                                    <fmt:formatNumber value="${cartTotal}" pattern="#,##0.00" />
                                  </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/checkout"
                                  class="btn btn-success btn-block btn-lg mt-3">
                                  Proceed to Checkout →
                                </a>
                              </div>

                        </div>
                  </div>
                </c:otherwise>
              </c:choose>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>