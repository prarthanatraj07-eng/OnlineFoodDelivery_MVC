<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Admin Login — FoodExpress</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body class="auth-page">

      <div style="width:100%; max-width:1100px; margin:0 auto;">
        <div class="auth-nav">
          <span class="brand" style="color:#e74c3c;">🛡️ FoodExpress Admin</span>
          <a href="${pageContext.request.contextPath}/login" class="btn btn-outline"
            style="color:#fff; border-color:rgba(255,255,255,.5);">Customer Login</a>
        </div>
      </div>

      <div class="auth-card">
        <div class="auth-logo">🛡️</div>
        <h1 class="auth-title" style="color:#e74c3c;">Admin Login</h1>
        <p class="auth-sub">Restricted access — authorized personnel only</p>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">⚠️
            <c:out value="${error}" />
          </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/login" id="adminLoginForm">
          <div class="form-group">
            <label for="email">📧 Admin Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="admin@example.com" required>
          </div>
          <div class="form-group">
            <label for="password">🔒 Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
          </div>
          <button type="submit" class="btn btn-danger btn-block" style="margin-top:8px; background:#e74c3c;">
            Login as Admin →
          </button>
        </form>

        <hr>
        <p class="text-center mb-0">
          <a href="${pageContext.request.contextPath}/login" class="text-muted small">← Back to main site</a>
        </p>
      </div>

    </body>

    </html>