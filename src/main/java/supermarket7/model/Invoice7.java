package supermarket7.model;

import java.io.Serializable;
import java.util.Date;

public abstract class Invoice7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date invoiceDate;
    private float totalAmount;          // khong luu CSDL, tinh tu cac dong

    public Invoice7() {
    }

    public Invoice7(int id, Date invoiceDate, float totalAmount) {
        this.id = id;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }
}
