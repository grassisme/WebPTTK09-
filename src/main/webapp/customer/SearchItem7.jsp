<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, supermarket7.dao.*, supermarket7.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    // Combobox loai mat hang
    List<Category7> listCategory = new CategoryDAO7().getAllCategory();
    request.setAttribute("listCategory", listCategory);

    // Nhan nut Tim kiem -> tim va luu ket qua vao session (de quay lai van con).
    // Vao trang lan dau (chua co ket qua nao) -> hien tat ca mat hang.
    if (request.getParameter("btnSearch") != null || session.getAttribute("listItem") == null) {
        String keyword = request.getParameter("txtKeyword");
        keyword = (keyword == null) ? "" : keyword.trim();
        int idCategory = 0;
        try {
            idCategory = Integer.parseInt(request.getParameter("cbCategory"));
        } catch (Exception e) {
            idCategory = 0;
        }
        session.setAttribute("keyword", keyword);
        session.setAttribute("idCategory", idCategory);

        // Tu khoa rong -> LIKE '%%' -> lay tat ca mat hang (theo loai da chon)
        List<Item7> listItem = new ItemDAO7().searchItemByName(keyword, idCategory);
        session.setAttribute("listItem", listItem);
    }
%>
<fmt:setLocale value="vi_VN"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm mặt hàng</title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<div class="topbar">
    <span>Khách hàng: <b><c:out value="${sessionScope.customer.fullName}"/></b>
        | <a href="${ctx}/customer/CustomerHome7.jsp">Trang chủ</a></span>
    <a href="${ctx}/doLogout7.jsp" class="btn btn-small">Đăng xuất</a>
</div>
<div class="container">
    <h2 class="title">TÌM KIẾM MẶT HÀNG</h2>

    <form method="get" action="${ctx}/customer/SearchItem7.jsp" class="search-form">
        <label for="txtKeyword">Tên mặt hàng:</label>
        <input type="text" id="txtKeyword" name="txtKeyword" size="30"
               value="<c:out value='${sessionScope.keyword}'/>">
        <label for="cbCategory">Loại:</label>
        <select id="cbCategory" name="cbCategory"
                onchange="this.form.requestSubmit(document.getElementById('btnSearch'));">
            <option value="0">Tất cả</option>
            <c:forEach var="cat" items="${listCategory}">
                <option value="${cat.id}" ${cat.id == sessionScope.idCategory ? 'selected' : ''}>
                    <c:out value="${cat.name}"/>
                </option>
            </c:forEach>
        </select>
        <button type="submit" id="btnSearch" name="btnSearch" value="1" class="btn">Tìm kiếm</button>
    </form>

    <c:choose>
        <c:when test="${not empty message}">
            <div class="message warning">${message}</div>
        </c:when>
        <c:when test="${sessionScope.listItem != null and empty sessionScope.listItem}">
            <div class="message">Không tìm thấy mặt hàng phù hợp</div>
        </c:when>
        <c:when test="${not empty sessionScope.listItem}">
            <c:choose>
                <c:when test="${empty sessionScope.keyword}">
                    <p>Có <b>${sessionScope.listItem.size()}</b> mặt hàng:</p>
                </c:when>
                <c:otherwise>
                    <p>Tìm thấy <b>${sessionScope.listItem.size()}</b> mặt hàng với từ khoá
                        "<b><c:out value="${sessionScope.keyword}"/></b>":</p>
                </c:otherwise>
            </c:choose>
            <table id="tblItem" class="data-table">
                <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã MH</th>
                    <th>Tên mặt hàng</th>
                    <th>ĐVT</th>
                    <th>Loại</th>
                    <th>Đơn giá (đ)</th>
                    <th>Tình trạng</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${sessionScope.listItem}" varStatus="st">
                    <tr>
                        <td class="center">${st.count}</td>
                        <td class="center">${item.id}</td>
                        <td><c:out value="${item.name}"/></td>
                        <td class="center"><c:out value="${item.unit}"/></td>
                        <td><c:out value="${item.category.name}"/></td>
                        <td class="right"><fmt:formatNumber value="${item.salePrice}" pattern="#,##0"/></td>
                        <td class="center">
                            <c:choose>
                                <c:when test="${item.quantityInStock > 0}"><span class="ok">Còn hàng</span></c:when>
                                <c:otherwise><span class="bad">Hết hàng</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="center"><a href="${ctx}/customer/ItemDetail7.jsp?id=${item.id}">Xem</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
    </c:choose>
</div>
</body>
</html>
