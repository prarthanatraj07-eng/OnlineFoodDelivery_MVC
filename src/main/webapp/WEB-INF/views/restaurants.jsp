<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Restaurants — FoodExpress</title>
        <meta name="description" content="Browse all restaurants and search for your favourite food.">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body>
        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

          <div class="page-header">
            <div class="container">
              <c:choose>
                <c:when test="${not empty keyword}">
                  <h1>🔍 Search results for: "
                    <c:out value="${keyword}" />"
                  </h1>
                </c:when>
                <c:otherwise>
                  <h1>🏪 All Restaurant Outlets</h1>
                  <p>Discover top rated culinary destinations near your location</p>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="main-content">
            <div class="container">

              <%--===== SEARCH RESULTS VIEW=====-%>
                <c:if test="${not empty keyword}">
                  <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-outline search-back-link">←
                    Back to All Outlets</a>

                  <c:choose>
                    <c:when test="${empty searchResults}">
                      <div class="empty-state">
                        <span class="empty-icon">😕</span>
                        <h3>No Results for "
                          <c:out value="${keyword}" />"
                        </h3>
                        <p>Try searching for generic terms like Burger, Pizza, Biryani, or Noodles.</p>
                        <a href="${pageContext.request.contextPath}/restaurants" class="btn btn-primary">🏪 View All
                          Outlets</a>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                        <h3 class="section-header" style="margin-bottom:0;">Found ${searchResults.size()} Food Item(s)
                        </h3>
                      </div>
                      <div class="food-grid">
                        <c:forEach var="food" items="${searchResults}">
                          <div class="food-card">
                            <div class="card">
                              <div>
                                <div
                                  style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:6px;">
                                  <h5 class="card-title">${food.name}</h5>
                                  <span class="badge ${food.veg ? 'badge-success' : 'badge-danger'}">
                                    ${food.veg ? '🟢 VEG' : '🔴 NON-VEG'}
                                  </span>
                                </div>
                                <span class="badge badge-warning mb-2">${food.category}</span>
                                <p class="small text-muted">${food.description}</p>
                              </div>
                              <div class="border-top pt-3"
                                style="display:flex; justify-content:space-between; align-items:center;">
                                <span class="fw-bold text-dark">₹
                                  <fmt:formatNumber value="${food.price}" pattern="#,##0.00" />
                                </span>
                                <a href="${pageContext.request.contextPath}/menu?restaurantId=${food.restaurantId}"
                                  class="btn btn-sm btn-primary">View Store →</a>
                              </div>
                            </div>
                          </div>
                        </c:forEach>
                      </div>
                    </c:otherwise>
                  </c:choose>
                </c:if>

                <%--===== RESTAURANT LISTING VIEW (no search)=====-%>
                  <c:if test="${empty keyword}">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                      <h3 class="section-header" style="margin-bottom:0;">All Outlets</h3>
                      <span class="badge badge-secondary">
                        ${not empty restaurants ? restaurants.size() : 0} Outlets
                      </span>
                    </div>

                    <c:choose>
                      <c:when test="${empty restaurants}">
                        <div class="empty-state">
                          <span class="empty-icon">🍽️</span>
                          <h3>No Restaurants Available Right Now</h3>
                          <p>Please check back later!</p>
                          <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">🏠 Go Home</a>
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
                                        <c:when test="${restaurant.deliveryFee == 0}"><span
                                            class="text-success fw-bold">Free</span></c:when>
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
                  </c:if>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>