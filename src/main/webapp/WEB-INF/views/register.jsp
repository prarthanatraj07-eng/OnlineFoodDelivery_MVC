<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Register — FoodExpress</title>
      <meta name="description" content="Create your FoodExpress account and start ordering delicious food.">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body class="auth-page">

      <div style="width:100%; max-width:1100px; margin:0 auto;">
        <div class="auth-nav">
          <span class="brand">🍔 FoodExpress</span>
          <a href="${pageContext.request.contextPath}/login" class="btn btn-outline"
            style="color:#fff; border-color:rgba(255,255,255,.5);">Login</a>
        </div>
      </div>

      <div class="auth-card auth-card-wide">
        <div class="auth-logo">🍔</div>
        <h1 class="auth-title">Create Account</h1>
        <p class="auth-sub">Join FoodExpress and enjoy great food!</p>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">⚠️
            <c:out value="${error}" />
          </div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">✅
            <c:out value="${success}" />
          </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register" id="registerForm">

          <div class="section-divider">Account Details</div>

          <div class="form-group">
            <label for="fullName">👤 Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Your full name" required>
          </div>
          <div class="form-group">
            <label for="email">📧 Email Address</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="password">🔒 Password</label>
              <input type="password" class="form-control" id="password" name="password" placeholder="Min 6 characters"
                required minlength="6">
            </div>
            <div class="form-group">
              <label for="confirmPassword">🔒 Confirm Password</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                placeholder="Repeat password" required>
            </div>
          </div>
          <div class="form-text mb-3">Minimum 6 characters.</div>

          <div class="section-divider">Contact Details</div>

          <div class="form-group">
            <label for="phone">📞 Phone Number</label>
            <input type="tel" class="form-control" id="phone" name="phone" placeholder="e.g. 9876543210">
          </div>
          <div class="form-group">
            <label for="address">📍 Delivery Address</label>
            <textarea class="form-control" id="address" name="address" placeholder="House No, Street, City..."
              style="height:80px;"></textarea>
          </div>

          <button type="submit" class="btn btn-orange btn-block">Create Account 🚀</button>
        </form>

        <hr>
        <p class="text-center text-muted mb-0">
          Already have an account?
          <a href="${pageContext.request.contextPath}/login" style="color:#FF6B35; font-weight:600;">Login here</a>
        </p>
      </div>

      <p style="color:rgba(255,255,255,.45); font-size:0.82rem; margin-top:20px; text-align:center;">
        © <%= java.time.Year.now() %> FoodExpress
      </p>

    </body>

    </html>