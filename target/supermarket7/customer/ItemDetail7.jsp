<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.dao.ItemDAO7, supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    int idItem;
    try {
        idItem = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/customer/SearchItem7.jsp");
        return;
    }

    Item7 item = new ItemDAO7().getItemDetail(idItem);
    if (item == null) {
        response.sendRedirect(request.getContextPath() + "/customer/SearchItem7.jsp");
        return;
    }
    // Luu mat hang dang xem de doAddToCart7.jsp su dung
    session.setAttribute("item", item);

    // Thong bao (flash) tu doAddToCart7.jsp
    Object message = session.getAttribute("message");
    if (message != null) {
        request.setAttribute("message", message);
        session.removeAttribute("message");
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="item" value="${sessionScope.item}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết mặt hàng</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Khách hàng: <b><c:out value="${sessionScope.customer.fullName}"/></b>
        | <a href="${ctx}/customer/CustomerHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">CHI TIẾT MẶT HÀNG</h2>

    <div class="detail">
        <div class="detail-image">
            <img src="${ctx}/images/<c:out value='${item.image}'/>" alt="<c:out value='${item.name}'/>"
                 onerror="this.onerror=null;this.src='${ctx}/images/no-image.svg';">
        </div>
        <table class="info-table">
            <tr><th>Mã mặt hàng</th><td>${item.id}</td></tr>
            <tr><th>Tên mặt hàng</th><td><b><c:out value="${item.name}"/></b></td></tr>
            <tr><th>Loại</th><td><c:out value="${item.category.name}"/></td></tr>
            <tr><th>Đơn vị tính</th><td><c:out value="${item.unit}"/></td></tr>
            <tr><th>Đơn giá</th><td><fmt:formatNumber value="${item.salePrice}" pattern="#,##0"/> đ</td></tr>
            <tr><th>Tình trạng</th>
                <td>
                    <c:choose>
                        <c:when test="${item.quantityInStock > 0}"><span class="ok">Còn hàng</span></c:when>
                        <c:otherwise><span class="bad">Hết hàng</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr><th>Nhà cung cấp</th><td><c:out value="${item.supplier.name}"/></td></tr>
            <tr><th>Mô tả</th><td><c:out value="${item.description}"/></td></tr>
        </table>
    </div>

    <div class="actions">
        <a href="${ctx}/customer/SearchItem7.jsp" class="btn">Quay lại</a>
        <form method="post" action="${ctx}/customer/doAddToCart7.jsp" class="inline">
            <input type="hidden" name="idItem" value="${item.id}">
            <button type="submit" name="btnAddToCart" class="btn"
                    ${item.quantityInStock == 0 ? 'disabled' : ''}>Thêm vào giỏ hàng</button>
        </form>
    </div>
</div>

<c:if test="${not empty message}">
    <div class="modal-overlay" id="msgBox">
        <div class="modal-box">
            <p>${message}</p>
            <button type="button" class="btn" onclick="document.getElementById('msgBox').style.display='none';">OK</button>
        </div>
    </div>
</c:if>
</body>
</html>
