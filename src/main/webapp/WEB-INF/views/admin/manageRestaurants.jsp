<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Restaurants — FoodExpress Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f4f6f8; display:flex; flex-direction:column; min-height:100vh;">
        <%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

          <div class="main-content">
            <div class="container-fluid">

              <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <h3 class="section-header" style="margin-bottom:0;">🏪 Manage Restaurants</h3>
              </div>

              <c:if test="${not empty error}">
                <div class="alert alert-danger">
                  <c:out value="${error}" />
                </div>
              </c:if>

              <%-- Add / Edit Form --%>
                <div class="form-card">
                  <h5>
                    <c:choose>
                      <c:when test="${not empty editRestaurant}">✏️ Edit Restaurant</c:when>
                      <c:otherwise>➕ Add New Restaurant</c:otherwise>
                    </c:choose>
                  </h5>
                  <form method="post" action="${pageContext.request.contextPath}/admin/restaurant">
                    <input type="hidden" name="action" value="${not empty editRestaurant ? 'edit' : 'add'}">
                    <c:if test="${not empty editRestaurant}">
                      <input type="hidden" name="restaurantId" value="${editRestaurant.restaurantId}">
                    </c:if>

                    <div class="form-row">
                      <div class="form-group">
                        <label>Restaurant Name *</label>
                        <input type="text" class="form-control" name="name" required
                          value="${not empty editRestaurant ? editRestaurant.name : ''}">
                      </div>
                      <div class="form-group">
                        <label>Cuisine Type</label>
                        <input type="text" class="form-control" name="cuisineType"
                          value="${not empty editRestaurant ? editRestaurant.cuisineType : ''}">
                      </div>
                      <div class="form-group" style="max-width:140px;">
                        <label>Rating (0–5)</label>
                        <input type="number" class="form-control" name="rating" min="0" max="5" step="0.1"
                          value="${not empty editRestaurant ? editRestaurant.rating : '4.0'}">
                      </div>
                    </div>

                    <div class="form-row">
                      <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" name="description"
                          rows="2"><c:if test="${not empty editRestaurant}"><c:out value="${editRestaurant.description}"/></c:if></textarea>
                      </div>
                      <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" name="address"
                          value="${not empty editRestaurant ? editRestaurant.address : ''}">
                      </div>
                    </div>

                    <div class="form-row">
                      <div class="form-group">
                        <label>Phone</label>
                        <input type="tel" class="form-control" name="phone"
                          value="${not empty editRestaurant ? editRestaurant.phone : ''}">
                      </div>
                      <div class="form-group"
                        style="flex:0; min-width:120px; display:flex; align-items:flex-end; padding-bottom:4px;">
                        <div class="form-check">
                          <input type="checkbox" id="isActive" name="isActive" value="on" ${(empty editRestaurant ||
                            editRestaurant.active) ? 'checked' : '' }>
                          <label for="isActive" class="fw-semibold">Is Active</label>
                        </div>
                      </div>
                      <input type="hidden" name="imageUrl" value="">
                    </div>

                    <div style="display:flex; gap:8px; margin-top:4px;">
                      <button type="submit" class="btn btn-orange">💾 Save Restaurant</button>
                      <c:if test="${not empty editRestaurant}">
                        <a href="${pageContext.request.contextPath}/admin/restaurant"
                          class="btn btn-outline-secondary">Cancel</a>
                      </c:if>
                    </div>
                  </form>
                </div>

                <%-- Restaurant Table --%>
                  <div class="table-wrapper">
                    <div class="table-title">All Restaurants (${restaurants.size()})</div>
                    <table class="table">
                      <thead>
                        <tr>
                          <th>ID</th>
                          <th>Name</th>
                          <th>Cuisine</th>
                          <th>Rating</th>
                          <th>Active</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:choose>
                          <c:when test="${empty restaurants}">
                            <tr>
                              <td colspan="6" class="text-center text-muted" style="padding:30px;">No restaurants yet.
                              </td>
                            </tr>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="r" items="${restaurants}">
                              <tr>
                                <td>#
                                  <c:out value="${r.restaurantId}" />
                                </td>
                                <td class="fw-bold">
                                  <c:out value="${r.name}" />
                                </td>
                                <td><span class="badge badge-warning">
                                    <c:out value="${r.cuisineType}" />
                                  </span></td>
                                <td>⭐
                                  <c:out value="${r.rating}" />
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${r.active}"><span class="badge badge-success">Active</span></c:when>
                                    <c:otherwise><span class="badge badge-secondary">Inactive</span></c:otherwise>
                                  </c:choose>
                                </td>
                                <td>
                                  <a href="${pageContext.request.contextPath}/admin/restaurant?action=edit&id=${r.restaurantId}"
                                    class="btn btn-sm btn-info" style="margin-right:4px;">✏️ Edit</a>
                                  <form method="post" action="${pageContext.request.contextPath}/admin/restaurant"
                                    style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${r.restaurantId}">
                                    <button type="submit" class="btn btn-sm btn-danger">🗑️ Delete</button>
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