package vn.hoidanit.laptopshop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {

    private ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public void handleSaveProduct(Product product) {
        this.productRepository.save(product);

    }

    public List<Product> getAllProduct() {
        return this.productRepository.findAll();
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(Long productId, String email, HttpSession httpSession) {

        User currentUser = this.userService.getUserByEmail(email);

        if (currentUser == null) {
            return;
        }
        Cart cart = this.cartRepository.findByUser(currentUser);

        if (cart == null) {
            Cart otherCart = new Cart();
            otherCart.setUser(currentUser);
            otherCart.setSum(0);
            cart = this.cartRepository.save(otherCart);
        }

        Optional<Product> productOptional = this.productRepository.findById(productId);

        if (!productOptional.isPresent()) {
            return;
        }

        Product product = productOptional.get();

        CartDetail cartDetail = this.cartDetailRepository.findByProductAndCart(product, cart);
        if (cartDetail == null) {
            cartDetail = new CartDetail();
            cartDetail.setProduct(product);
            cartDetail.setCart(cart);
            cartDetail.setPrice(product.getPrice());
            cartDetail.setQuantity(1);

            int sum = cart.getSum() + 1;
            cart.setSum(sum);
            this.cartRepository.save(cart);
            httpSession.setAttribute("sum", sum);
        } else {
            cartDetail.setQuantity(cartDetail.getQuantity() + 1);
        }
        this.cartDetailRepository.save(cartDetail);

    }

    public List<CartDetail> getCartDetail(String email) {

        List<CartDetail> cartDetails = new ArrayList<>();

        User currentUser = this.userService.getUserByEmail(email);
        if (currentUser == null) {
            return cartDetails;
        }

        Cart cart = this.cartRepository.findByUser(currentUser);
        if (cart == null) {
            return cartDetails;
        }

        cartDetails = cart.getCardDetails();

        return cartDetails;
    }

    public void handlePlaceOrder(HttpSession session, String receiverName, String receiverAddress,
            String receiverPhone) {

        Long id = (Long) session.getAttribute("id");
        User currentUser = this.userService.getUserById(id);
        if (currentUser == null) {
            return;
        }
        Cart cart = this.cartRepository.findByUser(currentUser);
        if (cart == null) {
            return;
        }

        List<CartDetail> cartDetails = this.cartDetailRepository.findByCart(cart);
        if (cartDetails == null) {
            return;
        }
        double totalPrice = 0;
        Order order = new Order();
        // create order
        order.setUser(currentUser);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        order.setTotalPrice(totalPrice);
        order.setStatus("PENDING");
        this.orderRepository.save(order);
        for (CartDetail cartDetail : cartDetails) {

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setPrice(cartDetail.getPrice());
            orderDetail.setProduct(cartDetail.getProduct());
            orderDetail.setQuantity(cartDetail.getQuantity());
            this.orderDetailRepository.save(orderDetail);
        }

        // step 2: delete cart_detail and cart
        for (CartDetail cd : cartDetails) {
            this.cartDetailRepository.deleteById(cd.getId());
        }
        this.cartRepository.deleteById(cart.getId());
        // step 3 : update session
        session.setAttribute("sum", 0);

    }

    public List<Product> getAllProduct(int pageSize, int pageNumber) {
        Pageable pageable = PageRequest.of(pageNumber, pageSize);
        Page<Product> prs = this.productRepository.findAll(pageable);
        return prs.getContent();

    }

}
