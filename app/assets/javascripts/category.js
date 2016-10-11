;
$(function() {
  // $(document).on("click", ".basket_remove", function() {
  //   if(!confirm('Are you sure?')) return false;
  //   var button = $(this);
  //   var id = button.data('id');
  //   $.get("basket/remove/"+id, function() {
  //     button.parent().remove();
  //   });
  //   return false;
  // });

  $(document).on("click", ".copy_category", function() {
    url = $('input[name=url]').val();
    id = $('input[name=category_id]').val();
    
    if(url){
      // add category id to request
      $.get("/categories/copy_category/"+id, { url: url });
    }

    // var id = $(this).data('id');
    // $.get("/basket/update/"+id);
    return false;
  });
});