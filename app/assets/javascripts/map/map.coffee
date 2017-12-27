angular
	.module('map', ['map.controller'])
  	.factory("MapFactory", ['Marker', '$state', (Marker, $state) ->
		class Map
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
						callback: @createMarker
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

				$('#map').height($(window).height())

				@map = L.map('map', config).setView([52.518, 13.407], 13)

				L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
					attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
					maxZoom: 18,
					id: 'mapbox.streets',
					accessToken: 'pk.eyJ1IjoiYm1nLW1hcCIsImEiOiJjajlyMm5tamQ2NWRwMnFtcTR5Y2QwMW5sIn0.I6VW9O87epBW8Ndfk_0-zg'
				}).addTo(@map)

				@sidebar = L.control.sidebar('sidebar-right', {
					position: 'right',
					closeButton: true
				}).addTo(@map)

				@map.on('click', =>
					@sidebar.close()
				)

				@showAddressAutocomplete()

			showAddressAutocomplete: =>
				provider = new BmgApp.LeafletGeosearch.OpenStreetMapProvider()
				searchControl = new BmgApp.LeafletGeosearch.GeoSearchControl({
					provider: provider,
					style: 'bar'
				})

				@map.addControl(searchControl);

			addMarkerToMap: (marker) =>
				m = L.marker(marker).addTo(@map).on('click', =>
					$state.go('marker.show', { markerId: marker.id })
				)

			createMarker: (marker) =>
				new Marker({lng: marker.latlng.lng, lat: marker.latlng.lat}).save().then((marker) =>
					@addMarkerToMap(marker)
				)

			initializeMarkers: (markers) =>
				_.each(markers, @addMarkerToMap)

			showCoordinates: (e) ->
				alert(e.latlng)

			centerMap: (e) =>
				@map.panTo(e.latlng)

			zoomIn: (e) =>
				@map.zoomIn()

			zoomOut: (e) =>
				@map.zoomOut()
	])

