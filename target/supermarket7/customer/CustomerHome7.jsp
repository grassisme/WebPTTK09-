<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.model.Customer7" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Khách hàng: <b><c:out value="${sessionScope.customer.fullName}"/></b></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">TRANG CHỦ KHÁCH HÀNG</h2>
    <p class="center">Xin chào <b><c:out value="${sessionScope.customer.fullName}"/></b>, chào mừng bạn đến với siêu thị trực tuyến.</p>
    <ul class="menu">
        <li><a href="${ctx}/customer/SearchItem7.jsp" class="btn">Tìm kiếm mặt hàng</a></li>
    </ul>
</div>
</body>
</html>
