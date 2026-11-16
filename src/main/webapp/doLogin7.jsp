<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="supermarket7.dao.MemberDAO7, supermarket7.model.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userName = request.getParameter("txtUserName");
    String password = request.getParameter("txtPassword");
    if (userName == null || password == null) {
        response.sendRedirect(request.getContextPath() + "/Login7.jsp");
        return;
    }

    Member7 member = new MemberDAO7().checkLogin(userName.trim(), password);

    if (member instanceof Customer7) {
        session.invalidate();
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("customer", member);
        response.sendRedirect(request.getContextPath() + "/customer/CustomerHome7.jsp");
    } else if (member instanceof WarehouseStaff7) {
        session.invalidate();
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("staff", member);
        response.sendRedirect(request.getContextPath() + "/warehouse/WarehouseHome7.jsp");
    } else {
        if (member == null) {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
        } else {
            request.setAttribute("error", "Tài khoản không có quyền truy cập các chức năng này");
        }
        request.getRequestDispatcher("/Login7.jsp").forward(request, response);
    }
%>
