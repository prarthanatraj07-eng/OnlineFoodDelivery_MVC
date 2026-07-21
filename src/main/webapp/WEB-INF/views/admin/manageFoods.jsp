<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Foods — FoodExpress Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f4f6f8; display:flex; flex-direction:column; min-height:100vh;">
        <%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

          <div class="main-content">
            <div class="container-fluid">

              <h3 class="section-header mb-4">🍕 Manage Food Items</h3>

              <%-- Add / Edit Form --%>
                <div class="form-card">
                  <h5>
                    <c:choose>
                      <c:when test="${not empty editFood}">✏️ Edit Food Item</c:when>
                      <c:otherwise>➕ Add New Food Item</c:otherwise>
                    </c:choose>
                  </h5>
                  <form method="post" action="${pageContext.request.contextPath}/admin/food">
                    <input type="hidden" name="action" value="${not empty editFood ? 'edit' : 'add'}">
                    <c:if test="${not empty editFood}">
                      <input type="hidden" name="foodId" value="${editFood.foodId}">
                    </c:if>

                    <div class="form-row">
                      <div class="form-group">
                        <label>Food Name *</label>
                        <input type="text" class="form-control" name="name" required
                          value="${not empty editFood ? editFood.name : ''}">
                      </div>
                      <div class="form-group">
                        <label>Restaurant *</label>
                        <select class="form-control" name="restaurantId" required>
                          <option value="">-- Select Restaurant --</option>
                          <c:forEach var="r" items="${restaurants}">
                            <option value="${r.restaurantId}" ${(not empty editFood &&
                              editFood.restaurantId==r.restaurantId) ? 'selected' : '' }>
                              <c:out value="${r.name}" />
                            </option>
                          </c:forEach>
                        </select>
                      </div>
                      <div class="form-group" style="max-width:140px;">
                        <label>Price (₹) *</label>
                        <input type="number" class="form-control" name="price" step="0.01" min="0" required
                          value="${not empty editFood ? editFood.price : ''}">
                      </div>
                      <div class="form-group">
                        <label>Category</label>
                        <input type="text" class="form-control" name="category" placeholder="e.g. Starters, Main Course"
                          value="${not empty editFood ? editFood.category : ''}">
                      </div>
                    </div>

                    <div class="form-row">
                      <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" name="description"
                          rows="2"><c:if test="${not empty editFood}"><c:out value="${editFood.description}"/></c:if></textarea>
                      </div>
                      <input type="hidden" name="imageUrl" value="">
                    </div>

                    <div class="form-row" style="align-items:flex-end;">
                      <div class="form-check" style="margin-bottom:14px;">
                        <input type="checkbox" id="isAvailable" name="isAvailable" value="on" ${(empty editFood ||
                          editFood.available) ? 'checked' : '' }>
                        <label for="isAvailable" class="fw-semibold">Available</label>
                      </div>
                    </div>

                    <div style="display:flex; gap:8px; margin-top:4px;">
                      <button type="submit" class="btn btn-orange">💾 Save Food Item</button>
                      <c:if test="${not empty editFood}">
                        <a href="${pageContext.request.contextPath}/admin/food"
                          class="btn btn-outline-secondary">Cancel</a>
                      </c:if>
                    </div>
                  </form>
                </div>

                <%-- Foods Table --%>
                  <div class="table-wrapper">
                    <div class="table-title">All Food Items (${foods.size()})</div>
                    <table class="table">
                      <thead>
                        <tr>
                          <th>ID</th>
                          <th>Name</th>
                          <th>Restaurant</th>
                          <th>Category</th>
                          <th>Price</th>
                          <th>Available</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:choose>
                          <c:when test="${empty foods}">
                            <tr>
                              <td colspan="7" class="text-center text-muted" style="padding:30px;">No food items yet.
                              </td>
                            </tr>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="f" items="${foods}">
                              <tr>
                                <td>#
                                  <c:out value="${f.foodId}" />
                                </td>
                                <td class="fw-bold">
                                  <c:out value="${f.name}" />
                                </td>
                                <td>
                                  <c:forEach var="r" items="${restaurants}">
                                    <c:if test="${r.restaurantId == f.restaurantId}">
                                      <span class="text-muted small">
                                        <c:out value="${r.name}" />
                                      </span>
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td><span class="badge badge-warning">
                                    <c:out value="${f.category}" />
                                  </span></td>
                                <td class="fw-bold" style="color:#FF6B35;">₹
                                  <fmt:formatNumber value="${f.price}" pattern="#,##0.00" />
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${f.available}"><span class="badge badge-success">Yes</span></c:when>
                                    <c:otherwise><span class="badge badge-secondary">No</span></c:otherwise>
                                  </c:choose>
                                </td>
                                <td>
                                  <a href="${pageContext.request.contextPath}/admin/food?action=edit&id=${f.foodId}"
                                    class="btn btn-sm btn-info" style="margin-right:4px;">✏️ Edit</a>
                                  <form method="post" action="${pageContext.request.contextPath}/admin/food"
                                    style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${f.foodId}">
                                    <button type="submit" class="btn btn-sm btn-danger">🗑️</button>
                                  </form>
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