package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import supermarket7.model.Category7;

public class CategoryDAO7 extends DAO7 {

    public CategoryDAO7() {
        super();
    }

    public List<Category7> getAllCategory() {
        List<Category7> list = new ArrayList<>();
        String sql = "SELECT id, name, description FROM tblCategory7 ORDER BY id";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category7 c = new Category7();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
