<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, supermarket7.dao.OnlineOrderDAO7, supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    List<OnlineOrder7> listOrder = new OnlineOrderDAO7().getUnexportedOrder();
    // Luu danh sach de OrderDetail7.jsp lay thong tin chung cua don da chon
    session.setAttribute("listOrder", listOrder);

    // Thong bao (flash) tu doExport7.jsp / ChooseDeliveryStaff7.jsp
    Object message = session.getAttribute("message");
    if (message != null) {
        request.setAttribute("message", message);
        session.removeAttribute("message");
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng chưa xuất</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Nhân viên kho: <b><c:out value="${sessionScope.staff.fullName}"/></b>
        | <a href="${ctx}/warehouse/WarehouseHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">DANH SÁCH ĐƠN HÀNG CHƯA XUẤT</h2>

    <c:choose>
        <c:when test="${empty sessionScope.listOrder}">
            <div class="message">Hiện không có đơn hàng nào cần xuất</div>
        </c:when>
        <c:otherwise>
            <table id="tblOrder" class="data-table">
                <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Khách hàng</th>
                    <th>Điện thoại</th>
                    <th>Địa chỉ giao</th>
                    <th>Tổng tiền (đ)</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${sessionScope.listOrder}" varStatus="st">
                    <tr>
                        <td class="center">${st.count}</td>
                        <td class="center">${o.id}</td>
                        <td class="center"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/></td>
                        <td><c:out value="${o.customer.fullName}"/></td>
                        <td class="center"><c:out value="${o.receiverPhone}"/></td>
                        <td><c:out value="${o.deliveryAddress}"/></td>
                        <td class="right"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/></td>
                        <td class="center"><a href="${ctx}/warehouse/OrderDetail7.jsp?id=${o.id}">Chọn</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <div class="actions">
        <a href="${ctx}/warehouse/WarehouseHome7.jsp" class="btn">Quay lại</a>
    </div>
</div>

<c:if test="${not empty message}">
    <div class="modal-overlay" id="msgBox">
        <div class="modal-box">
            <p><c:out value="${message}"/></p>
            <button type="button" class="btn" onclick="document.getElementById('msgBox').style.display='none';">OK</button>
        </div>
    </div>
</c:if>
</body>
</html>
