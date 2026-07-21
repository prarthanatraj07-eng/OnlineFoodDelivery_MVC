<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${restaurant.name} Menu — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <%--===== Different Restaurant Warning=====-%>
            <c:if test="${not empty sessionScope.diffRestaurantModal}">
              <div class="container" style="margin-top:20px;">
                <div class="warning-block">
                  <h4>⚠️ Items Already in Cart</h4>
                  <p>
                    Your cart contains dishes from <strong>
                      <c:out value="${sessionScope.currentRestName}" />
                    </strong>.
                    Would you like to clear your cart and start fresh from this restaurant?
                  </p>
                  <div class="warning-btn-row">
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=${restaurant.restaurantId}"
                      class="btn btn-outline">No, Keep Current Cart</a>
                    <form method="post" action="${pageContext.request.contextPath}/cart" style="margin:0;">
                      <input type="hidden" name="action" value="clearAndAdd">
                      <button type="submit" class="btn btn-danger">Yes, Start Afresh</button>
                    </form>
                  </div>
                </div>
              </div>
              <c:remove var="diffRestaurantModal" scope="session" />
            </c:if>

            <%-- Restaurant Hero Card --%>
              <div class="restaurant-hero">
                <div class="container">
                  <a href="${pageContext.request.contextPath}/restaurants"
                    class="btn btn-outline btn-sm search-back-link">← Back to Stores</a>
                  <div class="card" style="margin-bottom:0;">
                    <div class="restaurant-hero-inner">
                      <div>
                        <h1 style="font-size:1.6rem; margin-bottom:8px;">${restaurant.name}</h1>
                        <div style="display:flex; flex-wrap:wrap; gap:6px; margin-bottom:10px;">
                          <span class="badge badge-dark">${restaurant.cuisineType}</span>
                          <span class="badge badge-success">⭐ ${restaurant.rating}</span>
                          <span class="badge badge-info">🕒 ${not empty restaurant.deliveryTime ?
                            restaurant.deliveryTime : '20-30 mins'}</span>
                        </div>
                        <p class="text-muted small mb-1">${restaurant.description}</p>
                        <small class="text-muted">📍 ${restaurant.address} &nbsp;|&nbsp; 📞 ${restaurant.phone}</small>
                      </div>
                      <div class="restaurant-delivery-info">
                        <span class="small text-muted d-block mb-1 fw-bold">Delivery Fee</span>
                        <span style="font-size:1.4rem; font-weight:700; color:#27ae60;">
                          ₹
                          <fmt:formatNumber value="${restaurant.deliveryFee}" pattern="#,##0" />
                        </span>
                        <span class="badge badge-success d-block mt-2">🟢 Open</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="main-content">
                <div class="container" style="max-width:900px;">

                  <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <h3 class="section-header" style="margin-bottom:0;">Culinary Menu</h3>
                    <span class="badge badge-secondary">${not empty foods ? foods.size() : 0} Dishes</span>
                  </div>

                  <c:choose>
                    <c:when test="${empty foods}">
                      <div class="empty-state">
                        <span class="empty-icon">🍕</span>
                        <h3>No Menu Items Available Right Now</h3>
                        <p>The chef is preparing a brand new menu for this outlet. Please check back soon!</p>
                        <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">🏪 Browse Other
                          Outlets</a>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <c:set var="currentCategory" value="" />
                      <c:forEach var="food" items="${foods}">
                        <c:if test="${food.category != currentCategory}">
                          <c:set var="currentCategory" value="${food.category}" />
                          <div class="menu-category-title">🍴 ${food.category}</div>
                        </c:if>

                        <div class="menu-item">
                          <div class="menu-item-info">
                            <div style="display:flex; align-items:center; gap:8px; margin-bottom:4px;">
                              <span>${food.veg ? '🟢' : '🔴'}</span>
                              <span class="fw-bold">${food.name}</span>
                              <c:if test="${food.price > 250}">
                                <span class="bestseller-badge">★ Bestseller</span>
                              </c:if>
                            </div>
                            <span class="menu-item-price">₹
                              <fmt:formatNumber value="${food.price}" pattern="#,##0.00" />
                            </span>
                            <p class="menu-item-desc mb-0">${food.description}</p>
                          </div>
                          <div>
                            <c:choose>
                              <c:when test="${!food.available}">
                                <span class="badge badge-secondary" style="padding:8px 12px;">Out of Stock</span>
                              </c:when>
                              <c:otherwise>
                                <form method="post" action="${pageContext.request.contextPath}/cart" class="add-form">
                                  <input type="hidden" name="action" value="add">
                                  <input type="hidden" name="foodId" value="${food.foodId}">
                                  <input type="number" name="quantity" value="1" min="1" max="10"
                                    style="width:50px; padding:4px; text-align:center; border:1px solid #ccc; border-radius:3px;">
                                  <button type="submit" class="btn btn-success btn-sm">ADD</button>
                                </form>
                              </c:otherwise>
                            </c:choose>
                          </div>
                        </div>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>

                  <%--===== CUSTOMER REVIEWS SECTION=====-%>
                    <div class="reviews-section">
                      <h3 style="margin-bottom:16px;">⭐ Customer Ratings &amp; Reviews (${reviews.size()})</h3>
                      <c:choose>
                        <c:when test="${empty reviews}">
                          <p class="text-muted small">No reviews yet for this outlet. Be the first to order and leave
                            feedback!</p>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="rev" items="${reviews}">
                            <div class="review-card">
                              <div class="review-card-header">
                                <span class="fw-bold">👤 ${rev.userName}</span>
                                <span class="badge badge-success">⭐ ${rev.rating} / 5</span>
                              </div>
                              <p class="small text-muted mb-1">${rev.comment}</p>
                              <small class="text-muted fs-sm">
                                <fmt:formatDate value="${rev.createdAt}" pattern="dd MMM yyyy, hh:mm a" />
                              </small>
                            </div>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </div>

                </div>
              </div>

              <footer class="main-footer">
                <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
              </footer>
      </body>

      </html>