<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }
    OnlineInvoice7 invoice = (OnlineInvoice7) session.getAttribute("invoice");
    if (invoice == null) {
        response.sendRedirect(request.getContextPath() + "/warehouse/OrderList7.jsp");
        return;
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="invoice" value="${sessionScope.invoice}"/>
<c:set var="order" value="${invoice.order}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hoá đơn bán hàng trực tuyến</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar no-print">
    <span>Nhân viên kho: <b><c:out value="${sessionScope.staff.fullName}"/></b>
        | <a href="${ctx}/warehouse/WarehouseHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container invoice">
    <h2 class="title">HOÁ ĐƠN BÁN HÀNG TRỰC TUYẾN</h2>

    <table class="info-table">
        <tr><th>Mã hoá đơn</th><td>${invoice.id}</td></tr>
        <tr><th>Ngày lập</th><td><fmt:formatDate value="${invoice.invoiceDate}" pattern="dd/MM/yyyy"/></td></tr>
        <tr><th>Mã đơn hàng</th><td>${order.id}</td></tr>
        <tr><th>Khách hàng</th><td><c:out value="${order.customer.fullName}"/></td></tr>
        <tr><th>Địa chỉ giao</th><td><c:out value="${order.deliveryAddress}"/></td></tr>
        <tr><th>Số điện thoại</th><td><c:out value="${order.receiverPhone}"/></td></tr>
        <tr><th>NV kho lập</th><td><c:out value="${invoice.warehouseStaff.fullName}"/></td></tr>
        <tr><th>NV giao hàng</th><td><c:out value="${invoice.deliveryStaff.fullName}"/>
            (<c:out value="${invoice.deliveryStaff.area}"/>)</td></tr>
    </table>

    <table class="data-table">
        <thead>
        <tr>
            <th>TT</th>
            <th>Mặt hàng</th>
            <th>ĐVT</th>
            <th>SL</th>
            <th>Đơn giá (đ)</th>
            <th>Thành tiền (đ)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="line" items="${order.listLine}" varStatus="st">
            <tr>
                <td class="center">${st.count}</td>
                <td><c:out value="${line.item.name}"/></td>
                <td class="center"><c:out value="${line.item.unit}"/></td>
                <td class="center">${line.quantity}</td>
                <td class="right"><fmt:formatNumber value="${line.salePrice}" pattern="#,##0"/></td>
                <td class="right"><fmt:formatNumber value="${line.quantity * line.salePrice}" pattern="#,##0"/></td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="5" class="right"><b>Tổng cộng</b></td>
            <td class="right"><b><fmt:formatNumber value="${invoice.totalAmount}" pattern="#,##0"/></b></td>
        </tr>
        </tbody>
    </table>

    <div class="actions no-print">
        <button type="button" class="btn" onclick="printInvoice()">In hoá đơn</button>
        <a href="${ctx}/warehouse/OrderList7.jsp" class="btn">Về danh sách đơn</a>
    </div>
</div>

<div class="modal-overlay no-print" id="msgBox" style="display:none;">
    <div class="modal-box">
        <p>Xuất hàng thành công</p>
        <button type="button" class="btn" onclick="document.getElementById('msgBox').style.display='none';">OK</button>
    </div>
</div>

<script>
    function printInvoice() {
        window.print();
        document.getElementById('msgBox').style.display = 'flex';
    }
</script>
</body>
</html>
