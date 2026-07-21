<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Track Order #${order.orderId} — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <div class="page-header-inner">
                <div>
                  <h1>Order Tracking #${order.orderId}</h1>
                  <p>Delivery status &amp; estimated arrival</p>
                </div>
                <div style="display:flex; gap:8px; flex-wrap:wrap;">
                  <a href="${pageContext.request.contextPath}/invoice?orderId=${order.orderId}" target="_blank"
                    class="btn btn-warning">🖨️ Print Invoice</a>
                  <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline"
                    style="color:#fff; border-color:rgba(255,255,255,.5);">← My Orders</a>
                </div>
              </div>
            </div>
          </div>

          <div class="main-content">
            <div class="container" style="max-width:950px;">

              <%-- Estimated Delivery Banner --%>
                <div class="card" style="background:#1a252f; color:#fff; margin-bottom:20px;">
                  <div class="track-top-card">
                    <div style="display:flex; align-items:center; gap:14px;">
                      <span style="font-size:2.5rem;">🛵</span>
                      <div>
                        <h4 style="color:#fff; margin-bottom:4px;">Estimated Arrival Time</h4>
                        <p style="color:rgba(255,255,255,.65); font-size:0.88rem; margin:0;">Your food order is
                          progressing through our kitchen.</p>
                      </div>
                    </div>
                    <div class="track-eta">
                      <div class="eta-label">Estimated Time</div>
                      <div class="eta-time">25–30 min</div>
                    </div>
                  </div>
                </div>

                <%-- 7-Stage Status Stepper (server-side JSTL, no JS) --%>
                  <div class="card mb-4">
                    <div class="card-header" style="display:flex; justify-content:space-between; align-items:center;">
                      <span>📍 7-Stage Delivery Timeline</span>
                      <span class="badge badge-success">Refresh page for live updates</span>
                    </div>

                    <c:set var="s" value="${order.status}" />

                    <c:if test="${s == 'CANCELLED' || s == 'REJECTED'}">
                      <div class="alert alert-danger">❌ This order was <strong>${s}</strong>.</div>
                    </c:if>

                    <c:if test="${s != 'CANCELLED' && s != 'REJECTED'}">
                      <%-- Determine if each stage is done, current, or pending. Stages in order: PLACED(0) ACCEPTED(1)
                        PREPARING(2) FOOD_READY(3) ASSIGNED(4) OUT_FOR_DELIVERY(5) DELIVERED(6) --%>
                        <c:set var="isPastPlaced"
                          value="${s eq 'ACCEPTED' or s eq 'PREPARING' or s eq 'FOOD_READY' or s eq 'ASSIGNED' or s eq 'OUT_FOR_DELIVERY' or s eq 'DELIVERED'}" />
                        <c:set var="isPastAccepted"
                          value="${s eq 'PREPARING' or s eq 'FOOD_READY' or s eq 'ASSIGNED' or s eq 'OUT_FOR_DELIVERY' or s eq 'DELIVERED'}" />
                        <c:set var="isPastPreparing"
                          value="${s eq 'FOOD_READY' or s eq 'ASSIGNED' or s eq 'OUT_FOR_DELIVERY' or s eq 'DELIVERED'}" />
                        <c:set var="isPastFoodReady"
                          value="${s eq 'ASSIGNED' or s eq 'OUT_FOR_DELIVERY' or s eq 'DELIVERED'}" />
                        <c:set var="isPastAssigned" value="${s eq 'OUT_FOR_DELIVERY' or s eq 'DELIVERED'}" />
                        <c:set var="isPastOutForDel" value="${s eq 'DELIVERED'}" />

                        <ul class="status-stepper">
                          <%-- 1. PLACED --%>
                            <li
                              class="${isPastPlaced ? 'status-step-done' : (s eq 'PLACED' ? 'status-step-current' : 'status-step-pending')}">
                              <span class="step-num">${isPastPlaced ? '✓' : '1'}</span>
                              <span>Order Placed</span>
                            </li>
                            <%-- 2. ACCEPTED --%>
                              <li
                                class="${isPastAccepted ? 'status-step-done' : (s eq 'ACCEPTED' ? 'status-step-current' : 'status-step-pending')}">
                                <span class="step-num">${isPastAccepted ? '✓' : '2'}</span>
                                <span>Accepted by Restaurant</span>
                              </li>
                              <%-- 3. PREPARING --%>
                                <li
                                  class="${isPastPreparing ? 'status-step-done' : (s eq 'PREPARING' ? 'status-step-current' : 'status-step-pending')}">
                                  <span class="step-num">${isPastPreparing ? '✓' : '3'}</span>
                                  <span>Preparing Food 👨‍🍳</span>
                                </li>
                                <%-- 4. FOOD_READY --%>
                                  <li
                                    class="${isPastFoodReady ? 'status-step-done' : (s eq 'FOOD_READY' ? 'status-step-current' : 'status-step-pending')}">
                                    <span class="step-num">${isPastFoodReady ? '✓' : '4'}</span>
                                    <span>Food Ready 🍱</span>
                                  </li>
                                  <%-- 5. ASSIGNED --%>
                                    <li
                                      class="${isPastAssigned ? 'status-step-done' : (s eq 'ASSIGNED' ? 'status-step-current' : 'status-step-pending')}">
                                      <span class="step-num">${isPastAssigned ? '✓' : '5'}</span>
                                      <span>Delivery Agent Assigned</span>
                                    </li>
                                    <%-- 6. OUT_FOR_DELIVERY --%>
                                      <li
                                        class="${isPastOutForDel ? 'status-step-done' : (s eq 'OUT_FOR_DELIVERY' ? 'status-step-current' : 'status-step-pending')}">
                                        <span class="step-num">${isPastOutForDel ? '✓' : '6'}</span>
                                        <span>Out for Delivery 🛵</span>
                                      </li>
                                      <%-- 7. DELIVERED --%>
                                        <li class="${s eq 'DELIVERED' ? 'status-step-done' : 'status-step-pending'}">
                                          <span class="step-num">${s eq 'DELIVERED' ? '✓' : '7'}</span>
                                          <span>Delivered 🎉</span>
                                        </li>
                        </ul>
                    </c:if>
                  </div>

                  <%-- Order Info + Payment Verification --%>
                    <div class="row mb-4">
                      <div class="col">
                        <div class="card">
                          <div class="card-header">🧾 Order Info</div>
                          <table class="table table-borderless mb-0">
                            <tr>
                              <td class="text-muted">Delivery Address</td>
                              <td class="fw-bold">${order.deliveryAddress}</td>
                            </tr>
                            <tr>
                              <td class="text-muted">Payment Method</td>
                              <td><span class="badge badge-secondary">${order.paymentMethod}</span></td>
                            </tr>
                            <tr>
                              <td class="text-muted">Current Status</td>
                              <td><span class="badge ${order.statusBadgeClass}">${order.status}</span></td>
                            </tr>
                            <tr style="border-top:1px solid #eee;">
                              <td class="text-muted fw-bold">Total Paid</td>
                              <td class="fw-bold" style="font-size:1.15rem; color:#2C3E50;">
                                ₹
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                              </td>
                            </tr>
                          </table>
                        </div>
                      </div>

                      <c:if test="${not empty payment}">
                        <div class="col">
                          <div class="card">
                            <div class="card-header">💳 Payment Verification</div>
                            <table class="table table-borderless mb-0">
                              <tr>
                                <td class="text-muted">Payment Type</td>
                                <td><span class="badge badge-secondary">${payment.paymentMethod}</span></td>
                              </tr>
                              <tr>
                                <td class="text-muted">Gateway Status</td>
                                <td><span class="badge badge-success">✓ ${payment.status}</span></td>
                              </tr>
                              <c:if test="${not empty payment.transactionId}">
                                <tr style="border-top:1px solid #eee;">
                                  <td class="text-muted">Transaction Ref</td>
                                  <td class="small"
                                    style="font-family:'Courier New',monospace; color:#555; font-weight:700;">
                                    ${payment.transactionId}
                                  </td>
                                </tr>
                              </c:if>
                            </table>
                          </div>
                        </div>
                      </c:if>
                    </div>

                    <%-- Order Items Table --%>
                      <div class="table-wrapper">
                        <div class="table-title">
                          🍽️ Feast Items Ordered
                          <span class="badge badge-secondary" style="margin-left:8px;">${orderItems.size()} Items</span>
                        </div>
                        <table class="table">
                          <thead>
                            <tr>
                              <th>Item Name</th>
                              <th style="text-align:center;">Qty</th>
                              <th>Unit Price</th>
                              <th style="text-align:right; padding-right:16px;">Subtotal</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach var="item" items="${orderItems}">
                              <tr>
                                <td class="fw-bold">
                                  <span>${item.food.veg ? '🟢' : '🔴'}</span>
                                  ${item.food.name}
                                </td>
                                <td style="text-align:center;">
                                  <span class="badge badge-secondary">${item.quantity}</span>
                                </td>
                                <td class="text-muted">₹
                                  <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" />
                                </td>
                                <td style="text-align:right; padding-right:16px; font-weight:700; color:#2C3E50;">
                                  ₹
                                  <fmt:formatNumber value="${item.itemTotal}" pattern="#,##0.00" />
                                </td>
                              </tr>
                            </c:forEach>
                          </tbody>
                          <tfoot>
                            <tr style="background:#f5f5f5;">
                              <td colspan="3"
                                style="text-align:right; font-weight:700; font-size:1rem; color:#555; padding-right:8px;">
                                Total Amount Paid
                              </td>
                              <td
                                style="text-align:right; font-weight:800; font-size:1.1rem; color:#27ae60; padding-right:16px;">
                                ₹
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>