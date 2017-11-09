angular
  .module('marker.components', [])
  .component('markerInfoSidebar', {
	templateUrl: 'marker/_marker-info-sidebar.template.html',
	bindings: {
	  "current": "=ngModel"
	},
	controller: ['$scope', ($scope) ->
	]
  })