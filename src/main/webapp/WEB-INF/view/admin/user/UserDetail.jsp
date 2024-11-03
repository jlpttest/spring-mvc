<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <title>User Detail ${user.id}</title>
            </head>

            <body>

                <div class="container p-5">
                    <div class="row ">
                        <div class="col-md-12">
                            <h2>User detail with ID ${user.id}</h2>
                            <hr>
                        </div>
                        <div class="col-md-12">
                            <div class="card" style="width: 50%;">
                                <div class="card-header">
                                    User Information
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">ID: ${user.id}</li>
                                    <li class="list-group-item">Full Name : ${user.username}</li>
                                    <li class="list-group-item">Email : ${user.email}</li>
                                    <li class="list-group-item">Phone Number : ${user.phone}</li>
                                    <li class="list-group-item">Address: ${user.address}</li>
                                </ul>
                            </div>

                            <a href="/admin/user" class="btn btn-primary">Back</a>

                        </div>

                    </div>

                </div>

            </body>

            </html>