$(function(){
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

    var ias = $.ias({
        container: ".article-wrap",
        item: ".article",
        pagination: ".pagination",
        next: ".next-page a"
    });


    ias.extension(new IASSpinnerExtension({src: '/loading.gif'}));
    ias.extension(new IASTriggerExtension({}));
    ias.extension(new IASNoneLeftExtension({text: '到底了。。。'}));

});