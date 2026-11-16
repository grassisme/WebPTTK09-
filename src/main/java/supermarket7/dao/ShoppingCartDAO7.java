package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import supermarket7.model.CartLine7;

public class ShoppingCartDAO7 extends DAO7 {

    public ShoppingCartDAO7() {
        super();
    }

    /**
     * Them mot dong vao gio hang cua khach:
     * - tim gio cua khach, chua co thi tao moi;
     * - mat hang da co trong gio thi cong them quantity, chua co thi insert dong moi.
     */
    public boolean addItemToCart(int idCustomer, CartLine7 line) {
        if (line == null || line.getItem() == null || line.getQuantity() <= 0) {
            return false;
        }
        try {
            // 1. Tim (hoac tao) gio hang cua khach
            int idCart = -1;
            String sqlFindCart = "SELECT id FROM tblShoppingCart7 WHERE tblCustomer7id = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlFindCart)) {
                ps.setInt(1, idCustomer);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        idCart = rs.getInt("id");
                    }
                }
            }
            if (idCart == -1) {
                String sqlNewCart = "INSERT INTO tblShoppingCart7 (createdDate, tblCustomer7id) VALUES (?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sqlNewCart, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setDate(1, new java.sql.Date(System.currentTimeMillis()));
                    ps.setInt(2, idCustomer);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            idCart = rs.getInt(1);
                        }
                    }
                }
            }
            if (idCart == -1) {
                return false;
            }

            // 2. Mat hang da co trong gio chua?
            int idLine = -1;
            String sqlFindLine = "SELECT id FROM tblCartLine7 WHERE tblShoppingCart7id = ? AND tblItem7id = ?";
            try (PreparedStatement ps = con.prepareStatement(sqlFindLine)) {
                ps.setInt(1, idCart);
                ps.setInt(2, line.getItem().getId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        idLine = rs.getInt("id");
                    }
                }
            }

            if (idLine != -1) {
                // 3a. Da co -> cong them so luong
                String sqlUpdate = "UPDATE tblCartLine7 SET quantity = quantity + ? WHERE id = ?";
                try (PreparedStatement ps = con.prepareStatement(sqlUpdate)) {
                    ps.setInt(1, line.getQuantity());
                    ps.setInt(2, idLine);
                    ps.executeUpdate();
                }
                line.setId(idLine);
            } else {
                // 3b. Chua co -> them dong moi
                String sqlInsert = "INSERT INTO tblCartLine7 (quantity, tblShoppingCart7id, tblItem7id) VALUES (?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, line.getQuantity());
                    ps.setInt(2, idCart);
                    ps.setInt(3, line.getItem().getId());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            line.setId(rs.getInt(1));
                        }
                    }
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
