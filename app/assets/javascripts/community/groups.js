function delete_modal() {
    $("#deleteModal").on("shown.bs.modal", function() {
        $("deleteMOdal").find(".modal-footer a").focus();
    });

    $("#deleteModal").modal("show");
}

// $(".inviteUser").on('click', function() {
//     $val = $(this).val();
//     $("#input_name_search").append($val);
// });

// ("button.invite").on("click", function() {
//     console.log("a");
// }

// NOTE: button.invite-user-btnという指定では反応しない。
$(".invite-user-btn").on('click', function() {
    $("#inviteModal").on("shown.bs.modal", function() {
        $("#inviteModal").find("#input_name_search").focus();
    });

    $("#inviteModal ul.list-group li").hide();
    $("#inviteModal").modal("show");
});

$(".input_name_search").on("keyup", function() {
    $.ajax({
        url: `/community/groups/${}`,
        data: { usernames: $(this).val() },
        dataType: 'json',
    }).done(function(data) {
        console.log(data);
    }).fail(function(data) {
        console.log(data);
    })
});