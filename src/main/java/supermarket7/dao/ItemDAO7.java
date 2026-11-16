package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import supermarket7.model.Category7;
import supermarket7.model.Item7;
import supermarket7.model.OrderLine7;
import supermarket7.model.Supplier7;

public class ItemDAO7 extends DAO7 {

    public ItemDAO7() {
        super();
    }

    /**
     * Tim mat hang theo ten (LIKE %keyword%), chi lay mat hang dang kinh doanh.
     * @param idCategory = 0 la tat ca cac loai
     */
    public List<Item7> searchItemByName(String keyword, int idCategory) {
        List<Item7> list = new ArrayList<>();
        String sql = "SELECT i.*, c.name AS categoryName, c.description AS categoryDescription "
                + "FROM tblItem7 i JOIN tblCategory7 c ON i.tblCategory7id = c.id "
                + "WHERE i.name LIKE ? ESCAPE '!' AND i.businessStatus = 1"
                + (idCategory > 0 ? " AND i.tblCategory7id = ?" : "")
                + " ORDER BY i.id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + escapeLike(keyword == null ? "" : keyword.trim()) + "%");
            if (idCategory > 0) {
                ps.setInt(2, idCategory);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item7 item = mapItem(rs);
                    Category7 c = new Category7();
                    c.setId(rs.getInt("tblCategory7id"));
                    c.setName(rs.getString("categoryName"));
                    c.setDescription(rs.getString("categoryDescription"));
                    item.setCategory(c);
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Lay chi tiet mat hang, dong goi kem Category7 va Supplier7. */
    public Item7 getItemDetail(int idItem) {
        String sql = "SELECT i.*, "
                + "c.name AS categoryName, c.description AS categoryDescription, "
                + "s.name AS supplierName, s.address AS supplierAddress, s.phone AS supplierPhone, "
                + "s.email AS supplierEmail, s.contactPerson AS supplierContact, s.description AS supplierDescription "
                + "FROM tblItem7 i "
                + "JOIN tblCategory7 c ON i.tblCategory7id = c.id "
                + "JOIN tblSupplier7 s ON i.tblSupplier7id = s.id "
                + "WHERE i.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idItem);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Item7 item = mapItem(rs);

                    Category7 c = new Category7();
                    c.setId(rs.getInt("tblCategory7id"));
                    c.setName(rs.getString("categoryName"));
                    c.setDescription(rs.getString("categoryDescription"));
                    item.setCategory(c);

                    Supplier7 s = new Supplier7();
                    s.setId(rs.getInt("tblSupplier7id"));
                    s.setName(rs.getString("supplierName"));
                    s.setAddress(rs.getString("supplierAddress"));
                    s.setPhone(rs.getString("supplierPhone"));
                    s.setEmail(rs.getString("supplierEmail"));
                    s.setContactPerson(rs.getString("supplierContact"));
                    s.setDescription(rs.getString("supplierDescription"));
                    item.setSupplier(s);
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiem tra ton kho: moi dong deu phai co quantity <= quantityInStock.
     * Dong thoi cap nhat lai quantityInStock moi nhat vao item cua tung dong
     * de trang JSP biet mat hang nao bi thieu.
     */
    public boolean checkStock(List<OrderLine7> listLine) {
        if (listLine == null || listLine.isEmpty()) {
            return false;
        }
        String sql = "SELECT quantityInStock FROM tblItem7 WHERE id = ?";
        boolean enough = true;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (OrderLine7 line : listLine) {
                ps.setInt(1, line.getItem().getId());
                try (ResultSet rs = ps.executeQuery()) {
                    int stock = rs.next() ? rs.getInt("quantityInStock") : 0;
                    line.getItem().setQuantityInStock(stock);
                    if (line.getQuantity() > stock) {
                        enough = false;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return enough;
    }

    /**
     * Tru ton kho theo cac dong don hang.
     * Duoc goi trong transaction cua doExport7.jsp (loi -> rollback).
     */
    public boolean updateStock(List<OrderLine7> listLine) {
        if (listLine == null || listLine.isEmpty()) {
            return false;
        }
        String sql = "UPDATE tblItem7 SET quantityInStock = quantityInStock - ? "
                + "WHERE id = ? AND quantityInStock >= ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (OrderLine7 line : listLine) {
                ps.setInt(1, line.getQuantity());
                ps.setInt(2, line.getItem().getId());
                ps.setInt(3, line.getQuantity());
                if (ps.executeUpdate() != 1) {
                    return false;
                }
                line.getItem().setQuantityInStock(line.getItem().getQuantityInStock() - line.getQuantity());
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Item7 mapItem(ResultSet rs) throws SQLException {
        Item7 item = new Item7();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setUnit(rs.getString("unit"));
        item.setSalePrice(rs.getFloat("salePrice"));
        item.setQuantityInStock(rs.getInt("quantityInStock"));
        item.setImage(rs.getString("image"));
        item.setDescription(rs.getString("description"));
        item.setBusinessStatus(rs.getBoolean("businessStatus"));
        return item;
    }

    /**
     * Thoat cac ki tu dac biet cua LIKE (dung ESCAPE '!', chay duoc tren ca MySQL va SQL Server)
     * de tu khoa duoc tim dung nguyen van.
     */
    private String escapeLike(String s) {
        return s.replace("!", "!!").replace("%", "!%").replace("_", "!_").replace("[", "![");
    }
}
