# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class BmgApp.Marker
	@url: "markers"
	@markers: []

	constructor: (coordinates) ->
		@coordinates = coordinates

	save: =>
		$.ajax({
		  type: "POST",
		  url: BmgApp.Marker.url,
		  data: {
		  	marker: {
		  		lat: @coordinates.lat,
		  		lng: @coordinates.lng
		  	}
		  },
		  #success: success,
		  dataType: "json"
		})

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