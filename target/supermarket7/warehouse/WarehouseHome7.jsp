<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.model.WarehouseStaff7" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff7 staff = (WarehouseStaff7) session.getAttribute("staff");
    if (staff == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ nhân viên kho</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Nhân viên kho: <b><c:out value="${sessionScope.staff.fullName}"/></b></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">TRANG CHỦ NHÂN VIÊN KHO</h2>
    <p class="center">Xin chào <b><c:out value="${sessionScope.staff.fullName}"/></b>.</p>
    <ul class="menu">
        <li><a href="${ctx}/warehouse/OrderList7.jsp" class="btn">Duyệt đơn hàng</a></li>
    </ul>
</div>
</body>
</html>
