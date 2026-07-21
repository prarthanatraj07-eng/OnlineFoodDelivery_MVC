<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Successful — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body
        style="background:#f0fdf4; min-height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center; padding:24px;">

        <div class="card text-center" style="max-width:460px; width:100%; padding:40px;">
          <div style="font-size:5rem; margin-bottom:16px;">✅</div>
          <h2 style="color:#27ae60; margin-bottom:8px;">Payment Successful!</h2>
          <p class="text-muted" style="font-size:1rem; margin-bottom:8px;">Your order has been placed successfully.</p>
          <div
            style="background:#2C3E50; color:#fff; border-radius:20px; padding:6px 20px; display:inline-block; margin-bottom:16px; font-weight:700;">
            Order #
            <c:out value="${order.orderId}" />
          </div>
          <p class="text-muted mb-4">
            We're preparing your food and will deliver it soon! 🚀<br>
            <small>You'll receive your order at the provided address.</small>
          </p>
          <div style="display:flex; flex-direction:column; gap:10px;">
            <a href="${pageContext.request.contextPath}/trackOrder?orderId=${order.orderId}"
              class="btn btn-orange btn-lg">
              📍 Track My Order
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline btn-lg">
              ← Continue Shopping
            </a>
          </div>
        </div>

      </body>

      </html>