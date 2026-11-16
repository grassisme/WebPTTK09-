package supermarket7.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Lop cha cua moi DAO: mo ket noi CSDL mot lan (doc tu db.properties)
 * va dung chung cho tat ca cac DAO con.
 */
public class DAO7 {
    protected static Connection con;

    public DAO7() {
        synchronized (DAO7.class) {
            try {
                if (con == null || con.isClosed() || !con.isValid(2)) {
                    openConnection();
                }
            } catch (Exception e) {
                throw new RuntimeException("Không kết nối được CSDL: " + e.getMessage(), e);
            }
        }
    }

    private static void openConnection() throws Exception {
        Properties prop = new Properties();
        try (InputStream in = DAO7.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new IllegalStateException("Không tìm thấy file db.properties trong classpath");
            }
            prop.load(in);
        }
        Class.forName(prop.getProperty("db.driver", "com.mysql.cj.jdbc.Driver"));
        con = DriverManager.getConnection(
                prop.getProperty("db.url"),
                prop.getProperty("db.user"),
                prop.getProperty("db.password"));
    }

    /**
     * Tra ve ket noi dung chung (dung trong doExport7.jsp de dieu khien transaction:
     * setAutoCommit / commit / rollback).
     */
    public static Connection getConnection() {
        return con;
    }

    /** Dong ket noi an toan (dung khi can). */
    public static void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
