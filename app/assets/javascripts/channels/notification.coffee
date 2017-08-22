App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    if data.action == "new_notification"
      console.log('NUEVA NOTIFICACION')
      snack(
        message: "Tienes una nueva notificación"
        timeout:4000
      )
      $("#notification").html(data.message)