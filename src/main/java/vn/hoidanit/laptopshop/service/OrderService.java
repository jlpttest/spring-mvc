package vn.hoidanit.laptopshop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Order> getAllOrder() {
        return this.orderRepository.findAll();
    }

    public Order getOrderById(Long id) {
        return this.orderRepository.findById(id).get();
    }

    public void handleSaveOrder(Order order) {
        this.orderRepository.save(order);
    }
}
