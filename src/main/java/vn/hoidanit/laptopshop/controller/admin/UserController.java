package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.RoleService;
import vn.hoidanit.laptopshop.service.UploadFileService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    private UserService userService;
    private UploadFileService uploadFileService;
    private PasswordEncoder passwordEncoder;
    private RoleService roleService;

    public UserController(UserService userService, UploadFileService uploadFileService,
            PasswordEncoder passwordEncoder, RoleService roleService) {
        this.userService = userService;
        this.uploadFileService = uploadFileService;
        this.passwordEncoder = passwordEncoder;
        this.roleService = roleService;
    }

    // Get all user list page
    @GetMapping("/admin/user")
    public String getUserList(Model model) {

        List<User> users = this.userService.getAllUser();
        model.addAttribute("users", users);
        return "admin/user/UserList";
    }

    // Get user detail page
    @GetMapping("/admin/user/{id}")
    public String getUserDetail(Model model, @PathVariable long id) {

        User user = this.userService.getUserById(id);
        if (user.getAvatar() == "" || user.getAvatar() == null) {
            user.setAvatar("default.jpg");
        }
        model.addAttribute("user", user);
        return "admin/user/UserDetail";
    }

    // get update user page
    @GetMapping("/admin/user/update/{id}")
    public String updateUserById(Model model, @PathVariable long id) {

        User user = this.userService.getUserById(id);
        if (user.getAvatar() == "" || user.getAvatar() == null) {
            user.setAvatar("default.jpg");
        }
        model.addAttribute("user", user);
        return "admin/user/UpdateUser";
    }

    // get create new user page
    @GetMapping("/admin/user/create")
    public String handleCreateUser(Model model) {

        User user = new User();
        model.addAttribute("newUser", user);
        return "admin/user/RegisterUser";
    }

    // handle save new user
    @PostMapping("/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") @Valid User user,
            BindingResult newUserBindingResult,
            @RequestParam("uploadFile") MultipartFile file) {

        // List<FieldError> errors = newUserBindingResult.getFieldErrors();

        // validate
        if (newUserBindingResult.hasErrors()) {
            return "admin/user/RegisterUser";
        }

        String avatar = this.uploadFileService.handleSaveFileUpload(file, "avatar");
        String encryptedPass = this.passwordEncoder.encode(user.getPassword());

        user.setAvatar(avatar);
        user.setPassword(encryptedPass);
        user.setRole(this.roleService.getRoleByName(user.getRole().getName()));
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    // handle update user
    @PostMapping("/admin/user/update")
    public String updateUser(Model model, @ModelAttribute("user") User newUser,
            @RequestParam("uploadFile") MultipartFile file) {
        User user = this.userService.getUserById(newUser.getId());
        if (user != null) {
            user.setAddress(newUser.getAddress());
            user.setUsername(newUser.getUsername());
            user.setPhone(newUser.getPhone());
            user.setAvatar(this.uploadFileService.handleUpdateAvatar(file, "avatar", newUser.getAvatar()));
            this.userService.handleSaveUser(user);
        }
        return "redirect:/admin/user";
    }

    // handle delete user
    @GetMapping("/admin/user/delete/{id}")
    public String delUserById(@PathVariable long id) {
        this.userService.deleteUserById(id);
        return "redirect:/admin/user";
    }

}
