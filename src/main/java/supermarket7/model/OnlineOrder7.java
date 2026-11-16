package supermarket7.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OnlineOrder7 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date orderDate;
    private String deliveryAddress;
    private String receiverPhone;
    private String paymentMethod;
    private float totalAmount;          // khong luu CSDL, tinh tu cac dong don hang
    private String status;              // 'chua xuat' | 'da xuat'
    private Customer7 customer;
    private List<OrderLine7> listLine;

    public OnlineOrder7() {
        listLine = new ArrayList<>();
    }

    public OnlineOrder7(int id, Date orderDate, String deliveryAddress, String receiverPhone,
                        String paymentMethod, float totalAmount, String status,
                        Customer7 customer, List<OrderLine7> listLine) {
        this.id = id;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.receiverPhone = receiverPhone;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.status = status;
        this.customer = customer;
        this.listLine = listLine;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Customer7 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer7 customer) {
        this.customer = customer;
    }

    public List<OrderLine7> getListLine() {
        return listLine;
    }

    public void setListLine(List<OrderLine7> listLine) {
        this.listLine = listLine;
    }
}
