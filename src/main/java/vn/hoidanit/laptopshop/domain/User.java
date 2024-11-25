package vn.hoidanit.laptopshop.domain;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    @NotEmpty(message = "Email cannot be empty")
    private String email;

    @NotNull
    // @Min(value = 2, message = "Password phải có tối thiểu 2 ký tự")
    @Size(min = 2, message = "Password phải có tối thiểu 2 ký tự")
    private String password;

    @NotNull
    @Size(min = 2, message = "username phải có tối thiểu 2 ký tự")
    // @Min(value = 3, message = "Fullname phải có tối thiểu 3 ký tự")
    private String username;

    private String address;
    private String phone;

    private String avatar;

    // roleId
    // user - role
    // 1 user - 1 role
    // 1 role - N user -> N-1
    // user
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    // user - order
    // 1 user - N order
    // 1 user - 1 order
    // -> 1 - N

    @OneToOne(mappedBy = "user")
    private Cart cart;

    public void setRole(Role role) {
        this.role = role;
    }

    public void setOrder(List<Order> order) {
        this.order = order;
    }

    @OneToMany(mappedBy = "user")
    private List<Order> order;

    public Role getRole() {
        return role;
    }

    public List<Order> getOrder() {
        return order;
    }

    public long getId() {
        return id;
    }

    public User() {
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", password=" + password + ", username=" + username
                + ", address=" + address + ", phone=" + phone + ", avatar=" + avatar + "]";
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

}
