package supermarket7.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import supermarket7.model.OnlineInvoice7;

public class InvoiceDAO7 extends DAO7 {

    public InvoiceDAO7() {
        super();
    }

    /**
     * Luu hoa don truc tuyen: insert tblInvoice7 roi tblOnlineInvoice7,
     * gan id sinh ra vao invoice.
     * Duoc goi trong transaction cua doExport7.jsp (loi -> rollback).
     */
    public boolean createOnlineInvoice(OnlineInvoice7 invoice) {
        if (invoice == null || invoice.getOrder() == null
                || invoice.getWarehouseStaff() == null || invoice.getDeliveryStaff() == null) {
            return false;
        }
        String sqlInvoice = "INSERT INTO tblInvoice7 (invoiceDate) VALUES (?)";
        String sqlOnline = "INSERT INTO tblOnlineInvoice7 "
                + "(tblInvoice7id, tblOnlineOrder7id, tblEmployee7id, tblDeliveryStaff7id) VALUES (?, ?, ?, ?)";
        try {
            int idInvoice;
            try (PreparedStatement ps = con.prepareStatement(sqlInvoice, Statement.RETURN_GENERATED_KEYS)) {
                ps.setDate(1, new java.sql.Date(invoice.getInvoiceDate().getTime()));
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (!rs.next()) {
                        return false;
                    }
                    idInvoice = rs.getInt(1);
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlOnline)) {
                ps.setInt(1, idInvoice);
                ps.setInt(2, invoice.getOrder().getId());
                ps.setInt(3, invoice.getWarehouseStaff().getId());
                ps.setInt(4, invoice.getDeliveryStaff().getId());
                ps.executeUpdate();
            }
            invoice.setId(idInvoice);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
