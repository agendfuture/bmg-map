angular
	.module('sidebar.controller', [])
	.controller("SidebarCtrl", ['$scope', ($scope) ->
		$scope.current = {marker: undefined, name: "test"}
		$scope.$on('marker.open', (e, marker) ->
			$scope.current.marker = marker
			$scope.$apply()
		)
	])