angular
	.module('sidebar.controller', [])
	.controller("SidebarCtrl", ['$scope', '$state', ($scope, $state) ->
		$scope.current = {marker: undefined, name: "test"}
		$scope.$on('marker.open', (e, marker) ->
			$state.go('marker.show', { markerId: marker.id })
		)
	])