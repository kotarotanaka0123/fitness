document.addEventListener("turbolinks:load", function(){
    $("#ingredient_entry_quantity").on('input', function(e) {
        e.preventDefault();
        var count = $(this).val();
        var $nutri = $("table#nutrition-facts tr td.col-2");
        $nutri.each(function(i, val){
            $(this).prepend(gon.columns[i]*count);
        });
    });
});

