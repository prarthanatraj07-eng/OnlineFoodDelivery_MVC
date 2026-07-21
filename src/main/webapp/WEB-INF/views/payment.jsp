<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Complete Payment — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="main-content">
            <div class="container">
              <div class="payment-card">

                <%-- Order Summary --%>
                  <div class="order-info-card">
                    <h5>📦 Order Summary</h5>
                    <div class="info-row"><span>Order ID</span> <strong>#
                        <c:out value="${order.orderId}" />
                      </strong></div>
                    <div class="info-row"><span>Payment Method</span> <strong>
                        <c:out value="${order.paymentMethod}" />
                      </strong></div>
                    <div class="info-row"><span>Total Amount</span> <strong>₹
                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                      </strong></div>
                  </div>

                  <%-- Payment Form --%>
                    <div class="card">
                      <div class="card-header">🔐 Complete Payment</div>

                      <form method="post" action="${pageContext.request.contextPath}/payment" id="paymentForm">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <input type="hidden" name="paymentMethod" value="${order.paymentMethod}">

                        <c:choose>
                          <%-- COD --%>
                            <c:when test="${order.paymentMethod == 'COD'}">
                              <div class="alert alert-info">
                                💵 You will pay
                                <strong>₹
                                  <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                                </strong>
                                in cash at the time of delivery.
                              </div>
                              <input type="hidden" name="transactionInput" value="COD">
                              <button type="submit" class="btn btn-success btn-block btn-lg">✅ Confirm Order</button>
                            </c:when>

                            <%-- UPI --%>
                              <c:when test="${order.paymentMethod == 'UPI'}">
                                <div class="form-group" id="upi-field">
                                  <label class="payment-field-label">📱 Enter Your UPI ID</label>
                                  <input type="text" class="form-control" name="transactionInput"
                                    placeholder="yourname@upi" required pattern=".*@.*">
                                  <div class="form-text">Example: yourname@okaxis or yourname@paytm</div>
                                </div>
                                <button type="submit" class="btn btn-orange btn-block btn-lg">
                                  Pay ₹
                                  <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /> via UPI →
                                </button>
                              </c:when>

                              <%-- CARD --%>
                                <c:when test="${order.paymentMethod == 'CARD'}">
                                  <div id="card-fields">
                                    <div class="form-group">
                                      <label class="payment-field-label">💳 Card Number</label>
                                      <input type="text" class="form-control" id="cardNumber" name="cardNumber"
                                        maxlength="19" placeholder="1234 5678 9012 3456">
                                    </div>
                                    <div class="form-row">
                                      <div class="form-group">
                                        <label class="payment-field-label">Expiry Date</label>
                                        <input type="text" class="form-control" name="expiry" placeholder="MM/YY"
                                          maxlength="5">
                                      </div>
                                      <div class="form-group">
                                        <label class="payment-field-label">CVV</label>
                                        <input type="password" class="form-control" name="cvv" maxlength="3"
                                          placeholder="•••">
                                      </div>
                                    </div>
                                    <input type="hidden" name="transactionInput" value="DUMMY_CARD">
                                    <button type="submit" class="btn btn-orange btn-block btn-lg">
                                      Pay ₹
                                      <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" /> →
                                    </button>
                                  </div>
                                </c:when>

                                <%-- WALLET --%>
                                  <c:when test="${order.paymentMethod == 'WALLET'}">
                                    <div class="alert alert-info">
                                      💰 Amount will be deducted from your Express Wallet.
                                    </div>
                                    <input type="hidden" name="transactionInput" value="WALLET">
                                    <button type="submit" class="btn btn-success btn-block btn-lg">✅ Confirm
                                      Payment</button>
                                  </c:when>

                                  <c:otherwise>
                                    <div class="alert alert-warning">Invalid payment method. Please go back.</div>
                                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">My
                                      Orders</a>
                                  </c:otherwise>
                        </c:choose>
                      </form>

                      <p class="text-center text-muted small mt-3">🔒 Secure &amp; Encrypted Payment</p>
                    </div>

              </div>
            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>