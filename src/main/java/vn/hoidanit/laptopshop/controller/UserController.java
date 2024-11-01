package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/admin/user")
    public String getHomePage(Model model) {

        User user = new User();
        model.addAttribute("user", user);
        // return userService.handleHello();
        return "admin/user/RegisterUser";
    }

    @RequestMapping("/create/admin/user")
    public String createUserPage(Model model, @ModelAttribute("user") User user) {

        // return userService.handleHello();
        model.addAttribute("test", "test");
        System.out.println(user.toString());
        return "hello";
    }

}
