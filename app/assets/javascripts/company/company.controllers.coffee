angular
	.module('company.controllers', [])
	.controller('CompanyShowCtrl', ['$scope', 'company', ($scope, company) ->
		$scope.bmgMap.sidebar.open('company-info')

		$scope.company = company
	])
	.controller('CompanyEditCtrl', ['$scope', '$state', 'company', ($scope, $state, company) ->
		$scope.bmgMap.sidebar.open('company-info')

		$scope.company = company

		$scope.save = () ->
			$scope.company.save().then((result) ->
				$state.go('company.show', {companyId: result.id})
			)
	])