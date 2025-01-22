$(document).on('turbolinks:load', function() {
  $('.navbar-toggler').on('click', function(event) {
    // ナビゲーションリンク全体を制御
    $('#navbarNav').fadeToggle();
    event.preventDefault();
  });
});
