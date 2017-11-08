# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.BmgApp = { }

class BmgApp.BmgMap
	showCoordinates: =>
		popup = L.popup()

		onMapClick = (e) =>
		    popup
		        .setLatLng(e.latlng)
		        .setContent("You clicked the map at " + e.latlng.toString())
		        .openOn(@map)

		@map.on('click', onMapClick);

	showAddressAutoComplete: =>
		provider = new OpenStreetMapProvider()
		searchControl = new GeoSearchControl({ provider: provider })

		@map.addControl(searchControl);

	constructor: ->
		$('#map').height($(window).height() - 16)

		@map = L.map('map').setView([52.518, 13.407], 13)

		L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
		    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
		    maxZoom: 18,
		    id: 'mapbox.streets',
		    accessToken: 'pk.eyJ1IjoiYm1nLW1hcCIsImEiOiJjajlyMm5tamQ2NWRwMnFtcTR5Y2QwMW5sIn0.I6VW9O87epBW8Ndfk_0-zg'
		}).addTo(@map)

		@showCoordinates()
		@showAddressAutoComplete()