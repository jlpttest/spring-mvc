<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <link href="../resources/css/style_regis.css" rel="stylesheet">

                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <title>Register</title>
            </head>

            <body>
                <div class="container mt-5">
                    <form:form class="row g-3" modelAttribute="user" action="/create/admin/user">
                        <div class="col-md-12 col-12 mx-auto ">
                            <h1>Register</h1>
                            <p>Please fill in this form to create an account.</p>
                            <hr>
                        </div>
                        <div class="col-md-12 col-12 mx-auto">
                            <label for="inputEmail4" class="form-label"><b>Email</b></label>
                            <form:input path="email" type="email" class="form-control" id="inputEmail4"
                                required="required" />
                        </div>
                        <div class="col-md-12 col-12 mx-auto">
                            <label for="inputPassword4" class="form-label"><b>Password</b></label>
                            <form:input path="password" type="password" class="form-control" id="inputPassword4"
                                required="required" />
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
                            <form:input path="address" type="text" class="form-control" id="inputAddress"
                                placeholder="Apartment, studio, or floor" required="required" />
                        </div>
                        <div class="col-md-4 col-12 mx-auto">
                            <button type="submit" class="registerbtn"><b>Register</b></button>
                        </div>
                    </form:form>
                </div>
            </body>

            </html>