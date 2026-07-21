<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Orders — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <h1>My Orders History 📦</h1>
              <p>Track active deliveries and review past feasts</p>
            </div>
          </div>

          <div class="main-content">
            <div class="container">

              <c:choose>
                <c:when test="${empty orders}">
                  <div class="empty-state">
                    <span class="empty-icon">📭</span>
                    <h3>No Orders Placed Yet</h3>
                    <p>You haven't ordered any food with us. Whenever you place an order, its tracking will appear right
                      here!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">🍔 Order Delicious
                      Meal Now</a>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="table-wrapper">
                    <table class="table orders-table">
                      <thead>
                        <tr>
                          <th>Order ID</th>
                          <th>Date &amp; Time</th>
                          <th>Payment</th>
                          <th>Total Amount</th>
                          <th>Status</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="order" items="${orders}">
                          <tr>
                            <td class="fw-bold">#
                              <c:out value="${order.orderId}" />
                            </td>
                            <td class="text-muted small">
                              <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                            </td>
                            <td>
                              <span class="badge badge-secondary">💳
                                <c:out value="${order.paymentMethod}" />
                              </span>
                            </td>
                            <td class="fw-bold" style="color:#2980b9;">
                              ₹
                              <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                            </td>
                            <td>
                              <span class="badge ${order.statusBadgeClass}">
                                <c:out value="${order.status}" />
                              </span>
                            </td>
                            <td>
                              <a href="${pageContext.request.contextPath}/trackOrder?orderId=${order.orderId}"
                                class="btn btn-sm btn-primary">📍 Track</a>

                              <c:if test="${order.status == 'DELIVERED'}">
                                <%-- Rate Order: HTML5 details/summary — no JS needed --%>
                                  <details class="review-details" style="display:inline-block; margin-left:4px;">
                                    <summary>⭐ Rate</summary>
                                    <div class="review-body">
                                      <form method="post" action="${pageContext.request.contextPath}/review">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <div class="form-group">
                                          <label class="small text-muted fw-bold">Star Rating (1–5 ⭐)</label>
                                          <select name="rating" class="form-control" style="width:auto;">
                                            <option value="5">⭐⭐⭐⭐⭐ (5/5 Excellent)</option>
                                            <option value="4">⭐⭐⭐⭐ (4/5 Good)</option>
                                            <option value="3">⭐⭐⭐ (3/5 Average)</option>
                                            <option value="2">⭐⭐ (2/5 Poor)</option>
                                            <option value="1">⭐ (1/5 Terrible)</option>
                                          </select>
                                        </div>
                                        <div class="form-group">
                                          <label class="small text-muted fw-bold">Feedback Comment</label>
                                          <textarea name="comment" class="form-control" rows="2"
                                            placeholder="Tell us how the food tasted!"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-sm">Submit Review ⭐</button>
                                      </form>
                                    </div>
                                  </details>
                              </c:if>
                            </td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
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