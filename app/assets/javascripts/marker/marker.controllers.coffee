angular
	.module('marker.controllers', [])
	.controller('MarkerIndexCtrl', ['$scope', 'Marker', ($scope, Marker) ->

		Marker.query().then((markers) ->
			$scope.markers = markers
		)
	])
	.controller('MarkerShowCtrl', ['$scope', 'marker', ($scope, marker) ->
		$scope.marker = marker
	])
	.controller('MarkerEditCtrl', ['$scope', '$state', '$sce', 'marker', 'companies', ($scope, $state, $sce, marker, companies) ->
		$scope.marker = marker
		$scope.companies = companies

		$scope.save = () ->
			$scope.marker.save().then((result) ->
				$state.go('marker.show', {markerId: result.id})
			)

		$scope.trustAsHtml = (value) ->
  			$sce.trustAsHtml(value)
	])