;
$(function() {

  $(document).on("click", ".copy_category", function() {
    url = $('input[name=url]').val();
    id = $('input[name=category_id]').val();
    if(url){
      $.get("/categories/copy_category/"+id, { url: url });
      alert('Your request added to queue');
      $('input[name=url]').val('');
    }
    return false;
  });
});