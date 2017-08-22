$('#user-avatar .circle').css
    "background-image": "url(<%= @user.avatar.url(:medium) %>)"
$('#user-cover').css
    "background-image": "url(<%= @user.cover.url(:medium) %>)"
    "background-position": "center"