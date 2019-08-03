$(function () {
  //鼠标滚动超出侧边栏高度绝对定位
  var sidebar = $('.sidebar');
  var sidebarHeight = sidebar.height();

  $(window).scroll(function () {
    var windowScrollTop = $(window).scrollTop();

    if (windowScrollTop > sidebarHeight - 50) {
      $('.fixed').css({
        'position': 'fixed',
        'top': '70px',
        'width': '360px'
      });
    } else {
      $('.fixed').removeAttr("style");
    }
  });
});