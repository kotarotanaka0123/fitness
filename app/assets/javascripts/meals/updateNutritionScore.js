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
            })
        }
    });
});

