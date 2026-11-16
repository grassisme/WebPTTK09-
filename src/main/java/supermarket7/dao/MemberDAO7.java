package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import supermarket7.model.Customer7;
import supermarket7.model.Employee7;
import supermarket7.model.Member7;
import supermarket7.model.WarehouseStaff7;

/** Ho tro dang nhap (toi thieu) de vao 2 module. */
public class MemberDAO7 extends DAO7 {

    public MemberDAO7() {
        super();
    }

    /**
     * Kiem tra dang nhap trong tblMember7.
     * @return Customer7 neu la khach hang, WarehouseStaff7 neu la nhan vien kho,
     *         Employee7 voi cac vi tri khac, null neu sai ten dang nhap/mat khau.
     */
    public Member7 checkLogin(String userName, String password) {
        String sql = "SELECT m.id, m.userName, m.fullName, m.address, m.phone, m.email, "
                + "c.tblMember7id AS customerId, c.registerDate, e.position "
                + "FROM tblMember7 m "
                + "LEFT JOIN tblCustomer7 c ON c.tblMember7id = m.id "
                + "LEFT JOIN tblEmployee7 e ON e.tblMember7id = m.id "
                + "WHERE m.userName = ? AND m.password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Member7 member;
                if (rs.getObject("customerId") != null) {
                    Customer7 c = new Customer7();
                    c.setRegisterDate(rs.getDate("registerDate"));
                    member = c;
                } else if ("warehouse".equals(rs.getString("position"))) {
                    WarehouseStaff7 w = new WarehouseStaff7();
                    w.setPosition("warehouse");
                    member = w;
                } else {
                    Employee7 e = new Employee7();
                    e.setPosition(rs.getString("position"));
                    member = e;
                }
                member.setId(rs.getInt("id"));
                member.setUserName(rs.getString("userName"));
                member.setFullName(rs.getString("fullName"));
                member.setAddress(rs.getString("address"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
                return member;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
