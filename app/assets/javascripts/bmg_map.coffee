# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.BmgApp = { }

class BmgApp.BmgMap
	constructor: ->
		config = {
			contextmenu: true,
			contextmenuWidth: 140,
			contextmenuItems: [{
				text: 'Show coordinates',
				callback: @showCoordinates
			}, {
				text: 'Center map here',
				callback: @centerMap
			}, {
				text: 'add Marker',
				callback: @addMarkerToMap
			}, '-', {
				text: 'Zoom in',
				#icon: 'images/zoom-in.png',
				callback: @zoomIn
			}, {
				text: 'Zoom out',
				#icon: 'images/zoom-out.png',
				callback: @zoomOut
			}]
		}

		$('#map').height($(window).height() - 16)

		@map = L.map('map', config).setView([52.518, 13.407], 13)

		L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
			maxZoom: 18,
			id: 'mapbox.streets',
			accessToken: 'pk.eyJ1IjoiYm1nLW1hcCIsImEiOiJjajlyMm5tamQ2NWRwMnFtcTR5Y2QwMW5sIn0.I6VW9O87epBW8Ndfk_0-zg'
		}).addTo(@map)

		#@showCoordinates()
		@showAddressAutocomplete()



	# showCoordinates: =>
	#   popup = L.popup()

	#   createButton = (label, container) ->
	#       btn = L.DomUtil.create('button', '', container)
	#       btn.setAttribute('type', 'button')
	#       btn.innerHTML = label
	#       btn

	#   onMapClick = (e) =>
	#       container = L.DomUtil.create('div')
	#       label = L.DomUtil.create('span', '', container)
	#       label.innerHTML = "You clicked the map at " + e.latlng.toString()
	#       addMarkerBtn = createButton('Einen Eintrag hinzufügen', container)

	#       L.DomEvent.on(addMarkerBtn, 'click', @addMarker)

	#       popup
	#           .setLatLng(e.latlng)
	#           #.setContent("You clicked the map at " + e.latlng.toString())
	#           .setContent(container)
	#           .openOn(@map)

	#   @map.on('click', onMapClick);

	showAddressAutocomplete: =>
		provider = new BmgApp.LeafletGeosearch.OpenStreetMapProvider()
		searchControl = new BmgApp.LeafletGeosearch.GeoSearchControl({
			provider: provider,
			style: 'bar'
		})

		@map.addControl(searchControl);

	addMarkerToMap: (marker) =>
		m = L.marker(marker.latlng).addTo(@map)
		new BmgApp.Marker(marker.latlng).save()

	initializeMarkers: (markers) =>
		_.each(markers, (marker) =>
			m = L.marker(marker).addTo(@map)
			m.bindPopup("<b>Name: "+ marker.name + "</b><br>Beschreibung: " + marker.description + "<br><br>Koordinaten:<br>" + marker.lat + " LAT, " + marker.lng + " LNG")
		)

	showCoordinates: (e) ->
		alert(e.latlng)

	centerMap: (e) =>
		@map.panTo(e.latlng)

	zoomIn: (e) =>
		@map.zoomIn()

	zoomOut: (e) =>
		@map.zoomOut()