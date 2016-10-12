;
$(function() {

  $(document).on("click", ".copy_category", function() {
    button = $(this);
    button.hide().next().removeClass('hidden');

    url = $('input[name=url]').val();
    id = $('input[name=category_id]').val();
    if(url){
      $.get("/categories/copy_category/"+id, { url: url } , function(){
        $('input[name=url]').val('');
        button.show().next().addClass('hidden');
        alert("Import completed. You can check new items on a category's page")
      });
    }
    return false;
  });
});