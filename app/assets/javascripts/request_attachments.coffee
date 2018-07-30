# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", ":file", ->
	files = $(this).prop("files")
	names = $.map(files, (val) ->
		return val.name)
	$('#uploaded-files').html("<h5>"+names+"</h5>")