function delete_modal(group_id) {
    $(`#deleteModal${group_id}`).on("shown.bs.modal", function() {
        $(`#deleteModal${group_id}`).find(".modal-footer a").focus();
    });

    $(`#deleteModal${group_id}`).modal("show");
}

function join_modal(group_id) {
    $(`#joinModal${group_id}`).on("shown.bs.modal", function() {
        $(`#joinModal${group_id}`).find(".modal-footer a").focus();
    });

    $(`#joinModal${group_id}`).modal("show");
}

//NOTE: 検索したユーザの一覧を表示する機能
document.addEventListener("turbolinks:load", function(){
    $(".input_name_search").on("input", function() {
        $.ajax({
            url: "/community/groups/userlist",
            data: { usernames: $(this).val(), group_id: $(this).data("id") },
            dataType: 'json',
        }).done(function(data) {
            let $user_list = document.getElementById(`user_list${data.group_id}`);
            if($user_list.hasChildNodes()) {
                var clone = $user_list.cloneNode(false); // ulだけ複製
                $user_list.parentNode.replaceChild(clone, $user_list);
            }
            $user_list.insertAdjacentHTML('afterbegin', data.html_data);
        }).fail(function(data) {
            // TODO: 失敗した場合
        })
    });
});

//NOTE: 選択したユーザを表示する機能
document.addEventListener("turbolinks:load", function() {
    $(document).on("click", ".user_to_invite", function() {
        $.ajax({
            url: "/community/groups/invite_users",
            data: { invite_user: $(this).text(), group_id: $(this).data("id") },
            dataType: 'json',
        }).done(function(data){
            let $checked_users = document.getElementById(`checked_users${data.group_id}`);
            $checked_users.insertAdjacentHTML('beforeend', data.html_data);
        }).fail(function(data) {
            // TODO: 失敗した場合
        })
    });
});

//NOTE: 選択した招待ユーザを削除する機能
document.addEventListener("turbolinks:load", function() {
    $(document).on("click", ".delete_checked_user", function() {
        $(this).parent().parent().remove();
    });
});

//NOTE: 選択したユーザに実際に招待を送る機能
document.addEventListener("turbolinks:load", function() {
    $("button.invite").on('click', function() {
        let userIdList = [];
        let group_id = $(this).data("id");
        $(`#checked_users${group_id}`).children().each(function(index, element){
            userIdList.push(element.classList[1]);
        });
        if (userIdList.length != 0) {
            $.ajax({
                url: "/community/groups/invite_users",
                type: "POST",
                data: { 
                    userlist: userIdList,
                    group_id: group_id
                },
                dataType: "json"
            }).done(function(){
                $(`#inviteModal${group_id}`).modal("hide");
            }).fail(function(){
                // TODO: 失敗したときの処理
            })
        } else {
            //　何もしない
        }
    });
});