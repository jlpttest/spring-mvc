<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Dashboard - Hỏi Dân IT</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <!-- <link href="/css/style_regis.css" rel="stylesheet" /> -->
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Products</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product">Product</a></li>
                                    <li class="breadcrumb-item active">Update product</li>
                                </ol>
                                <div class="mt-1" style="width: 50%;">
                                    <form:form class="row g-3" modelAttribute="updateProduct"
                                        action="/admin/product/update" enctype="multipart/form-data">
                                        <div class="col-md-12 col-12 mx-auto ">
                                            <h2>Register</h2>
                                            <p>Please fill in this form to create an Product.</p>
                                            <hr>
                                        </div>
                                        <div class="col-12 col-md-6 mx-auto">
                                            <form:input type="text" id="id" style="display: none;" clas="form-control"
                                                path="id" />
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label for="inputName" class="form-label"><b>Name</b></label>
                                            <form:input type="text" id="inputName"
                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                path="name" />
                                            ${errorName}
                                        </div>
                                        <div class="col-md-6 col-12 mx-auto">
                                            <c:set var="errorPrice">
                                                <form:errors path="price" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label for="inputPrice" class="form-label"><b>Price</b></label>
                                            <form:input type="text" id="inputPrice"
                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                path="price" />
                                            ${errorPrice}
                                        </div>
                                        <div class="col-md-12 col-12 mx-auto">
                                            <c:set var="errorDetailDesc">
                                                <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label for="inputdetailDesc" class="form-label"><b>Detail
                                                    description</b></label>
                                            <form:textarea path="detailDesc" rows="3"
                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                id="inputdetailDesc" />
                                            ${errorDetailDesc}
                                        </div>
                                        <div class="col-md-6 col-12 mx-auto">
                                            <c:set var="errorShortDesc">
                                                <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label for="inputshortDesc" class="form-label"><b>Short
                                                    Description</b></label>
                                            <form:input path="shortDesc" type="text"
                                                class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}"
                                                id="inputshortDesc" />
                                            ${errorShortDesc}
                                        </div>
                                        <div class="col-md-6 col-12 mx-auto">
                                            <c:set var="errorQuantity">
                                                <form:errors path="quantity" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label for="inputquantity" class="form-label"><b>Quantity</b></label>
                                            <form:input path="quantity" type="number"
                                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                id="inputquantity" />
                                            ${errorQuantity}
                                        </div>

                                        <div class="mb-3 col-md-6 col-12 mx-auto">
                                            <label class="form-label">Factory:</label>
                                            <form:select class="form-select" path="factory">
                                                <form:option value="APPLE">Apple (MacBook)</form:option>
                                                <form:option value="ASUS">Asus</form:option>
                                                <form:option value="LENOVO">Lenovo</form:option>
                                                <form:option value="DELL">Dell</form:option>
                                                <form:option value="LG">LG</form:option>
                                                <form:option value="ACER">Acer</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-md-6 col-12 mx-auto">
                                            <label class="form-label">Target:</label>
                                            <form:select class="form-select" path="target">
                                                <form:option value="GAMING">Gaming</form:option>
                                                <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng
                                                </form:option>
                                                <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa
                                                </form:option>
                                                <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                <form:option value="DOANH-NHAN">Doanh nhân</form:option>

                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-md-12 col-12 mx-auto">
                                            <label for="avatarFile" class="form-label">Image:</label>
                                            <input class="form-control" type="file" id="avatarFile" name="uploadFile"
                                                accept=".png, .jpg, .jpeg">
                                        </div>
                                        <div class="col-md-12 col-12 mx-auto col-12 mx-auto mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                id="avatarPreview" />
                                        </div>
                                        <div class="col-md-6 col-12 mx-auto">
                                            <button type="submit"
                                                class="registerbtn btn btn-success"><b>Register</b></button>
                                        </div>
                                        <div class="col-md-6 col-12 mx-auto">
                                            <a href="/admin/product" type="button"
                                                class="btn btn-danger"><b>Cancel</b></a>
                                        </div>

                                    </form:form>
                                </div>

                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
            </body>

            <script>
                $(document).ready(() => {

                    const orgImage = "${updateProduct.image}";
                    if (orgImage) {
                        const urlImage = "/images/product/" + orgImage;
                        $("#avatarPreview").attr("src", urlImage);
                        $("#avatarPreview").css({ "display": "block" });
                    }
                    const avatarFile = $("#avatarFile");
                    avatarFile.change(function (e) {
                        const imgURL = URL.createObjectURL(e.target.files[0]);
                        $("#avatarPreview").attr("src", imgURL);
                        $("#avatarPreview").css({ "display": "block" });
                    });
                });
            </script>


            </html>