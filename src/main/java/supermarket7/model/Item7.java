package supermarket7.model;

import java.io.Serializable;

public class Item7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String unit;
    private float salePrice;
    private int quantityInStock;
    private String image;
    private String description;
    private boolean businessStatus;
    private Category7 category;
    private Supplier7 supplier;

    public Item7() {
    }

    public Item7(int id, String name, String unit, float salePrice, int quantityInStock,
                 String image, String description, boolean businessStatus,
                 Category7 category, Supplier7 supplier) {
        this.id = id;
        this.name = name;
        this.unit = unit;
        this.salePrice = salePrice;
        this.quantityInStock = quantityInStock;
        this.image = image;
        this.description = description;
        this.businessStatus = businessStatus;
        this.category = category;
        this.supplier = supplier;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public int getQuantityInStock() {
        return quantityInStock;
    }

    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isBusinessStatus() {
        return businessStatus;
    }

    public void setBusinessStatus(boolean businessStatus) {
        this.businessStatus = businessStatus;
    }

    public Category7 getCategory() {
        return category;
    }

    public void setCategory(Category7 category) {
        this.category = category;
    }

    public Supplier7 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier7 supplier) {
        this.supplier = supplier;
    }
}
