<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <title>Server Error (500) — FoodExpress</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  </head>

  <body style="background:#f4f6f8;">
    <div class="error-page"
      style="min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center;">
      <span class="error-icon">🔥</span>
      <h1>500 — Kitchen Overload!</h1>
      <p>Our master chefs encountered an unexpected issue preparing this request. We are fixing it right now!</p>
      <a href="${pageContext.request.contextPath}/home" class="btn btn-danger btn-lg">🔄 Try Homepage Again</a>
    </div>
  </body>

  </html>