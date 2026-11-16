package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import supermarket7.model.Customer7;
import supermarket7.model.OnlineOrder7;

public class OnlineOrderDAO7 extends DAO7 {

    public static final String STATUS_UNEXPORTED = "chua xuat";
    public static final String STATUS_EXPORTED = "da xuat";

    public OnlineOrderDAO7() {
        super();
    }

    /**
     * Lay cac don chua xuat, sap theo ngay dat tang dan,
     * kem thong tin khach hang va tong tien (tinh tu cac dong don).
     */
    public List<OnlineOrder7> getUnexportedOrder() {
        List<OnlineOrder7> list = new ArrayList<>();
        String sql = "SELECT o.id, o.orderDate, o.deliveryAddress, o.receiverPhone, o.paymentMethod, o.status, "
                + "m.id AS customerId, m.userName, m.fullName, m.address, m.phone, m.email, c.registerDate, "
                + "COALESCE((SELECT SUM(ol.quantity * ol.salePrice) FROM tblOrderLine7 ol "
                + "          WHERE ol.tblOnlineOrder7id = o.id), 0) AS totalAmount "
                + "FROM tblOnlineOrder7 o "
                + "JOIN tblCustomer7 c ON o.tblCustomer7id = c.tblMember7id "
                + "JOIN tblMember7 m ON c.tblMember7id = m.id "
                + "WHERE o.status = ? "
                + "ORDER BY o.orderDate ASC, o.id ASC";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, STATUS_UNEXPORTED);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer7 c = new Customer7();
                    c.setId(rs.getInt("customerId"));
                    c.setUserName(rs.getString("userName"));
                    c.setFullName(rs.getString("fullName"));
                    c.setAddress(rs.getString("address"));
                    c.setPhone(rs.getString("phone"));
                    c.setEmail(rs.getString("email"));
                    c.setRegisterDate(rs.getDate("registerDate"));

                    OnlineOrder7 o = new OnlineOrder7();
                    o.setId(rs.getInt("id"));
                    o.setOrderDate(rs.getDate("orderDate"));
                    o.setDeliveryAddress(rs.getString("deliveryAddress"));
                    o.setReceiverPhone(rs.getString("receiverPhone"));
                    o.setPaymentMethod(rs.getString("paymentMethod"));
                    o.setStatus(rs.getString("status"));
                    o.setTotalAmount(rs.getFloat("totalAmount"));
                    o.setCustomer(c);
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cap nhat trang thai don thanh 'da xuat'.
     * Chi cap nhat khi don con 'chua xuat' (tranh xuat trung 1 don hai lan).
     */
    public boolean updateExportStatus(OnlineOrder7 order) {
        String sql = "UPDATE tblOnlineOrder7 SET status = ? WHERE id = ? AND status = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, STATUS_EXPORTED);
            ps.setInt(2, order.getId());
            ps.setString(3, STATUS_UNEXPORTED);
            if (ps.executeUpdate() == 1) {
                order.setStatus(STATUS_EXPORTED);
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
