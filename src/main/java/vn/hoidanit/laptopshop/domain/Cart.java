package vn.hoidanit.laptopshop.domain;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;

@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cardDetails;

    @Min(value = 0)
    private int sum;

    public long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public List<CartDetail> getCardDetails() {
        return cardDetails;
    }

    public int getSum() {
        return sum;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setCardDetails(List<CartDetail> cardDetails) {
        this.cardDetails = cardDetails;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public Cart(long id, User user, List<CartDetail> cardDetails, @Min(0) int sum) {
        this.id = id;
        this.user = user;
        this.cardDetails = cardDetails;
        this.sum = sum;
    }

    @Override
    public String toString() {
        return "Cart [id=" + id + ", user=" + user + ", cardDetails=" + cardDetails + ", sum=" + sum + "]";
    }

    public Cart() {
    }

}
