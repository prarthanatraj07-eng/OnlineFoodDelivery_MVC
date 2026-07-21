<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f4f6f8; display:flex; flex-direction:column; min-height:100vh;">
        <%@ include file="/WEB-INF/views/common/adminNavbar.jsp" %>

          <div class="main-content" style="background:#f4f6f8;">
            <div class="container-fluid">

              <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <h3 class="section-header" style="margin-bottom:0;">📊 Executive Analytics Overview</h3>
                <span class="badge badge-dark" style="font-size:0.88rem; padding:6px 12px;">
                  📅 Today: <%= java.time.LocalDate.now() %>
                </span>
              </div>

              <%-- Stat Cards --%>
                <div class="stat-cards-row">
                  <div class="stat-card stat-orange">
                    <h2>₹
                      <fmt:formatNumber value="${todayRevenue}" pattern="#,##0" />
                    </h2>
                    <p>💰 Today's Gross Revenue</p>
                  </div>
                  <div class="stat-card stat-blue">
                    <h2>${todayOrders}</h2>
                    <p>🛒 Today's Orders</p>
                  </div>
                  <div class="stat-card stat-green">
                    <h2>${activeOutlets} <small style="font-size:1rem;">/ ${restaurantCount}</small></h2>
                    <p>🟢 Active Kitchen Outlets</p>
                  </div>
                  <div class="stat-card stat-purple">
                    <h2>${totalUsers}</h2>
                    <p>👥 Registered Customers</p>
                  </div>
                </div>

                <%-- Order Status Breakdown + Bestseller --%>
                  <div class="row mb-4">
                    <div class="col-7">
                      <div class="card" style="margin-bottom:0; height:100%;">
                        <div class="card-header">📈 Order Status Breakdown (All Time)</div>
                        <div class="breakdown-grid">
                          <div class="breakdown-cell" style="background:#f0f0f0;">
                            <h3 style="color:#555;">${placedCount}</h3>
                            <span style="color:#777; font-size:0.78rem; text-transform:uppercase; font-weight:700;">New
                              / Placed</span>
                          </div>
                          <div class="breakdown-cell" style="background:#fef9e7;">
                            <h3 style="color:#7d6608;">${preparingCount}</h3>
                            <span
                              style="color:#7d6608; font-size:0.78rem; text-transform:uppercase; font-weight:700;">In
                              Kitchen</span>
                          </div>
                          <div class="breakdown-cell" style="background:#eafaf1;">
                            <h3 style="color:#186a3b;">${deliveredCount}</h3>
                            <span
                              style="color:#186a3b; font-size:0.78rem; text-transform:uppercase; font-weight:700;">Delivered</span>
                          </div>
                          <div class="breakdown-cell" style="background:#fdecea;">
                            <h3 style="color:#922b21;">${cancelledCount}</h3>
                            <span
                              style="color:#922b21; font-size:0.78rem; text-transform:uppercase; font-weight:700;">Cancelled</span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-5">
                      <div class="stat-card stat-dark" style="height:100%; margin-bottom:0;">
                        <span class="badge badge-warning" style="margin-bottom:8px; display:inline-block;">🏆 #1
                          BESTSELLER</span>
                        <h2 style="font-size:1.4rem; color:#F7C948; margin-bottom:8px;">${topSellingDish}</h2>
                        <p style="font-size:0.82rem; margin:0;">Most ordered delicacy across all outlets on the
                          FoodExpress platform.</p>
                      </div>
                    </div>
                  </div>

                  <%-- Quick Action Cards --%>
                    <h5 class="section-header">⚡ Admin Operations Portal</h5>
                    <div class="admin-action-cards">
                      <a href="${pageContext.request.contextPath}/admin/restaurant" class="admin-action-card">
                        <span class="action-icon">🏪</span>
                        <h5>Manage Restaurants</h5>
                        <p>Configure store timing, minimum order limit, banners, and active status.</p>
                        <span class="open-link">Open Portal →</span>
                      </a>
                      <a href="${pageContext.request.contextPath}/admin/food" class="admin-action-card">
                        <span class="action-icon">🍕</span>
                        <h5>Manage Dishes &amp; Menus</h5>
                        <p>Add new delicacies, update prices, manage stock availability, and categorize.</p>
                        <span class="open-link">Open Portal →</span>
                      </a>
                      <a href="${pageContext.request.contextPath}/admin/orders" class="admin-action-card">
                        <span class="action-icon">📦</span>
                        <h5>Live Orders Console</h5>
                        <p>Real-time lifecycle control: Accept, Reject, Kitchen Prep, Assign, Deliver.</p>
                        <span class="open-link">Open Console →</span>
                      </a>
                    </div>

            </div>
          </div>

          <footer class="main-footer">
            <p class="mb-0">© <%= java.time.Year.now() %> FoodExpress</p>
          </footer>
      </body>

      </html>