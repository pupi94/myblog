$(function(){
    //页面加载
    $('body').show();
    $('.version').text(NProgress.version);
    NProgress.start();
    setTimeout(function () {
        NProgress.done();
        $('.fade').removeClass('out');
    }, 1000);

    //页面加载时给img和a标签添加draggable属性
    (function () {
        $('img').attr('draggable', 'false');
        $('a').attr('draggable', 'false');
    })();
     
    //导航智能定位
    $.fn.navSmartFloat = function () {
        var position = function (element) {
            var top = element.position().top,
                pos = element.css("position");
            $(window).scroll(function () {
                var scrolls = $(this).scrollTop();
                if (scrolls > top) { //如果滚动到页面超出了当前元素element的相对页面顶部的高度
                    $('.header-topbar').fadeOut(0);
                    if (window.XMLHttpRequest) { //如果不是ie6
                        element.css({
                            position: "fixed",
                            top: 0
                        }).addClass("shadow");
                    } else { //如果是ie6
                        element.css({
                            top: scrolls
                        });
                    }
                } else {
                    $('.header-topbar').fadeIn(500);
                    element.css({
                        position: pos,
                        top: top
                    }).removeClass("shadow");
                }
            });
        };
        return $(this).each(function () {
            position($(this));
        });
    };
     
    //启用导航定位
    $("#navbar").navSmartFloat();
     
    //返回顶部按钮
    $("#gotop").hide();
    $(window).scroll(function () {
        if ($(window).scrollTop() > 100) {
            $("#gotop").fadeIn();
        } else {
            $("#gotop").fadeOut();
        }
    });
    $("#gotop").click(function () {
        $('html,body').animate({
            'scrollTop': 0
        }, 500);
    });
     
    //无限滚动反翻页
    jQuery.ias({
        history: false,
        container : '.content',
        item: '.excerpt',
        pagination: '.pagination',
        next: '.next-page a',
        trigger: '查看更多',
        loader: '<div class="pagination-loading"><img src="/Home/images/loading.gif" /></div>',
        triggerPageThreshold: 5,
        onRenderComplete: function() {
            $('.excerpt .thumb').lazyload({
                placeholder: '/Home/images/occupying.png',
                threshold: 400
            });
            $('.excerpt img').attr('draggable','false');
            $('.excerpt a').attr('draggable','false');
        }
    });
     
    //鼠标滚动超出侧边栏高度绝对定位
    $(window).scroll(function () {
      var sidebar = $('.sidebar');
      var sidebarHeight = sidebar.height();
      var windowScrollTop = $(window).scrollTop();
      if (windowScrollTop > sidebarHeight - 60 && sidebar.length) {
        $('.fixed').css({
            'position': 'fixed',
            'top': '70px',
            'width': '360px'
        });
      } else {
        $('.fixed').removeAttr("style");
      }
    });
})