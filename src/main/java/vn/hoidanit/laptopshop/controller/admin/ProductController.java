package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadFileService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

@Controller
public class ProductController {

    private UploadFileService uploadFileService;
    private ProductService productService;

    public ProductController(UploadFileService uploadFileService, ProductService productService) {
        this.uploadFileService = uploadFileService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String showProduct(Model model) {
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("products", products);

        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getMethodName(Model model) {
        Product product = new Product();
        model.addAttribute("newProduct", product);
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createUserPage(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("uploadFile") MultipartFile file) {

        // List<FieldError> errors = newUserBindingResult.getFieldErrors();

        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String img = this.uploadFileService.handleSaveFileUpload(file, "product");
        product.setImage(img);
        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getDetailProduct(Model model, @PathVariable long id) {

        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);

        return "admin/product/productdetail";

    }

    @GetMapping("/admin/product/delete/{id}")
    public String getMethodName(@PathVariable long id) {
        this.productService.deleteProductById(id);
        return "redirect:/admin/product";
    }

}
