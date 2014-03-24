# ready = ->
#   jQuery ->
#     jQuery("#f_elem_city").autocomplete
#       source: (request, response) ->
#         jQuery.getJSON "http://gd.geobytes.com/AutoCompleteCity?callback=?&filter=US&q=" + request.term, (data) ->
#           response data
#           return

#         return

#       minLength: 3
#       select: (event, ui) ->
#         selectedObj = ui.item
#         jQuery("#f_elem_city").val selectedObj.value
#         false

#       open: ->
#         jQuery(this).removeClass("ui-corner-all").addClass "ui-corner-top"
#         return

#       close: ->
#         jQuery(this).removeClass("ui-corner-top").addClass "ui-corner-all"
#         return

#     jQuery("#f_elem_city").autocomplete "option", "delay", 100
#     return

#   return

# $(document).ready ready
# $(document).on "page:load", ready