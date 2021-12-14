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

function selectIngredients() {
    const modal_form = document.getElementById("meal_modal_form");
    const ingredientDivs = modal_form.querySelectorAll("div");
    const ingredients = document.getElementById("ingredients");
    const hiddenInput = document.getElementById("meal_ingredient_ids");

    ingredientDivs.forEach((element) => {
        const ingredientInput = element.querySelector("input");
        ingredientInput.addEventListener("change", e => {
            if(e.target.checked){
                let currentValue = hiddenInput.value
                hiddenInput.value = currentValue.concat(e.target.value, ',');
            }
        });
    });
}

function addIngredients() {
    const sendIngredients = document.getElementById("sendIngredients");

    sendIngredients.addEventListener("click", e => {
        $("#modalArea").find(".modal").modal("hide");
    });
}

window.addEventListener("load", selectIngredients);
window.addEventListener("load", addIngredients);

