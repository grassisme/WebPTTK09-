<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.dao.*, supermarket7.model.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    Customer7 customer = (Customer7) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    // Mat hang dang xem (ItemDetail7.jsp da luu vao session)
    Item7 item = (Item7) session.getAttribute("item");
    int idItem = -1;
    try {
        idItem = Integer.parseInt(request.getParameter("idItem"));
    } catch (Exception e) {
        // bo qua, dung item trong session
    }
    if (idItem > 0 && (item == null || item.getId() != idItem)) {
        item = new ItemDAO7().getItemDetail(idItem);
    }
    if (item == null) {
        response.sendRedirect(request.getContextPath() + "/customer/SearchItem7.jsp");
        return;
    }

    String message;
    if (item.getQuantityInStock() <= 0) {
        message = "Mặt hàng đã hết hàng, không thể thêm vào giỏ hàng";
    } else {
        CartLine7 line = new CartLine7();
        line.setItem(item);
        line.setQuantity(1);
        boolean ok = new ShoppingCartDAO7().addItemToCart(customer.getId(), line);
        message = ok ? "Đã thêm mặt hàng vào giỏ hàng" : "Thêm vào giỏ hàng thất bại, vui lòng thử lại";
    }

    session.setAttribute("message", message);
    response.sendRedirect(request.getContextPath() + "/customer/ItemDetail7.jsp?id=" + item.getId());
%>
