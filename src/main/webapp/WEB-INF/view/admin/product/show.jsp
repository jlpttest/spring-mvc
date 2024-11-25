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
                                    <li class="breadcrumb-item active">Products</li>
                                </ol>

                                <div class="row">
                                    <div class="col-md-12 col-xs-12 mx-auto">
                                        <div class="d-flex justify-content-between p-3">
                                            <h2>Table Products</h2>
                                            <a href="/admin/product/create" class="btn btn-primary">Create Product</a>

                                        </div>
                                        <hr>
                                    </div>
                                    <div class="col-md-12 col-xs-12 mx-auto p-3">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Factory</th>
                                                    <th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${products}">
                                                    <tr>
                                                        <th scope="row">${product.id}</th>
                                                        <td>${product.name}</td>
                                                        <td>${product.price}</td>
                                                        <td>${product.factory}</td>
                                                        <td>
                                                            <a href="/admin/product/${product.id}"
                                                                class="btn btn-success">View</a>
                                                            <button class="btn btn-danger delete-product"
                                                                data-id="${product.id}">Delete</button>
                                                            <a href="/admin/product/update/${product.id}"
                                                                class="btn btn-warning">Update</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item">
                                                    <a class="${currentPage eq 1 ? 'disabled page-link' : 'page-link'}"
                                                        href="/admin/product?page=${currentPage-1}"
                                                        aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>

                                                <c:forEach var="index" begin="1" end="${totalPages}">
                                                    <li class="page-item">
                                                        <a class=" ${currentPage eq index  ? 'active page-link' : 'page-link'}"
                                                            href="/admin/product?page=${index}">
                                                            ${index}
                                                        </a>
                                                    </li>
                                                </c:forEach>

                                                <li class="page-item">
                                                    <a class="${currentPage eq  totalPages ? 'disabled page-link' : 'page-link'}"
                                                        href="/admin/product?page=${currentPage+1}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>

                                    </div>

                                </div>

                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />

                        <!-- Modal -->
                        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false"
                            tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header alert alert-danger">
                                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete Product
                                        </h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Close</button>
                                        <a type="button" href="#" class="btn btn-danger delete-confirm">Delete</a>
                                    </div>
                                </div>
                            </div>
                        </div>
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

                $(document).ready(function () {
                    var productId;
                    var btnClick;

                    $('.delete-product').click(function () {
                        productId = $(this).data('id');
                        console.log('Delete product with ID:', productId); // Add your deletion logic here
                        $('.modal-body').html("Are you sure you want to delete product id: " + productId + "?");
                        $('.delete-confirm').attr('href', '/admin/product/delete/' + productId);
                        $('#staticBackdrop').modal('show');
                    });

                });


            </script>


            </html>