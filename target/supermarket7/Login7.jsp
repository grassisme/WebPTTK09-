<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="container narrow">
    <h2 class="title">HỆ THỐNG QUẢN LÍ SIÊU THỊ TRỰC TUYẾN</h2>
    <h3 class="subtitle">Đăng nhập</h3>

    <c:if test="${not empty error}">
        <div class="message error"><c:out value="${error}"/></div>
    </c:if>

    <form method="post" action="${ctx}/doLogin7.jsp" class="form-box">
        <table class="form-table">
            <tr>
                <td><label for="txtUserName">Tên đăng nhập:</label></td>
                <td><input type="text" id="txtUserName" name="txtUserName"
                           value="<c:out value='${param.txtUserName}'/>" required autofocus></td>
            </tr>
            <tr>
                <td><label for="txtPassword">Mật khẩu:</label></td>
                <td><input type="password" id="txtPassword" name="txtPassword" required></td>
            </tr>
            <tr>
                <td></td>
                <td><button type="submit" name="btnLogin" class="btn">Đăng nhập</button></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
