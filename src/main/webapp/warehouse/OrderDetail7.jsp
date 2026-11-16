<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, supermarket7.dao.*, supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    int idOrder;
    try {
        idOrder = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/warehouse/OrderList7.jsp");
        return;
    }

    // Lay thong tin chung cua don tu danh sach da hien thi o OrderList7.jsp
    OnlineOrder7 order = null;
    List<OnlineOrder7> listOrder = (List<OnlineOrder7>) session.getAttribute("listOrder");
    if (listOrder != null) {
        for (OnlineOrder7 o : listOrder) {
            if (o.getId() == idOrder) {
                order = o;
                break;
            }
        }
    }
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/warehouse/OrderList7.jsp");
        return;
    }

    // Lay cac dong cua don + tinh tong tien
    List<OrderLine7> listLine = new OrderLineDAO7().getOrderLineByOrder(idOrder);
    float total = 0;
    for (OrderLine7 line : listLine) {
        total += line.getQuantity() * line.getSalePrice();
    }
    order.setListLine(listLine);
    order.setTotalAmount(total);
    session.setAttribute("order", order);

    // Nhan nut Xuat hang (submit ve chinh trang nay)
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("btnExport") != null) {
        boolean enough = new ItemDAO7().checkStock(order.getListLine());
        if (enough) {
            response.sendRedirect(request.getContextPath() + "/warehouse/ChooseDeliveryStaff7.jsp");
            return;
        }
        List<OrderLine7> shortLines = new ArrayList<>();
        for (OrderLine7 line : order.getListLine()) {
            if (line.getQuantity() > line.getItem().getQuantityInStock()) {
                shortLines.add(line);
            }
        }
        request.setAttribute("shortLines", shortLines);
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="order" value="${sessionScope.order}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Nhân viên kho: <b><c:out value="${sessionScope.staff.fullName}"/></b>
        | <a href="${ctx}/warehouse/WarehouseHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">CHI TIẾT ĐƠN HÀNG</h2>

    <table class="info-table">
        <tr><th>Mã đơn</th><td>${order.id}</td></tr>
        <tr><th>Ngày đặt</th><td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td></tr>
        <tr><th>Khách hàng</th><td><c:out value="${order.customer.fullName}"/></td></tr>
        <tr><th>Điện thoại nhận</th><td><c:out value="${order.receiverPhone}"/></td></tr>
        <tr><th>Địa chỉ giao</th><td><c:out value="${order.deliveryAddress}"/></td></tr>
        <tr><th>Thanh toán</th><td><c:out value="${order.paymentMethod}"/></td></tr>
    </table>

    <table id="tblOrderLine" class="data-table">
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
            <tr class="${not empty shortLines and line.quantity > line.item.quantityInStock ? 'row-bad' : ''}">
                <td class="center">${st.count}</td>
                <td><c:out value="${line.item.name}"/></td>
                <td class="center"><c:out value="${line.item.unit}"/></td>
                <td class="center">${line.quantity}</td>
                <td class="right"><fmt:formatNumber value="${line.salePrice}" pattern="#,##0"/></td>
                <td class="right"><fmt:formatNumber value="${line.quantity * line.salePrice}" pattern="#,##0"/></td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="5" class="right"><b>Tổng tiền</b></td>
            <td class="right"><b><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/></b></td>
        </tr>
        </tbody>
    </table>

    <div class="actions">
        <a href="${ctx}/warehouse/OrderList7.jsp" class="btn">Quay lại</a>
        <form method="post" action="${ctx}/warehouse/OrderDetail7.jsp?id=${order.id}" class="inline">
            <button type="submit" name="btnExport" value="1" class="btn">Xuất hàng</button>
        </form>
    </div>
</div>

<c:if test="${not empty shortLines}">
    <div class="modal-overlay" id="msgBox">
        <div class="modal-box">
            <p><b>Không đủ hàng trong kho để xuất đơn này!</b></p>
            <ul class="left">
                <c:forEach var="line" items="${shortLines}">
                    <li><c:out value="${line.item.name}"/>: cần ${line.quantity},
                        tồn kho chỉ còn ${line.item.quantityInStock}</li>
                </c:forEach>
            </ul>
            <button type="button" class="btn" onclick="document.getElementById('msgBox').style.display='none';">OK</button>
        </div>
    </div>
</c:if>
</body>
</html>
