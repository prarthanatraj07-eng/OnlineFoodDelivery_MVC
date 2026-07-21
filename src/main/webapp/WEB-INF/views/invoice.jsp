<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TAX INVOICE #${not empty order ? order.orderId : ''} — FoodExpress</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
      </head>

      <body style="background:#f8f9fa;">

        <div class="print-actions no-print" style="text-align:center; padding:20px;">
          <p class="text-muted small mb-2">Use your browser's <strong>Ctrl+P</strong> (or Cmd+P on Mac) to print or save
            as PDF.</p>
          <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary btn-sm">← My Orders</a>
        </div>

        <div class="invoice-box">

          <%-- Header --%>
            <div class="invoice-header">
              <div>
                <h2 style="font-family:'Courier New',monospace; font-weight:700; font-size:1.1rem; margin-bottom:4px;">
                  FOOD EXPRESS LTD</h2>
                <p style="margin:2px 0; font-size:0.83rem;">HQ: MG Road, Bangalore - 560001</p>
                <p style="margin:2px 0; font-size:0.83rem;">GSTIN: 29AAAAA0000A1Z5</p>
                <p style="margin:2px 0; font-size:0.83rem;">Support: care@foodexpress.in | 1800-123-456</p>
              </div>
              <div style="text-align:right;">
                <div class="invoice-title">TAX INVOICE</div>
                <p style="margin:4px 0; font-weight:700; font-size:0.88rem;">Order Ref: #${not empty order ?
                  order.orderId : ''}</p>
                <p style="margin:2px 0; font-size:0.82rem;">Date:
                  <c:if test="${not empty order && not empty order.createdAt}">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm:ss" />
                  </c:if>
                </p>
              </div>
            </div>

            <%-- Billed To / Fulfilled By --%>
              <table
                style="width:100%; border-top:1px solid #aaa; border-bottom:1px solid #aaa; padding:10px 0; margin-bottom:14px;">
                <tr>
                  <td style="padding:10px 0; vertical-align:top; width:50%;">
                    <p
                      style="font-size:0.78rem; font-weight:700; text-transform:uppercase; color:#666; margin-bottom:4px;">
                      Billed To (Customer):</p>
                    <p style="font-weight:700; margin-bottom:2px;">${not empty user ? user.fullName : 'Valued Customer'}
                    </p>
                    <p style="font-size:0.82rem; margin-bottom:2px;">${not empty order ? order.deliveryAddress : ''}</p>
                    <p style="font-size:0.82rem; margin-bottom:0;">Phone: ${not empty user ? user.phone : ''}</p>
                  </td>
                  <td style="padding:10px 0; vertical-align:top; text-align:right;">
                    <p
                      style="font-size:0.78rem; font-weight:700; text-transform:uppercase; color:#666; margin-bottom:4px;">
                      Fulfilled By (Restaurant):</p>
                    <c:if test="${not empty restaurant}">
                      <p style="font-weight:700; margin-bottom:2px;">${restaurant.name}</p>
                      <p style="font-size:0.82rem; margin-bottom:2px;">${restaurant.address}</p>
                      <p style="font-size:0.82rem; margin-bottom:0;">Phone: ${restaurant.phone}</p>
                    </c:if>
                    <c:if test="${empty restaurant}">
                      <p style="font-weight:700;">Partner Kitchen Outlet</p>
                    </c:if>
                  </td>
                </tr>
              </table>

              <%-- Items Table --%>
                <table class="invoice-table">
                  <thead>
                    <tr>
                      <th style="text-align:center;">#</th>
                      <th>Dish Description</th>
                      <th style="text-align:center;">Unit Price</th>
                      <th style="text-align:center;">Qty</th>
                      <th style="text-align:right;">Net Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:set var="subtot" value="0" />
                    <c:if test="${not empty orderItems}">
                      <c:forEach var="item" items="${orderItems}" varStatus="loop">
                        <c:set var="subtot" value="${subtot + item.itemTotal}" />
                        <tr>
                          <td style="text-align:center;">${loop.count}</td>
                          <td>
                            <strong>${not empty item.food ? item.food.name : 'Delicacy Dish Item'}</strong>
                            <span style="font-size:0.78rem; display:block; color:#666;">
                              (${not empty item.food && item.food.veg ? 'Pure Veg' : 'Non-Veg'})
                            </span>
                          </td>
                          <td style="text-align:center;">₹
                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" />
                          </td>
                          <td style="text-align:center;">${item.quantity}</td>
                          <td style="text-align:right; font-weight:700;">₹
                            <fmt:formatNumber value="${item.itemTotal}" pattern="#,##0.00" />
                          </td>
                        </tr>
                      </c:forEach>
                    </c:if>
                  </tbody>
                </table>

                <%-- Totals --%>
                  <div style="display:flex; justify-content:flex-end; margin-bottom:16px;">
                    <table class="invoice-totals-table" style="width:320px;">
                      <tr>
                        <td>Item Subtotal:</td>
                        <td style="text-align:right; font-weight:700;">₹
                          <fmt:formatNumber value="${subtot}" pattern="#,##0.00" />
                        </td>
                      </tr>
                      <tr>
                        <td>GST / Taxes (5%):</td>
                        <td style="text-align:right; font-weight:700;">₹
                          <fmt:formatNumber value="${not empty order ? order.gstAmount : 0}" pattern="#,##0.00" />
                        </td>
                      </tr>
                      <tr>
                        <td>Platform Fee:</td>
                        <td style="text-align:right; font-weight:700;">₹
                          <fmt:formatNumber value="${not empty order ? order.platformFee : 0}" pattern="#,##0.00" />
                        </td>
                      </tr>
                      <tr>
                        <td>Delivery Charge:</td>
                        <td style="text-align:right; font-weight:700;">₹
                          <fmt:formatNumber value="${not empty order ? order.deliveryFee : 0}" pattern="#,##0.00" />
                        </td>
                      </tr>
                      <c:if test="${not empty order && order.discountAmount > 0}">
                        <tr style="color:#27ae60;">
                          <td>Coupon Discount (${order.couponCode}):</td>
                          <td style="text-align:right; font-weight:700;">−₹
                            <fmt:formatNumber value="${order.discountAmount}" pattern="#,##0.00" />
                          </td>
                        </tr>
                      </c:if>
                      <tr class="grand-total">
                        <td>TOTAL AMOUNT PAID:</td>
                        <td style="text-align:right;">₹
                          <fmt:formatNumber value="${not empty order ? order.totalAmount : 0}" pattern="#,##0.00" />
                        </td>
                      </tr>
                    </table>
                  </div>

                  <%-- Payment Info --%>
                    <div
                      style="border:1px solid #ddd; border-radius:4px; padding:10px 14px; background:#f9f9f9; font-size:0.82rem; display:flex; justify-content:space-between; flex-wrap:wrap; gap:8px; margin-bottom:16px;">
                      <div>
                        <strong>Payment Mode:</strong>
                        ${not empty order && not empty order.paymentMethod ? order.paymentMethod : (not empty payment ?
                        payment.paymentMethod : 'COD')}
                        &nbsp;|&nbsp;
                        <strong>Status:</strong>
                        ${not empty payment && not empty payment.status ? payment.status : 'COMPLETED'}
                      </div>
                      <c:if test="${not empty payment && not empty payment.transactionId}">
                        <div><strong>Bank Trans Ref:</strong> <span
                            style="font-family:'Courier New',monospace;">${payment.transactionId}</span></div>
                      </c:if>
                    </div>

                    <%-- Footer --%>
                      <div
                        style="text-align:center; border-top:1px solid #ddd; padding-top:12px; font-size:0.8rem; color:#666;">
                        <p style="margin:0;">Thank you for dining with FoodExpress! This is a computer-generated tax
                          invoice.</p>
                      </div>

        </div>

      </body>

      </html>