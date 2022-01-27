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

