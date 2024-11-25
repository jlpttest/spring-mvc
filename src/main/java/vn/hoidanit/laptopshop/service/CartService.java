package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.repository.CartRepository;

@Service
public class CartService {

    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository, ProductService productService,
            CartDetailService cartDetailService, UserService userService) {
        this.cartRepository = cartRepository;
    }

}
