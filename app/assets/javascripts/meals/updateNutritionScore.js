document.addEventListener("turbolinks:load", function(){
    $("#meal_entry_quantity").on('input', function(e) {
        e.preventDefault();
        var count = $(this).val();
        if(count!=""){
            var meal_id = document.querySelector("li.field input").getAttribute("data-id");
            $.ajax({
                url: '/meals/update_nutrition_score',
                data: { meal_id: meal_id,
                        count: count
                    },
                dataType: 'json'
            }).done(function(data) {
                $.each($("table#nutrition-facts tbody tr td.col-2"), function(i, val) {
                    var removedNutritionScore = $(val).text().replace(/[0-9]|\./g, "");
                    $(val).text(removedNutritionScore);
                    $(val).prepend(data.columns[i]*data.count);
                });
            })
        }
    });
});

