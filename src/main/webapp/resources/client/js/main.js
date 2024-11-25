(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



    // Product Quantity
    $('.quantity button').on('click', function () {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();
        var productId = button.parent().parent().parents('tr').find("td:eq(0)").text();
        var priceUnit = button.parent().parent().parents('tr').find("td:eq(2) p").text().trim().replace(/đ|,/g, '');;
        var priceNumber = parseFloat(priceUnit);
        console.log(productId);
        if (button.hasClass('btn-plus')) {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
            }
        }

        $.ajax({
            type: "POST",
            url: "/add-product-to-cart",
            timeout: 100000,
            cache: false,
            async: false,
            data: {
                productId: productId,
                quantity: newVal
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            complete: function () {

            },
            success: function (data) {

                console.log(data);
                if (data === "success") {

                    //alert("Successfully deleted");
                    button.parent().parent().find('input').val(newVal);
                    console.log("unit: " + priceNumber + "newVal: " + newVal);
                    var productPrice = priceNumber * newVal;
                    var formatTotalPrice = productPrice.toLocaleString();
                    button.parent().parent().parents('tr').find("td:eq(4) p").html(formatTotalPrice + " đ");
                    var newTotalPrice = 0;

                    $('.cart-Detail tbody tr').each(function () {
                        var newProductPrice = $(this).find("td:eq(4) p").text().replace(/đ|,|\n/g, '').trim();
                        newTotalPrice += parseFloat(newProductPrice);
                    });
                    var formatNewTotalPrice = newTotalPrice.toLocaleString();
                    $('.total-price').html(formatNewTotalPrice + " đ");
                    $("#liveToastAdd").toast("show");
                } else {
                    alert("Failed to delete");
                }

            },
            error: function (e) {
                alert("Error:: failed to delete!!");
                console.log("ERROR: ", e);
            },
            done: function (e) {

            }
        });
    });

    // Product Quantity
    $('.delete-product').on('click', function () {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var button = $(this);
        var productId = button.parents('tr').find("td:eq(0)").text();

        $.ajax({
            type: "POST",
            url: "/delete-product-in-cart",
            timeout: 100000,
            cache: false,
            async: false,
            data: {
                productId: productId
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            complete: function () {

            },
            success: function (data) {

                console.log(data);
                if (data === "success") {

                    button.parents('tr').remove();
                    var newTotalPrice = 0;

                    $('.cart-Detail tbody tr').each(function () {
                        var newProductPrice = $(this).find("td:eq(4) p").text().replace(/đ|,|\n/g, '').trim();
                        newTotalPrice += parseFloat(newProductPrice);
                    });
                    var formatNewTotalPrice = newTotalPrice.toLocaleString();
                    $('.total-price').html(formatNewTotalPrice + " đ");
                    $("#liveToastDel").toast("show");
                } else {
                    alert("Failed to delete");
                }

            },
            error: function (e) {
                alert("Error:: failed to delete!!");
                console.log("ERROR: ", e);
            },
            done: function (e) {

            }
        });
    });

})(jQuery);

