<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <title>Session Expired — FoodExpress</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  </head>

  <body>
    <div
      style="min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center; background:#f4f6f8; padding:24px;">
      <div class="card text-center" style="max-width:440px; width:100%; padding:40px;">
        <div style="font-size:4rem; margin-bottom:16px;">⏱️</div>
        <h2 style="margin-bottom:8px;">Session Expired</h2>
        <p class="text-muted mb-4">Your login session has timed out due to inactivity. Please sign in again to continue.
        </p>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg btn-block">Sign In Again →</a>
      </div>
    </div>
  </body>

  </html>