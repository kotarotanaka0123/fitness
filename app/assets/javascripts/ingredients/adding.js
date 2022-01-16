document.addEventListener("turbolinks:load", function(){
    var $checkbox = $("input.checkbox").get(0);
    $checkbox.on('input', function(e){
        if($checkbox.checked){
            $(".col-3 ul#adding").append($checkbox.name); 
        } else {
            
        }
    })
});