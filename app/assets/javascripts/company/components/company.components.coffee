angular
  .module('company.components', [])
  .component('companiesList', {
	templateUrl: 'company/components/companies.list.html',
	bindings: {
	  "companies": "=ngModel"
	}
  })