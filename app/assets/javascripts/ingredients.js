function show_ing_modal() {
    document.getElementById("ing-select").addEventListener('click', function() {
        $("#modalArea").find(".modal").on("shown.bs.modal", () => {
            $("#modalArea").find(".modal").focus();
        });
            
        $("#modalArea").find(".modal").modal('show'); 
    });
}

// function selectIngredients() {
//     const modal_form = document.getElementById("meal_modal_form");
//     const ingredientLists = modal_form.querySelectorAll("li");
//     const ingredients = document.getElementById("ingredients");
//     const hiddenInput = document.getElementById("meal_ingredient_ids");

//     ingredientLists.forEach((element) => {
//         const ingredientInput = element.querySelector("input");
//         var checkedOption = element.querySelector('select').querySelector('option[selected="selected"]');
//         ingredientInput.addEventListener("change", e => {
//             if(e.target.checked){
//                 let currentValue = hiddenInput.value
//                 hiddenInput.value = currentValue.concat(e.target.value, ',', checkedOption.value, ':');
//             }
//         });
//     });
// }

function set_ingredient_count() {
    const modal_form = document.getElementById("meal_modal_form");
    const ingredientLists = modal_form.querySelectorAll("li");
    ingredientLists.forEach((element) => {
        var selectBox = element.querySelector('select');
        selectBox.addEventListener('change', function(e){
            selectBox.querySelector('option[selected="selected"]').removeAttribute("selected");
            selectBox.querySelector(`option[value="${e.target.value}"]`).setAttribute("selected", "selected");
        });
    });
}

function addIngredients() {
    document.getElementById("sendIngredients").addEventListener('click', e => {
        var sendIngLists = []; // [[材料ID, 個数], [...]]
        var sendIng = []; // [材料ID, 個数]

        const modal_form = document.getElementById("meal_modal_form");
        const ingredientLists = modal_form.querySelectorAll("li");
        ingredientLists.forEach((element) => {
            const ingredientInput = element.querySelector("input");
            if (ingredientInput.checked) {
                sendIng.push(Number(element.querySelector('input').value));
                sendIng.push(Number(element.querySelector('option[selected="selected"]').value));
                sendIngLists.push(sendIng);
                // NOTE:　からにする
                sendIng = [];
            } else {
                // 何もしない
            }
        });
        $("#modalArea").find(".modal").modal("hide");

        $.ajax({
            url: "/ingredients/addToMeal",
            data: { ingredients_ids: sendIngLists },
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

// function addIngredients() {
//     const sendIngredients = document.getElementById("sendIngredients");

//     sendIngredients.addEventListener("click", e => {
//         const modal_form = document.getElementById("meal_modal_form");
//         const ingredientLists = modal_form.querySelectorAll("li");
//         // NOTE: 追加するタイミングで全てのチェックを外す。
//         ingredientLists.forEach((element) => {
//             const ingredientInput = element.querySelector("input");
//             ingredientInput.checked = false
//         });
//         $("#modalArea").find(".modal").modal("hide");

//         var ing_ids = document.getElementById("meal_ingredient_ids");
//         var ing_ids_lists = ing_ids.value.split(":").slice(0, -1).map(function(item) {
//             return item.split(",").map(Number);
//         });

//         $.ajax({
//             url: "/ingredients/addToMeal",
//             data: { ingredients_ids: ing_ids_lists },
//             dataType: 'json',
//         }).done(function(data) {
//             let meal_protein = document.getElementById("meal_protein");
//             let meal_carbon = document.getElementById("meal_carbon");
//             let meal_fat = document.getElementById("meal_fat");
//             meal_protein.value = Number(meal_protein.value) + Number(data.protein);
//             meal_carbon.value = Number(meal_carbon.value) + Number(data.carbon);
//             meal_fat.value = Number(meal_fat.value) + Number(data.fat);

//             ing_ids.value = ""
//         }).fail(function(data) {
//             // TODO: 失敗した場合
//         })
//     });
// }


// window.addEventListener("load", selectIngredients);
window.addEventListener("load", set_ingredient_count);
window.addEventListener("load", addIngredients);
window.addEventListener("turbolinks:load", show_ing_modal);

