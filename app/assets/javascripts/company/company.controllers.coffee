angular
	.module('company.controllers', [])
	.controller('CompanyShowCtrl', ['$scope', 'company', ($scope, company) ->
		$scope.company = company
	])
	.controller('CompanyEditCtrl', ['$scope', '$state', 'company', ($scope, $state, company) ->
		$scope.company = company

		$scope.save = () ->
			$scope.company.save().then((result) ->
				$state.go('company.show', {companyId: result.id})
			)
	])