package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import supermarket7.model.DeliveryStaff7;

public class DeliveryStaffDAO7 extends DAO7 {

    public DeliveryStaffDAO7() {
        super();
    }

    /** Lay danh sach nhan vien giao hang dang ranh (availableStatus = true). */
    public List<DeliveryStaff7> getAvailableStaff() {
        List<DeliveryStaff7> list = new ArrayList<>();
        String sql = "SELECT m.id, m.userName, m.fullName, m.address, m.phone, m.email, "
                + "e.position, d.area, d.availableStatus "
                + "FROM tblDeliveryStaff7 d "
                + "JOIN tblEmployee7 e ON d.tblEmployee7id = e.tblMember7id "
                + "JOIN tblMember7 m ON e.tblMember7id = m.id "
                + "WHERE d.availableStatus = 1 "
                + "ORDER BY m.id";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DeliveryStaff7 d = new DeliveryStaff7();
                d.setId(rs.getInt("id"));
                d.setUserName(rs.getString("userName"));
                d.setFullName(rs.getString("fullName"));
                d.setAddress(rs.getString("address"));
                d.setPhone(rs.getString("phone"));
                d.setEmail(rs.getString("email"));
                d.setPosition(rs.getString("position"));
                d.setArea(rs.getString("area"));
                d.setAvailableStatus(rs.getBoolean("availableStatus"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
