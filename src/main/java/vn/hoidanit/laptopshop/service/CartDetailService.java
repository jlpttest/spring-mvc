package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class CartDetailService {
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductService productService;

    public CartDetailService(CartDetailRepository cartDetailRepository, CartRepository cartRepository,
            UserRepository userRepository, ProductService productService) {
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userRepository = userRepository;
        this.productService = productService;
    }

    public void updateQuantityProduct(String email, Long productId, int quantity) {

        User currentUser = this.userRepository.findByEmail(email);
        if (currentUser == null) {
            return;
        }

        Cart cart = this.cartRepository.findByUser(currentUser);
        if (cart == null) {
            return;
        }

        Product addProduct = this.productService.getProductById(productId);

        CartDetail cartDetail = this.cartDetailRepository.findByProductAndCart(addProduct, cart);

        cartDetail.setQuantity(quantity);
        this.cartDetailRepository.save(cartDetail);

    }

    public void deleteProductById(HttpSession session, Long productId) {
        User currentUser = this.userRepository.findByEmail((String) session.getAttribute("email"));
        if (currentUser == null) {
            return;
        }

        Cart cart = this.cartRepository.findByUser(currentUser);
        if (cart == null) {
            return;
        }

        Product addProduct = this.productService.getProductById(productId);
        CartDetail cartDetail = this.cartDetailRepository.findByProductAndCart(addProduct, cart);

        this.cartDetailRepository.deleteById(cartDetail.getId());
        cart.setSum(cart.getSum() - 1);
        session.setAttribute("sum", cart.getSum());
        this.cartRepository.save(cart);
    }

}
