angular
	.module('map.controller', [])
	.controller("MapCtrl", ['MapFactory', 'Marker', '$rootScope', (Map, Marker, $rootScope) ->
		if ($("#map").length)
			$rootScope.bmgMap = new Map

			Marker.query().then( (markers) ->
				$rootScope.bmgMap.initializeMarkers(markers)
			)
	])