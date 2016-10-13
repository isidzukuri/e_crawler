;
$(function() {

  $(document).on("click", ".copy_category", function() {
    button = $(this);
    button.hide().next().removeClass('hidden');

    url = $('input[name=url]').val();
    id = $('input[name=category_id]').val();
    if(url){
      $.get("/categories/copy_category/"+id, { url: url } , function(data){
        console.log(data);
        $('input[name=url]').val('');
        button.show().next().addClass('hidden');

        if(data['status']){
          message = "Import completed. You can check new items on a category's page";
        }else{
          message = data['error'];
        }
        alert(message);
      });
    }
    return false;
  });
});