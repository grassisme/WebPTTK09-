package supermarket7.model;

import java.util.Date;

public class Customer7 extends Member7 {
    private static final long serialVersionUID = 1L;

    private Date registerDate;

    public Customer7() {
        super();
    }

    public Customer7(int id, String userName, String password, String fullName,
                     String address, String phone, String email, Date registerDate) {
        super(id, userName, password, fullName, address, phone, email);
        this.registerDate = registerDate;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
}
