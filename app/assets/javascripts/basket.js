;
$(function() {
  $(document).on("click", ".basket_remove", function() {
    var button = $(this);
    var id = button.data('id');
    $.get("basket/remove/"+id, function() {
      button.parent().remove();
    });
    return false;
  });

  $(document).on("click", ".basket_add", function() {
    var id = $(this).data('id');
    $.get("/basket/add/"+id);
    return false;
  });
});