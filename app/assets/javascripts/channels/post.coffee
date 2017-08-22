App.post = App.cable.subscriptions.create "PostChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    if data.action == "new_post"
      $("#posts .data").prepend(data.message)