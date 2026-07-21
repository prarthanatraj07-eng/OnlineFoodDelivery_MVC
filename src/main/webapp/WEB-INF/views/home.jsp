<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home — FoodExpress</title>
        <meta name="description" content="Order food from top restaurants on FoodExpress.">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <h1>Good day,
                <c:out value="${sessionScope.loggedUser.fullName}" />! 🎉
              </h1>
              <p>What delicious feast are you craving today? Explore top culinary destinations.</p>
            </div>
          </div>

          <div class="main-content">
            <div class="container">

              <c:if test="${not empty error}">
                <div class="alert alert-danger">
                  <c:out value="${error}" />
                </div>
              </c:if>

              <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                <h3 class="section-header" style="margin-bottom:0;">Top Outlets Near You</h3>
                <span class="badge badge-secondary">
                  ${not empty restaurants ? restaurants.size() : 0} Outlets
                </span>
              </div>

              <c:choose>
                <c:when test="${empty restaurants}">
                  <div class="empty-state">
                    <span class="empty-icon">🍽️</span>
                    <h3>No Restaurants Available Right Now</h3>
                    <p>Our delivery partners are currently offline. Please check back shortly!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">🔄 Refresh Page</a>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="restaurant-grid">
                    <c:forEach var="restaurant" items="${restaurants}">
                      <div class="restaurant-card">
                        <div class="card">
                          <div class="card-info">
                            <div
                              style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:6px;">
                              <div>
                                <h5 class="card-title">${restaurant.name}</h5>
                                <span class="badge badge-secondary">${restaurant.cuisineType}</span>
                              </div>
                              <span class="badge badge-success">⭐ ${restaurant.rating}</span>
                            </div>
                            <p class="small text-muted mb-2"
                              style="overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical;">
                              ${restaurant.description}
                            </p>
                          </div>
                          <div class="card-footer border-top pt-3">
                            <div class="restaurant-meta">
                              <span>🕒 ${not empty restaurant.deliveryTime ? restaurant.deliveryTime : '20-30
                                mins'}</span>
                              <span>
                                🛵
                                <c:choose>
                                  <c:when test="${restaurant.deliveryFee == 0}"><span class="text-success fw-bold">Free
                                      Delivery</span></c:when>
                                  <c:otherwise>₹${restaurant.deliveryFee}</c:otherwise>
                                </c:choose>
                              </span>
                              <span class="badge badge-success">🟢 Open</span>
                            </div>
                            <c:if test="${restaurant.rating >= 4.5}">
                              <div class="alert alert-warning"
                                style="padding:5px 10px; font-size:0.8rem; margin-bottom:10px;">
                                🔥 Flat 20% OFF on orders above ₹299
                              </div>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/menu?restaurantId=${restaurant.restaurantId}"
                              class="btn btn-primary btn-block">Explore Menu →</a>
                          </div>
                        </div>
                      </div>
                    </c:forEach>
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