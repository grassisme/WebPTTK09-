package supermarket7.model;

import java.io.Serializable;

public class CartLine7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int quantity;
    private Item7 item;

    public CartLine7() {
    }

    public CartLine7(int id, int quantity, Item7 item) {
        this.id = id;
        this.quantity = quantity;
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

    public Item7 getItem() {
        return item;
    }

    public void setItem(Item7 item) {
        this.item = item;
    }
}
