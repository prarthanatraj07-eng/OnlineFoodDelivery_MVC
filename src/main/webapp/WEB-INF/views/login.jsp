<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login — FoodExpress</title>
  <meta name="description" content="Sign in to FoodExpress — the fastest food delivery platform.">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="auth-page">

  <div style="width:100%; max-width:1100px; margin:0 auto;">
    <div class="auth-nav">
      <span class="brand">🍔 FoodExpress</span>
      <a href="${pageContext.request.contextPath}/register" class="btn btn-outline" style="color:#fff; border-color:rgba(255,255,255,.5);">Register</a>
    </div>
  </div>

  <div class="auth-card">
    <div class="auth-logo">🍔</div>
    <h1 class="auth-title">Welcome Back</h1>
    <p class="auth-sub">Sign in to continue your food journey</p>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">⚠️ <c:out value="${error}"/></div>
    </c:if>
    <c:if test="${not empty success}">
      <div class="alert alert-success">✅ <c:out value="${success}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm">
      <div class="form-group">
        <label for="email">📧 Email Address</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
      </div>
      <div class="form-group">
        <label for="password">🔒 Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Your password" required>
      </div>
      <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px;">Sign In →</button>
    </form>

    <hr>
    <p class="text-center text-muted mb-0">
      Don't have an account?
      <a href="${pageContext.request.contextPath}/register" style="color:#FF6B35; font-weight:600;">Register here</a>
    </p>
  </div>

  <p style="color:rgba(255,255,255,.45); font-size:0.82rem; margin-top:20px; text-align:center;">
    © <%= java.time.Year.now() %> FoodExpress
  </p>

</body>
</html>