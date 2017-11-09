angular
	.module('map.controller', [])
	.controller("MapCtrl", ['MapFactory', 'MarkerFactory', '$scope', (Map, Marker, $scope) ->
		if ($("#map").length)
			$scope.bmgMap = new Map

			Marker.load( (markers) ->
				$scope.bmgMap.initializeMarkers(markers)
			)
	])