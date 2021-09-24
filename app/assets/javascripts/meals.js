// $( function() {
// 	$('#sampleButtonToggle').click( function () {
// 		$('#sampleModal').modal('toggle');
// 	});
// 	$('#sampleButtonToggle2').click( function () {
// 		$('#sampleModal').modal('toggle');
// 	});
// 	$('#sampleButtonShow').click( function () {
// 		$('#sampleModal').modal('show');
// 	});
// 	$('#sampleButtonHide').click( function () {
// 		$('#sampleModal').modal('hide');
// 	});
// });

function validation() {
    //エラーメッセージを表示する要素を変数化
    const mealNameError = document.getElementById("mealNameError");
    //フォームの値が入る要素を変数化
    const meal_name = document.getElementById("meal_name");
    //キーボード操作がされた時にイベント発火
    addEventListener("keyup", e => {
        if (meal_name.value == "") {
            mealNameError.style.visibility="visible";
        }else {
            mealNameError.style.visibility="hidden";
        }
    });
}

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

window.addEventListener("load", validation);
window.addEventListener("load", selectIngredients);
window.addEventListener("load", addIngredients);