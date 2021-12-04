$(document).on('input', 'input#food_entry_quantity', function(e) {
    e.preventDefault();
    var count = $(this).val();
    var $nutri = $("table#nutrition-facts tr td.col-2");
    $nutri.each(function(i, val){
        $(this).text(Number($(val).text())*count);
    });
});

//changeイベントが効かない

