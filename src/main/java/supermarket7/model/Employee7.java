package supermarket7.model;

public class Employee7 extends Member7 {
    private static final long serialVersionUID = 1L;

    private String position;

    public Employee7() {
        super();
    }

    public Employee7(int id, String userName, String password, String fullName,
                     String address, String phone, String email, String position) {
        super(id, userName, password, fullName, address, phone, email);
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
