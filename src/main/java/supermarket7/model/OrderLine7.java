package supermarket7.model;

import java.io.Serializable;

public class OrderLine7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int quantity;
    private float salePrice;
    private Item7 item;

    public OrderLine7() {
    }

    public OrderLine7(int id, int quantity, float salePrice, Item7 item) {
        this.id = id;
        this.quantity = quantity;
        this.salePrice = salePrice;
        this.item = item;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public Item7 getItem() {
        return item;
    }

    public void setItem(Item7 item) {
        this.item = item;
    }
}
