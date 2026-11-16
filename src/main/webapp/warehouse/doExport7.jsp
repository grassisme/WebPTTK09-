<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.util.Date, java.util.List, supermarket7.dao.*, supermarket7.model.*" %>
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

    // Nhan vien giao hang da chon (rdStaff) trong danh sach ChooseDeliveryStaff7.jsp da luu
    DeliveryStaff7 deliveryStaff = null;
    List<DeliveryStaff7> listStaff = (List<DeliveryStaff7>) session.getAttribute("listStaff");
    String rdStaff = request.getParameter("rdStaff");
    if (rdStaff != null && listStaff != null) {
        for (DeliveryStaff7 d : listStaff) {
            if (String.valueOf(d.getId()).equals(rdStaff)) {
                deliveryStaff = d;
                break;
            }
        }
    }
    if (deliveryStaff == null) {
        session.setAttribute("message", "Vui lòng chọn một nhân viên giao hàng");
        response.sendRedirect(request.getContextPath() + "/warehouse/ChooseDeliveryStaff7.jsp");
        return;
    }

    // Tao hoa don bang setter
    OnlineInvoice7 invoice = new OnlineInvoice7();
    invoice.setOrder(order);
    invoice.setWarehouseStaff(staff);
    invoice.setDeliveryStaff(deliveryStaff);
    invoice.setInvoiceDate(new Date());
    invoice.setTotalAmount(order.getTotalAmount());

    OnlineOrderDAO7 orderDAO = new OnlineOrderDAO7();
    ItemDAO7 itemDAO = new ItemDAO7();
    InvoiceDAO7 invoiceDAO = new InvoiceDAO7();

    Connection con = DAO7.getConnection();
    boolean success = false;
    try {
        con.setAutoCommit(false);
        success = orderDAO.updateExportStatus(order)
                && itemDAO.updateStock(order.getListLine())
                && invoiceDAO.createOnlineInvoice(invoice);
        if (success) {
            con.commit();
        } else {
            con.rollback();
        }
    } catch (Exception e) {
        e.printStackTrace();
        success = false;
        try {
            con.rollback();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    } finally {
        try {
            con.setAutoCommit(true);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    if (success) {
        session.setAttribute("invoice", invoice);
        session.removeAttribute("order");
        session.removeAttribute("listStaff");
        session.removeAttribute("listOrder");
        response.sendRedirect(request.getContextPath() + "/warehouse/PrintInvoice7.jsp");
    } else {
        order.setStatus(OnlineOrderDAO7.STATUS_UNEXPORTED);
        session.removeAttribute("order");
        session.setAttribute("message", "Xuất hàng thất bại (đơn đã được xuất hoặc kho không đủ hàng). Dữ liệu đã được khôi phục.");
        response.sendRedirect(request.getContextPath() + "/warehouse/OrderList7.jsp");
    }
%>
