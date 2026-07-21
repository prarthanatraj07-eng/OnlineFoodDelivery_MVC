<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <title>Page Not Found (404) — FoodExpress</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  </head>

  <body style="background:#f4f6f8;">
    <div class="error-page"
      style="min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center;">
      <span class="error-icon">🛸</span>
      <h1>404 — Page Not Found</h1>
      <p>Oops! It seems the page you were looking for has been moved or eaten by our chefs.</p>
      <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">🏠 Return to Homepage</a>
    </div>
  </body>

  </html>