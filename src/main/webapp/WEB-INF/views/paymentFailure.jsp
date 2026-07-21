<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Payment Failed — FoodExpress</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body
      style="background:#fef2f2; min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center; padding:24px;">

      <div class="card text-center" style="max-width:460px; width:100%; padding:40px;">
        <div style="font-size:5rem; margin-bottom:16px;">❌</div>
        <h2 class="text-danger" style="margin-bottom:8px;">Payment Failed</h2>
        <p class="text-muted" style="font-size:1rem; margin-bottom:8px;">Something went wrong with your payment.</p>
        <p class="text-muted mb-4">Please check your payment details and try again.</p>
        <div style="display:flex; flex-direction:column; gap:10px;">
          <a href="${pageContext.request.contextPath}/payment?orderId=${order.orderId}" class="btn btn-orange btn-lg">
            🔄 Retry Payment
          </a>
          <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline btn-lg">
            📦 Go to My Orders
          </a>
        </div>
      </div>

    </body>

    </html>