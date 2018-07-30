# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", -> 
	$('#csvDownloadBtn').click ->
		console.log ("redirecting")
		window.open "/requests/download.csv"
		setTimeout((-> location.reload()), 750)
	$(document).on "change", ->
		#alert($('#color input:checked').val())
		#alert($('#sides input:checked').val())
		#alert($('#collate :checked').val())
		#if ($('#collate').is(':checked'))
		#	alert($('#collate').is(':checked'))
		#alert($('#request_originals').val())
		if (document.getElementById("color"))
			$.ajax({
				url: "/costs/get_estimate",
				type: "GET",
				data: {
					pages: $('#request_originals').val(),
					copies: $('#request_copies').val(),
					color: $('#color input:checked').val(),
					sides: $('#sides input:checked').val(),
					weight: $('#weight option:selected').val(),
					binding: $('#binding option:selected').val(),
					size: $('#size option:selected').val(),
					folding: $('#folding option:selected').val(),
					collate: $('#collate').is(':checked'),
					staple: $('#staple').is(':checked'),
					threehole: $('#threehole').is(':checked'),
					laminate: $('#laminate').is(':checked'),
					clear_cover: $('#clear-cover').is(':checked'),
					black_back: $('#black-back').is(':checked')
				}
				dataType: 'json'
				#expect a decimal to be returned
				success: (data) ->
					console.log(data)
					$('#estimated-cost').html(data)
					$('#estimate').val(data)
			})	
		if (document.getElementById("total"))
			$('#total').text(
				(parseFloat($('#perPageTotal').text()) + 
				parseFloat($('#perJobTotal').text()) + 
				parseFloat($('#otherestimate').val())).toFixed(2))
