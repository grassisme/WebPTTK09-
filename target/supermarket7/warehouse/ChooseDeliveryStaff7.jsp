<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, supermarket7.dao.DeliveryStaffDAO7, supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }
    OnlineOrder7 order = (OnlineOrder7) session.getAttribute("order");
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/warehouse/OrderList7.jsp");
        return;
    }

    List<DeliveryStaff7> listStaff = new DeliveryStaffDAO7().getAvailableStaff();
    // Luu danh sach de doExport7.jsp lay nhan vien da chon
    session.setAttribute("listStaff", listStaff);

    // Thong bao (flash) tu doExport7.jsp (vd: chua chon nhan vien)
    Object message = session.getAttribute("message");
    if (message != null) {
        request.setAttribute("message", message);
        session.removeAttribute("message");
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="order" value="${sessionScope.order}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn nhân viên giao hàng</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Nhân viên kho: <b><c:out value="${sessionScope.staff.fullName}"/></b>
        | <a href="${ctx}/warehouse/WarehouseHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">CHỌN NHÂN VIÊN GIAO HÀNG</h2>
    <p class="center">Đơn hàng <b>#${order.id}</b> - Khách hàng: <b><c:out value="${order.customer.fullName}"/></b>
        - Tổng tiền: <b><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> đ</b></p>

    <c:choose>
        <c:when test="${empty sessionScope.listStaff}">
            <div class="modal-overlay">
                <div class="modal-box">
                    <p>Hiện không có nhân viên giao hàng nào rảnh. Vui lòng xuất đơn sau.</p>
                    <a href="${ctx}/warehouse/OrderList7.jsp" class="btn">OK</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <form method="post" action="${ctx}/warehouse/doExport7.jsp">
                <table id="tblDeliveryStaff" class="data-table">
                    <thead>
                    <tr>
                        <th>Chọn</th>
                        <th>Mã NV</th>
                        <th>Họ tên</th>
                        <th>Khu vực</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="d" items="${sessionScope.listStaff}" varStatus="st">
                        <tr>
                            <td class="center">
                                <input type="radio" name="rdStaff" id="rdStaff${d.id}" value="${d.id}"
                                       ${st.first ? 'required' : ''}>
                            </td>
                            <td class="center"><label for="rdStaff${d.id}">${d.id}</label></td>
                            <td><label for="rdStaff${d.id}"><c:out value="${d.fullName}"/></label></td>
                            <td><c:out value="${d.area}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="actions">
                    <a href="${ctx}/warehouse/OrderDetail7.jsp?id=${order.id}" class="btn">Quay lại</a>
                    <button type="submit" name="btnConfirm" value="1" class="btn">Xác nhận xuất</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
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
