// window.onload = function() {
//     $(".ingredient").on({
//         mouseenter: function() {
//             $("#modal1").modal("hide");
//             $("#modal2").modal("show");
//         },
//         mouseleave: function() {
//             $("#modal2").modal("hide");
//             $("#modal1").modal("show");
//         }
//     });
// }

function show_ing_modal() {
    document.getElementById("ing-select").addEventListener('click', function() {
        $("#modalArea").find(".modal").on("shown.bs.modal", () => {
            $("#modalArea").find(".modal").focus();
        });
            
        $("#modalArea").find(".modal").modal('show'); 
    });
}

function selectIngredients() {
    const modal_form = document.getElementById("meal_modal_form");
    const ingredientLists = modal_form.querySelectorAll("li");
    const ingredients = document.getElementById("ingredients");
    const hiddenInput = document.getElementById("meal_ingredient_ids");

    ingredientLists.forEach((element) => {
        const ingredientInput = element.querySelector("input");
        ingredientInput.addEventListener("change", e => {
            if(e.target.checked){
                let currentValue = hiddenInput.value
                hiddenInput.value = currentValue.concat(e.target.value, ',');
            }
        });
    });
}

// function ingredient_count() {
//     document.getElementById("")
// }

function addIngredients() {
    const sendIngredients = document.getElementById("sendIngredients");

    sendIngredients.addEventListener("click", e => {
        $("#modalArea").find(".modal").modal("hide");

        var ing_ids = document.getElementById("meal_ingredient_ids");
        var ing_ids_lists = ing_ids.value.split(",").map(Number).slice(0, -1);

        $.ajax({
            url: "/ingredients/addToMeal",
            data: { ingredients_ids: ing_ids_lists },
            dataType: 'json',
        }).done(function(data) {
            let meal_protein = document.getElementById("meal_protein");
            let meal_carbon = document.getElementById("meal_carbon");
            let meal_fat = document.getElementById("meal_fat");
            meal_protein.value = Number(meal_protein.value) + Number(data.protein);
            meal_carbon.value = Number(meal_carbon.value) + Number(data.carbon);
            meal_fat.value = Number(meal_fat.value) + Number(data.fat);
        }).fail(function(data) {
            // TODO: 失敗した場合
        })
    });
}
window.addEventListener("load", selectIngredients);
window.addEventListener("load", addIngredients);
window.addEventListener("turbolinks:load", show_ing_modal);

