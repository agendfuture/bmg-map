angular
	.module('map.controller', [])
	.controller("MapCtrl", ['MapFactory', 'Marker', '$rootScope', '$stateParams', (Map, Marker, $rootScope, $stateParams) ->
		if ($("#map").length)
			$rootScope.bmgMap = new Map

			$rootScope.loading = true

			Marker.query().then( (markers) ->
				$rootScope.bmgMap.initializeMarkers(markers)
				$rootScope.bmgMap.setCompanyLayerVisible($stateParams.companyId)

				$rootScope.loading = false
			)
	])