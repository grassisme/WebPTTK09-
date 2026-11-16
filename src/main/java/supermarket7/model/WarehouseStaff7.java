package supermarket7.model;

public class WarehouseStaff7 extends Employee7 {
    private static final long serialVersionUID = 1L;

    public WarehouseStaff7() {
        super();
    }

    public WarehouseStaff7(int id, String userName, String password, String fullName,
                           String address, String phone, String email, String position) {
        super(id, userName, password, fullName, address, phone, email, position);
    }
}
