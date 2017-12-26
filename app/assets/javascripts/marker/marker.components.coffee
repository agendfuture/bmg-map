angular
  .module('marker.components', ['marker.controllers'])
  .component('markerShow', {
	templateUrl: 'marker/marker.show.html',
	bindings: {
	  "current": "=ngModel"
	},
	controller: 'MarkerShowCtrl'
  })