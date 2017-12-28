angular
  .module('marker.components', ['marker.controllers'])
  .component('markersList', {
	templateUrl: 'marker/components/markers.list.html',
	bindings: {
	  "markers": "=ngModel"
	}
  })