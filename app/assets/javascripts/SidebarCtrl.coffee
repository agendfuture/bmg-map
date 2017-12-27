angular
	.module('sidebar.controller', [])
	.controller("SidebarCtrl", ['$scope', '$state', ($scope, $state) ->
		$scope.bmgMap.sidebar.on('closing', () ->
			$state.go('root')
		)
	])