<%-- Customer Navbar Partial — included in all customer-facing pages --%>
<%
  String reqUri = request.getRequestURI();
  boolean isHome   = reqUri.endsWith("/home") || reqUri.endsWith("/");
  boolean isCart   = reqUri.endsWith("/cart");
  boolean isOrders = reqUri.endsWith("/orders");
  boolean isRest   = reqUri.contains("/restaurants") || reqUri.contains("/menu") || reqUri.contains("/search");
%>
<nav class="main-nav">
  <div class="nav-inner">
    <a class="nav-brand" href="${pageContext.request.contextPath}/home">🍔 FoodExpress</a>

    <%-- Search Form --%>
    <form class="nav-search" method="get" action="${pageContext.request.contextPath}/search">
      <input type="search" name="keyword" placeholder="Search food or restaurants..."
             value="${not empty keyword ? keyword : ''}" aria-label="Search">
      <button type="submit">🔍</button>
    </form>

    <%-- Navigation Links --%>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/home"        class="<%= isHome   ? "active" : "" %>">🏠 Home</a>
      <a href="${pageContext.request.contextPath}/restaurants" class="<%= isRest   ? "active" : "" %>">🏪 Restaurants</a>
      <a href="${pageContext.request.contextPath}/cart"        class="<%= isCart   ? "active" : "" %>">
        🛒 Cart <span class="cart-count">${not empty cartCount ? cartCount : 0}</span>
      </a>
      <a href="${pageContext.request.contextPath}/orders"      class="<%= isOrders ? "active" : "" %>">📦 My Orders</a>
      <span style="color:#aaa;">👤 ${sessionScope.loggedUser.fullName}</span>
      <a href="${pageContext.request.contextPath}/logout" class="logout-link">🚪 Logout</a>
    </div>
  </div>
</nav>
