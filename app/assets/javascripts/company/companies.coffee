# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular
	.module('company', [])
	.factory("Company", ['RailsResource', (RailsResource) ->
		class Company extends RailsResource
			@configure({
				url: '/companies',
				name: 'company'
			})

			constructor: () ->

	])
