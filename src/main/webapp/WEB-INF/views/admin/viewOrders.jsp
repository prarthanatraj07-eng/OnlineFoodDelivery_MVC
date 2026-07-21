<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Orders — FoodExpress Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f4f6f8; display:flex; flex-direction:column; min-height:100vh;">
        <%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

          <div class="main-content">
            <div class="container-fluid">

              <h3 class="section-header mb-4">📦 Live Orders Console</h3>

              <div class="table-wrapper">
                <div class="table-title">Total Orders: ${orders.size()}</div>
                <table class="table" style="font-size:0.88rem;">
                  <thead>
                    <tr>
                      <th>Order ID</th>
                      <th>Customer ID</th>
                      <th>Date</th>
                      <th>Total</th>
                      <th>Payment</th>
                      <th>Address</th>
                      <th>Status</th>
                      <th>Update Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:choose>
                      <c:when test="${empty orders}">
                        <tr>
                          <td colspan="8" class="text-center text-muted" style="padding:40px;">
                            <div style="font-size:2.5rem; margin-bottom:10px;">📭</div>
                            No orders yet.
                          </td>
                        </tr>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="order" items="${orders}">
                          <tr>
                            <td class="fw-bold">#
                              <c:out value="${order.orderId}" />
                            </td>
                            <td class="text-muted">User #
                              <c:out value="${order.userId}" />
                            </td>
                            <td>
                              <small>
                                <fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy" /><br>
                                <span class="text-muted">
                                  <fmt:formatDate value="${order.createdAt}" pattern="hh:mm a" />
                                </span>
                              </small>
                            </td>
                            <td class="fw-bold" style="color:#FF6B35;">
                              ₹
                              <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00" />
                            </td>
                            <td><span class="badge badge-secondary">
                                <c:out value="${order.paymentMethod}" />
                              </span></td>
                            <td>
                              <small class="text-muted" title="${order.deliveryAddress}"
                                style="display:block; max-width:130px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
                                <c:out value="${order.deliveryAddress}" />
                              </small>
                            </td>
                            <td>
                              <span class="badge ${order.statusBadgeClass}">
                                <c:out value="${order.status}" />
                              </span>
                            </td>
                            <td>
                              <%-- Dropdown update --%>
                                <form method="post" action="${pageContext.request.contextPath}/admin/orders"
                                  class="status-update-form">
                                  <input type="hidden" name="action" value="updateStatus">
                                  <input type="hidden" name="orderId" value="${order.orderId}">
                                  <select name="status" class="form-control status-select" style="width:auto;">
                                    <c:forEach var="opt" items="${statusOptions}">
                                      <option value="${opt}" ${order.status==opt ? 'selected' : '' }>${opt}</option>
                                    </c:forEach>
                                  </select>
                                  <button type="submit" class="btn btn-sm btn-dark">Save</button>
                                </form>

                                <%-- Quick Lifecycle Buttons --%>
                                  <div class="quick-actions">
                                    <c:if test="${order.status == 'PLACED'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="ACCEPTED">
                                        <button type="submit" class="btn btn-sm btn-success">Accept</button>
                                      </form>
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="REJECTED">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">Reject</button>
                                      </form>
                                    </c:if>
                                    <c:if test="${order.status == 'ACCEPTED' || order.status == 'CONFIRMED'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="PREPARING">
                                        <button type="submit" class="btn btn-sm btn-warning">Start Prep</button>
                                      </form>
                                    </c:if>
                                    <c:if test="${order.status == 'PREPARING'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="FOOD_READY">
                                        <button type="submit" class="btn btn-sm btn-info">Food Ready</button>
                                      </form>
                                    </c:if>
                                    <c:if test="${order.status == 'FOOD_READY'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="ASSIGNED">
                                        <button type="submit" class="btn btn-sm btn-info">Assign Delivery</button>
                                      </form>
                                    </c:if>
                                    <c:if test="${order.status == 'ASSIGNED'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="OUT_FOR_DELIVERY">
                                        <button type="submit" class="btn btn-sm btn-primary">Out For Delivery</button>
                                      </form>
                                    </c:if>
                                    <c:if test="${order.status == 'OUT_FOR_DELIVERY'}">
                                      <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <input type="hidden" name="status" value="DELIVERED">
                                        <button type="submit" class="btn btn-sm btn-success">Mark Delivered</button>
                                      </form>
                                    </c:if>
                                  </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </tbody>
                </table>
              </div>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>