# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "turbolinks:load", ->
	$('button[id="setfocus"]').click ->
		cost_id = $(this).find('#cost_id').val()
		$.ajax({
			url: 'costs/'+cost_id+'/cost_dependencies/',
			type: 'GET',
			data: {cost_id: cost_id},
			dataType: 'html',
			success: (data) -> 
				dependencies = $($.parseHTML(data)).find("#dependency_modal")
				$('#cost_dependencies_modal').html(dependencies)
		})
	$('button[id="newdependency"]').click ->
		cost_id = $(this).find('#cost_id').val()
		$.ajax({
			url: 'costs/'+cost_id+'/cost_dependencies/new',
			type: 'GET',
			data: {cost_id: cost_id},
			dataType: 'html',
			success: (data) -> 
				dependencyform = $($.parseHTML(data)).find("#new_dependency_modal")
				$('#new_cost_dependency_modal').html(dependencyform)
		})


	$(document).on 'change', '#dependency-category-select', ->
		dependencyCategorySelect = $('#dependency-category-select').val()
		if dependencyCategorySelect is "New Category"
			$('#new-dependency-category').show()
			$('#dependency-option-select').val("New Option").change()
		else
			$('#new-dependency-category').hide()
			$('#new-dependency-category-text').val(dependencyCategorySelect)
		$.ajax({
			url:"/costs/populate_options",
			type: "GET",
			data:{category: $(this).val()},
			dataType: 'json',
			success: (data) ->
				$('#dependency-option-select').children().remove()
				$.each(data, (key, value) ->
					$('#dependency-option-select').append($('<option>', {
						value: value,
						text: value
					}))
					$('#new-dependency-option-text').val(value)
				)
				$('#dependency-option-select').append($('<option>', {
					value: "New Option",
					text: "New Option"
					})
				)
			})

	$(document).on 'change', '#dependency-option-select', ->
		dependencyOptionSelect = $('#dependency-option-select').val()
		if dependencyOptionSelect is "New Option"
			$('#new-dependency-option').show()
		else
			$('#new-dependency-option').hide()
			$('#new-dependency-option-text').val(dependencyOptionSelect)

