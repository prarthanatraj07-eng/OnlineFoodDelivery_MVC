<%-- Admin Navbar Partial — included in all admin pages --%>
  <% String admUri=request.getRequestURI(); boolean isDash=admUri.endsWith("/admin/dashboard"); boolean
    isRest=admUri.contains("/admin/restaurant"); boolean isFood=admUri.contains("/admin/food"); boolean
    isAdmOrd=admUri.contains("/admin/orders"); %>
    <nav class="admin-nav">
      <div class="nav-inner">
        <a class="nav-brand" href="${pageContext.request.contextPath}/admin/dashboard">
          🍔 FoodExpress <span class="admin-badge">ADMIN</span>
        </a>
        <div class="nav-links">
          <a href="${pageContext.request.contextPath}/admin/dashboard" class="<%= isDash   ? " active" : "" %>">📊
            Dashboard</a>
          <a href="${pageContext.request.contextPath}/admin/restaurant" class="<%= isRest  ? " active" : "" %>">🏪
            Restaurants</a>
          <a href="${pageContext.request.contextPath}/admin/food" class="<%= isFood   ? " active" : "" %>">🍕 Foods</a>
          <a href="${pageContext.request.contextPath}/admin/orders" class="<%= isAdmOrd ? " active" : "" %>">📦
            Orders</a>
          <span style="color:#aaa;">👑 ${sessionScope.loggedUser.fullName}</span>
          <a href="${pageContext.request.contextPath}/logout" class="logout-link">🚪 Logout</a>
        </div>
      </div>
    </nav>