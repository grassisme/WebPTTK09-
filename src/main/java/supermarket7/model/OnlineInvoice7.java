package supermarket7.model;

import java.util.Date;

public class OnlineInvoice7 extends Invoice7 {
    private static final long serialVersionUID = 1L;

    private OnlineOrder7 order;
    private WarehouseStaff7 warehouseStaff;
    private DeliveryStaff7 deliveryStaff;

    public OnlineInvoice7() {
        super();
    }

    public OnlineInvoice7(int id, Date invoiceDate, float totalAmount, OnlineOrder7 order,
                          WarehouseStaff7 warehouseStaff, DeliveryStaff7 deliveryStaff) {
        super(id, invoiceDate, totalAmount);
        this.order = order;
        this.warehouseStaff = warehouseStaff;
        this.deliveryStaff = deliveryStaff;
    }

    public OnlineOrder7 getOrder() {
        return order;
    }

    public void setOrder(OnlineOrder7 order) {
        this.order = order;
    }

    public WarehouseStaff7 getWarehouseStaff() {
        return warehouseStaff;
    }

    public void setWarehouseStaff(WarehouseStaff7 warehouseStaff) {
        this.warehouseStaff = warehouseStaff;
    }

    public DeliveryStaff7 getDeliveryStaff() {
        return deliveryStaff;
    }

    public void setDeliveryStaff(DeliveryStaff7 deliveryStaff) {
        this.deliveryStaff = deliveryStaff;
    }
}
