<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <% Object loggedUser=session.getAttribute("loggedUser"); if (loggedUser !=null) {
      response.sendRedirect(request.getContextPath() + "/home" ); return; } %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description"
          content="FoodExpress — Order from the best restaurants near you. Fast delivery, easy payment, wide selection.">
        <title>FoodExpress 🍔 — Hungry? We've Got You Covered.</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f4f6f8;">

        <%-- Top nav for landing page --%>
          <nav style="background:#2C3E50; padding:12px 20px;">
            <div
              style="display:flex; justify-content:space-between; align-items:center; max-width:1100px; margin:0 auto;">
              <span style="color:#fff; font-size:1.2rem; font-weight:700;">🍔 FoodExpress</span>
              <div style="display:flex; gap:10px;">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline"
                  style="color:#fff; border-color:rgba(255,255,255,.6);">Sign In</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-orange">Register</a>
              </div>
            </div>
          </nav>

          <%-- Hero Section --%>
            <section class="hero-section">
              <span class="hero-emoji">🍔</span>
              <h1>Hungry? We've Got You Covered.</h1>
              <p>Order from the best restaurants near you. Fresh food delivered to your doorstep in minutes.</p>
              <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">🍕 Order Now</a>
                <a href="${pageContext.request.contextPath}/login" class="btn-hero-outline">Sign In →</a>
              </div>
            </section>

            <%-- Stats Bar --%>
              <section class="stats-bar">
                <div class="stats-grid">
                  <div class="stat-item"><span class="stat-num">500+</span>
                    <div class="stat-lbl">Restaurants</div>
                  </div>
                  <div class="stat-item"><span class="stat-num">50K+</span>
                    <div class="stat-lbl">Happy Customers</div>
                  </div>
                  <div class="stat-item"><span class="stat-num">30 min</span>
                    <div class="stat-lbl">Avg Delivery Time</div>
                  </div>
                  <div class="stat-item"><span class="stat-num">4.8 ⭐</span>
                    <div class="stat-lbl">Average Rating</div>
                  </div>
                </div>
              </section>

              <%-- Features Section --%>
                <section class="features-section">
                  <div class="container">
                    <h2>Why Choose FoodExpress?</h2>
                    <p>Everything you need for a perfect meal experience</p>
                    <div class="features-grid">
                      <div class="feature-card">
                        <span class="feat-icon">🍕</span>
                        <h4>Wide Selection</h4>
                        <p>Browse hundreds of dishes from top-rated restaurants — all in one place.</p>
                      </div>
                      <div class="feature-card">
                        <span class="feat-icon">⚡</span>
                        <h4>Fast Delivery</h4>
                        <p>Hot and fresh food delivered straight to your doorstep in minutes.</p>
                      </div>
                      <div class="feature-card">
                        <span class="feat-icon">💳</span>
                        <h4>Easy Payment</h4>
                        <p>Pay your way — Cash on Delivery, UPI, or Card. Secure checkout.</p>
                      </div>
                    </div>
                  </div>
                </section>

                <footer class="main-footer">
                  <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
                </footer>

      </body>

      </html>