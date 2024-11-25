package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    CartDetail findByProductAndCart(Product product, Cart cart);

    List<CartDetail> findByCart(Cart cart);

    void deleteByProduct(Product product);
}
