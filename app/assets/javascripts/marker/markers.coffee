# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular
	.module('marker', ['marker.components', 'marker.controllers'])
	.factory("Marker", ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
		class Marker extends RailsResource
			@configure({
				url: '/markers',
				name: 'marker',
				serializer: railsSerializer( () ->
					@resource('company', 'Company')
					@add('company_ids', (marker) ->
            			marker.company.id
        			)
				)
			})

			@url: "markers"
			@markers: []

			# save: =>
			# 	$.ajax({
			# 		type: "POST",
			# 		url: Marker.url,
			# 		data: {
			# 			marker: {
			# 				lat: @coordinates.lat,
			# 				lng: @coordinates.lng
			# 			}
			# 		},
			# 		success: (response) =>
			# 			angular.extend(@, response)
			# 		,
			# 		dataType: "json"
			# 	})

			@load: (success) ->
				$.ajax({
					type: "GET",
					url: @url
					success: (response) ->
						@markers = response
						success(@markers)
					,
					dataType: "json"
				});
	])
