# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
	$('#category-select').change ->
		categorySelected = $('#category-select').val()
		if categorySelected is "New Category"
			$('#new-category').show()
		else
			$('#new-category').hide()
			$('#new-category-text').val(categorySelected)
	# initialize the ability to use bootstrap popovers
	$('[data-toggle="popover"]').hover().popover()
	#modal?
		
