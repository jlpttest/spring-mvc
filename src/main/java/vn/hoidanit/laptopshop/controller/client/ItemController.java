package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.CartDetailService;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.ProductService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ItemController {
    private final ProductService productService;
    private final CartService cartService;
    private final CartDetailService cartDetailService;

    public ItemController(ProductService productService, CartService cartService, CartDetailService cartDetailService) {
        this.productService = productService;
        this.cartDetailService = cartDetailService;
        this.cartService = cartService;

    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Product pr = this.productService.getProductById(id);
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String handleAddProductToCart(@PathVariable long id, HttpServletRequest request) {

        String email = (String) request.getSession().getAttribute("email");

        this.productService.handleAddProductToCart(id, email, request.getSession());

        return "redirect:/";
    }

    @GetMapping("/cart")
    public String displayCartDetail(Model model, HttpServletRequest request) {

        List<CartDetail> cartDetails = new ArrayList<>();
        cartDetails = this.productService.getCartDetail((String) request.getSession().getAttribute("email"));
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetails", cartDetails);

        return "client/cart/show";
    }

    @PostMapping("/add-product-to-cart")
    public @ResponseBody String addProductToCart(@RequestParam(required = true) Long productId,
            @RequestParam(required = true) int quantity, HttpServletRequest servletRequest) {

        try {
            this.cartDetailService.updateQuantityProduct((String) servletRequest.getSession().getAttribute("email"),
                    productId, quantity);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    @PostMapping("/delete-product-in-cart")
    public @ResponseBody String deleteProduct(@RequestParam(required = true) Long productId,
            HttpServletRequest servletRequest) {

        try {
            this.cartDetailService.deleteProductById(servletRequest.getSession(),
                    productId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    @GetMapping("/check-out")
    public String handlePlaceOrder(Model model, HttpServletRequest servletRequest) {
        List<CartDetail> cartDetails = new ArrayList<>();

        cartDetails = this.productService.getCartDetail((String) servletRequest.getSession().getAttribute("email"));
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getQuantity() * cartDetail.getPrice();
        }
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        HttpSession session = request.getSession(false);

        this.productService.handlePlaceOrder(session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {
        return "client/cart/thanks";
    }

}
