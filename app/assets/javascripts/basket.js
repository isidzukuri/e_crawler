;
$(function() {
  $(document).on("click", ".basket_remove", function() {
    if(!confirm('Are you sure?')) return false;
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