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

		$scope.marker.$landlord = marker.currentLandlord()
		$scope.marker.$owner = marker.currentOwner()

		$scope.setCompany = (item, is_landlord) ->
			$scope.marker.companies.push(_.extend(item, {
				changedResponsibilityAt: new Date(),
				owned: !is_landlord,
				companies_marker_id: null
			}))

		$scope.save = () ->
			$scope.marker.save().then((result) ->
				$state.go('marker.show', {markerId: result.id})
			)

		$scope.trustAsHtml = (value) ->
  			$sce.trustAsHtml(value)
	])