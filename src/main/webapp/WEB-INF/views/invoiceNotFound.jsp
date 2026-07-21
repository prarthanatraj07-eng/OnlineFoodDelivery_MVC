<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <title>Invoice Not Found — FoodExpress</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  </head>

  <body>
    <div class="error-page"
      style="min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center; background:#f4f6f8;">
      <span class="error-icon">📄</span>
      <h1>Invoice Not Found</h1>
      <p>The invoice for the requested order does not exist or could not be found.</p>
      <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">← My Orders</a>
    </div>
  </body>

  </html>