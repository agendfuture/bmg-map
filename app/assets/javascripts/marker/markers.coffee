# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular
	.module('marker', ['marker.components', 'marker.controllers'])
	.factory("Marker", ['RailsResource', 'railsSerializer', (RailsResource, railsSerializer) ->
		class Marker extends RailsResource
			currentOwner: =>
				_.chain(@companies).where({ owned: true }).sortBy('changedResponsibilityAt').last().value()

			currentLandlord: =>
				_.chain(@companies).where({ owned: false }).sortBy('changedResponsibilityAt').last().value()

			@configure({
				url: '/markers',
				name: 'marker',
				serializer: railsSerializer( () ->
					@resource('companies', 'Company')
					@add('company_ids', (marker) ->
            			_.pluck(marker.companies, 'id')
        			)
				)
			})
	])
