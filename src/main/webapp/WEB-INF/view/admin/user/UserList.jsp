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
                                <div class="row">
                                    <h1 class="mt-4">Manage Users</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Users</li>
                                    </ol>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12 mx-auto">
                                        <div class="d-flex justify-content-between p-3">
                                            <h2>Table Users</h2>
                                            <a href="/admin/user/create" class="btn btn-primary">Create User</a>

                                        </div>
                                        <hr>
                                    </div>
                                    <div class="col-md-12 col-xs-12 mx-auto p-3">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Email</th>
                                                    <th scope="col">Full Name</th>
                                                    <th scope="col">Role</th>
                                                    <th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${users}">
                                                    <tr>
                                                        <th scope="row">${user.id}</th>
                                                        <td>${user.email}</td>
                                                        <td>${user.username}</td>
                                                        <td>${user.role.name}</td>
                                                        <td>
                                                            <a href="/admin/user/${user.id}"
                                                                class="btn btn-success">View</a>
                                                            <button class="btn btn-danger delete-user"
                                                                data-id="${user.id}">Delete</button>
                                                            <a href="/admin/user/update/${user.id}"
                                                                class="btn btn-warning">Update</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                    </div>

                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
                                    data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
                                    aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header alert alert-danger">
                                                <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete User
                                                </h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">

                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Close</button>
                                                <a type="button" href="#"
                                                    class="btn btn-danger delete-confirm">Delete</a>
                                            </div>
                                        </div>
                                    </div>
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
                <script>

                    $(document).ready(function () {
                        var userId;
                        var btnClick;

                        $('.delete-user').click(function () {
                            userId = $(this).data('id');
                            console.log('Delete user with ID:', userId); // Add your deletion logic here
                            $('.modal-body').html("Are you sure you want to delete user id: " + userId + "?");
                            $('.delete-confirm').attr('href', '/admin/user/delete/' + userId);
                            $('#staticBackdrop').modal('show');
                        });


                        // // Confirm deletion
                        // $('.delete-confirm').click(function () {
                        //     // Perform the deletion action using the userId
                        //     $.ajax({
                        //         url: '/admin/user/delete/' + userId,
                        //         type: 'DELETE',
                        //         success: function (result) {
                        //             // Handle the success, like reloading the table or displaying a success message
                        //             alert('User deleted successfully.');
                        //             location.reload(); // Reload the page or update the table data
                        //         },
                        //         error: function (error) {
                        //             // Handle the error, like displaying an error message
                        //             alert('An error occurred while deleting the user.');
                        //         }
                        //     });

                        //     // Close the modal
                        //     $('#staticBackdrop').modal('hide');
                        // });
                    });


                </script>
            </body>

            </html>