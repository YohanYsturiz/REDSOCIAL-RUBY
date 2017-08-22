# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.snack = (options)->
  document.querySelector("#global-snackbar").MaterialSnackbar.showSnackbar(options)

window.loading = false

$(document).on "page:load page:fetch ready", ()->
  componentHandler.upgradeDom()
  $(".close-parent").on "click", (ev)->
    $(this).parent().slideUp()
  $("#notification").on "click", (ev)->
    #Si las notificaciones visibles, preventDefault() (no hagas lo que ibas a hacer)
    ev.preventDefault() if $("#notifications").hasClass("active")
    #Cambiamos el estado
    $("#notifications").toggleClass("active")
    #Si tiene la clase active es porque antes no la tenía
    #Si no la tiene es porque antes sí la tenía
    return $("#notifications").hasClass("active")
  $(".best_in_place").best_in_place()
  $(".mdl-layout").scroll ->
    if !window.loading && ($(".mdl-layout").scrollTop() > $(window).height() - 100)
      console.log("Cargando...")
      window.loading = true
      url = $(".next_page").attr("href")
      $.getScript url if url