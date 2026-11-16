package supermarket7.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ShoppingCart7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date createdDate;
    private Customer7 customer;
    private List<CartLine7> listLine;

    public ShoppingCart7() {
        listLine = new ArrayList<>();
    }

    public ShoppingCart7(int id, Date createdDate, Customer7 customer, List<CartLine7> listLine) {
        this.id = id;
        this.createdDate = createdDate;
        this.customer = customer;
        this.listLine = listLine;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Customer7 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer7 customer) {
        this.customer = customer;
    }

    public List<CartLine7> getListLine() {
        return listLine;
    }

    public void setListLine(List<CartLine7> listLine) {
        this.listLine = listLine;
    }
}
