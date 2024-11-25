<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Dashboard - Hỏi Dân IT</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Orders</li>
                                    </ol>
                                    <h1>Order page</h1>

                                </div>
                                <div class="col-md-12 col-xs-12 mx-auto p-3">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">Hình ảnh</th>
                                                <th scope="col">Sản Phẩm</th>
                                                <th scope="col">Giá</th>
                                                <th scope="col">Số Lượng</th>
                                                <th scope="col">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="orderDetail" items="${orderDetails}">
                                                <tr>
                                                    <td scope="row"><img
                                                            style="width: 50px; height: 50px; border-radius: 50%; overflow: hidden;"
                                                            src="/images/product/${orderDetail.product.image}" /></td>

                                                    <td><a
                                                            href="/admin/product/${orderDetail.product.id}">${orderDetail.product.name}</a>
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber type="number"
                                                            value="${orderDetail.product.price}" />
                                                        đ
                                                    </td>
                                                    <td>
                                                        ${orderDetail.quantity}
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber type="number"
                                                            value="${orderDetail.product.price * orderDetail.quantity}" />
                                                        đ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <a href="/admin/order" class="btn btn-primary">Back</a>
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

                </html>