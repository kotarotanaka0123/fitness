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

