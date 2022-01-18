function delete_modal() {
    $("#deleteModal").on("shown.bs.modal", function() {
        $("deleteMOdal").find(".modal-footer a").focus();
    });

    $("#deleteModal").modal("show");
}
