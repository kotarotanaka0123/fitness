function delete_modal() {
    $("#deleteModal").on("shown.bs.modal", function() {
        $("deleteMOdal").find(".modal-footer a").focus();
    });

    $("#deleteModal").modal("show");
}

function invite_modal() {
    $("#inviteModal").on("shown.bs.modal", function() {
        $("#inviteModal").find("#input_name_search").focus();
    });

    // $("#inviteModal ul.list-group li").hide();
    $("#inviteModal").modal("show");
}

$(".inviteUser").on('click', function() {
    $val = $(this).val();
    $("#input_name_search").append($val);
});

$("button.invite").on("click", function() {
    // TODO: ajaxで招待機能を実装する。
});