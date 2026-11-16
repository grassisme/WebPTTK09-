package supermarket7.model;

public class DeliveryStaff7 extends Employee7 {
    private static final long serialVersionUID = 1L;

    private String area;
    private boolean availableStatus;

    public DeliveryStaff7() {
        super();
    }

    public DeliveryStaff7(int id, String userName, String password, String fullName,
                          String address, String phone, String email, String position,
                          String area, boolean availableStatus) {
        super(id, userName, password, fullName, address, phone, email, position);
        this.area = area;
        this.availableStatus = availableStatus;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public boolean isAvailableStatus() {
        return availableStatus;
    }

    public void setAvailableStatus(boolean availableStatus) {
        this.availableStatus = availableStatus;
    }
}
