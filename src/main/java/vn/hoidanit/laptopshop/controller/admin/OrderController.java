package vn.hoidanit.laptopshop.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.service.OrderDetailService;
import vn.hoidanit.laptopshop.service.OrderService;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.websocket.server.PathParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class OrderController {

    private final OrderService orderService;
    private final OrderDetailService orderDetailService;

    public OrderController(OrderService orderService, OrderDetailService orderDetailService) {
        this.orderService = orderService;
        this.orderDetailService = orderDetailService;
    }

    @GetMapping("/admin/order")
    public String showOrder(Model model) {
        List<Order> orders = new ArrayList<>();
        orders = this.orderService.getAllOrder();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/admin/order-detail/{id}")
    public String getMethodName(Model model, @PathVariable Long id) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        orderDetails = this.orderDetailService.getOrderDetailsByOrder(this.orderService.getOrderById(id));
        model.addAttribute("orderDetails", orderDetails);
        return "admin/order/orderdetail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String handleDisplayOrder(Model model, @PathVariable Long id) {
        Order order = this.orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String updateOrderStatus(Model model, @ModelAttribute("order") Order order) {
        Order updateOrder = this.orderService.getOrderById(order.getId());
        updateOrder.setStatus(order.getStatus());
        this.orderService.handleSaveOrder(updateOrder);
        return "redirect:/admin/order";
    }

}
