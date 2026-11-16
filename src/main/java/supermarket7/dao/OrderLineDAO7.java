package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import supermarket7.model.Item7;
import supermarket7.model.OrderLine7;

public class OrderLineDAO7 extends DAO7 {

    public OrderLineDAO7() {
        super();
    }

    /** Lay cac dong cua mot don hang, kem thong tin mat hang. */
    public List<OrderLine7> getOrderLineByOrder(int idOrder) {
        List<OrderLine7> list = new ArrayList<>();
        String sql = "SELECT ol.id, ol.quantity, ol.salePrice, "
                + "i.id AS itemId, i.name, i.unit, i.salePrice AS itemSalePrice, i.quantityInStock, "
                + "i.image, i.description, i.businessStatus "
                + "FROM tblOrderLine7 ol JOIN tblItem7 i ON ol.tblItem7id = i.id "
                + "WHERE ol.tblOnlineOrder7id = ? "
                + "ORDER BY ol.id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idOrder);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item7 item = new Item7();
                    item.setId(rs.getInt("itemId"));
                    item.setName(rs.getString("name"));
                    item.setUnit(rs.getString("unit"));
                    item.setSalePrice(rs.getFloat("itemSalePrice"));
                    item.setQuantityInStock(rs.getInt("quantityInStock"));
                    item.setImage(rs.getString("image"));
                    item.setDescription(rs.getString("description"));
                    item.setBusinessStatus(rs.getBoolean("businessStatus"));

                    OrderLine7 line = new OrderLine7();
                    line.setId(rs.getInt("id"));
                    line.setQuantity(rs.getInt("quantity"));
                    line.setSalePrice(rs.getFloat("salePrice"));
                    line.setItem(item);
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
