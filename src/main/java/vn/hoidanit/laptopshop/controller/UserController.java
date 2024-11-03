package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/admin/user")
    public String getUserList(Model model) {

        List<User> users = this.userService.getAllUser();
        model.addAttribute("users", users);
        return "admin/user/UserList";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetail(Model model, @PathVariable long id) {

        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/UserDetail";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String updateUserById(Model model, @PathVariable long id) {

        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/UpdateUser";
    }

    @RequestMapping("/admin/user/create")
    public String handleCreateUser(Model model) {

        User user = new User();
        model.addAttribute("user", user);
        return "admin/user/RegisterUser";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("user") User user) {

        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @RequestMapping(value = "/admin/user/update", method = RequestMethod.POST)
    public String updateUser(Model model, @ModelAttribute("user") User newUser) {
        User user = this.userService.getUserById(newUser.getId());
        if (user != null) {
            user.setAddress(newUser.getAddress());
            user.setUsername(newUser.getUsername());
            user.setPhone(newUser.getPhone());
            this.userService.handleSaveUser(user);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String delUserById(@PathVariable long id) {
        this.userService.deleteUserById(id);
        return "redirect:/admin/user";
    }

}
