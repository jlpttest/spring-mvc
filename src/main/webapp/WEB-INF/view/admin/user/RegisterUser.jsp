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
                                <h1 class="mt-4">Manage Users</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Users</li>
                                </ol>
                                <div class="mt-1" style="width: 50%;">
                                    <form:form class="row g-3" modelAttribute="newUser" action="/admin/user/create"
                                        enctype="multipart/form-data">
                                        <div class="col-md-12 col-12 mx-auto ">
                                            <h2>Register</h2>
                                            <p>Please fill in this form to create an account.</p>
                                            <hr>
                                        </div>
                                        <div class="col-12 col-md-4 mx-auto">
                                            <label for="inputEmail4" class="form-label"><b>Email</b></label>
                                            <form:input path="email" type="email" class="form-control" id="inputEmail4"
                                                required="required" />
                                        </div>
                                        <div class="col-md-4 col-12 mx-auto">
                                            <label for="inputPassword4" class="form-label"><b>Password</b></label>
                                            <form:input path="password" type="password" class="form-control"
                                                id="inputPassword4" required="required" />
                                        </div>
                                        <div class="col-md-4 col-12 mx-auto">
                                            <label for="inputPhoneNum" class="form-label"><b>Phone Number</b></label>
                                            <form:input path="phone" type="text" class="form-control" id="inputPhoneNum"
                                                placeholder="+841234567" required="required" />
                                        </div>
                                        <div class="col-md-4 col-12 mx-auto">
                                            <label for="inputName" class="form-label"><b>Full Name</b></label>
                                            <form:input path="username" type="text" class="form-control" id="inputName"
                                                required="required" />
                                        </div>
                                        <div class="col-md-4 col-12 mx-auto">
                                            <label for="inputAddress" class="form-label"><b>Address</b></label>
                                            <form:input path="address" type="text" class="form-control"
                                                id="inputAddress" placeholder="Apartment, studio, or floor"
                                                required="required" />
                                        </div>

                                        <div class="mb-3 col-md-4 col-12 mx-auto">
                                            <label class="form-label">Role:</label>
                                            <form:select class="form-select" path="role.name">
                                                <form:option value="ADMIN">ADMIN</form:option>
                                                <form:option value="USER">USER</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-md-12 col-12 mx-auto">
                                            <label for="avatarFile" class="form-label">Avatar:</label>
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
                                            <a href="/admin/user" type="button" class="btn btn-danger"><b>Cancel</b></a>
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
                    const avatarFile = $("#avatarFile");
                    avatarFile.change(function (e) {
                        const imgURL = URL.createObjectURL(e.target.files[0]);
                        $("#avatarPreview").attr("src", imgURL);
                        $("#avatarPreview").css({ "display": "block" });
                    });
                });
            </script>


            </html>