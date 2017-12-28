# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# // or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // compiled file.
# //
# // Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# // about supported directives.
# //
#= require jquery3
#= require popper
#= require bootstrap-sprockets
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require underscore/underscore
#= require angular/angular
#= require angular-rails-templates
#= require @uirouter/angularjs/lib/index
#= require angularjs-rails-resource/angularjs-rails-resource
#= require leaflet
#= require leaflet-contextmenu/dist/leaflet.contextmenu
#= require sidebar-v2/js/leaflet-sidebar
#= require angular-cookies
#= require ui-select/index
#= require_tree .

window.BmgApp = { }
BmgApp.LeafletGeosearch = require('leaflet-geosearch')

bmgApp = angular
	.module('bmgApp', [
		'ui.router',
		'rails',
		'ngCookies',
		'ui.select',
		'templates',
		'marker',
		'company',
		'sidebar.controller',
		'map'
	])

	.config(['$httpProvider', ($httpProvider) ->
			$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
	])

	.constant('csrfCookieName', 'XSRF-TOKEN')
	.constant('csrfHeaderName', 'X-CSRF-Token')
	.provider('myCSRF',['csrfHeaderName', 'csrfCookieName', (headerName, cookieName) ->
		allowedMethods = ['GET']

		@setHeaderName = (n) ->
			headerName = n

		@setCookieName = (n) ->
			cookieName = n

		@setAllowedMethods = (n) ->
			allowedMethods = n

		@$get = ['$cookies', ($cookies) ->
			return {
				'request': (config) ->
						if(allowedMethods.indexOf(config.method) == -1)
							# do something on success
							config.headers[headerName] = $cookies.get(cookieName)

						return config
			}
		]

		return @
	])

	.config(['$httpProvider', ($httpProvider) ->
			$httpProvider.interceptors.push('myCSRF')
	])

	.config(['$stateProvider', ($stateProvider) ->
		$stateProvider
			.state({
				name: 'root',
				url: '/',
				resolve: {
					markers: ['Marker', (Marker) ->
						return Marker.query()
					]
				}
			})
			.state({
				name: 'marker',
				url: '/marker'
			})
			.state({
				name: 'marker.show',
				url: '/{markerId}',
				resolve: {
					marker: ['$stateParams', 'Marker', ($stateParams, Marker) ->
						return Marker.get $stateParams.markerId
					]
				},
				views: {
					'marker@': {
						templateUrl: 'marker/marker.show.html',
						controller: 'MarkerShowCtrl'
					}
				}
			})
			.state({
				name: 'marker.edit',
				url: '/{markerId}/edit',
				resolve: {
					marker: ['$stateParams', 'Marker', ($stateParams, Marker) ->
						return Marker.get $stateParams.markerId
					],
					companies: ['Company', (Company)->
						return Company.query()
					]
				},
				views: {
					'marker@': {
						templateUrl: 'marker/marker.edit.html',
						controller: 'MarkerEditCtrl'

					}
				}
			})
			.state({
				name: 'company',
				url: '/company'
			})
			.state({
				name: 'company.show',
				url: '/{companyId}',
				resolve: {
					company: ['$stateParams', 'Company', ($stateParams, Company) ->
						return Company.get $stateParams.companyId
					]
				},
				views: {
					'company@': {
						templateUrl: 'company/company.show.html',
						controller: 'CompanyShowCtrl'
					}
				}
			})
			.state({
				name: 'company.edit',
				url: '/{companyId}/edit',
				resolve: {
					company: ['$stateParams', 'Company', ($stateParams, Company) ->
						return Company.get $stateParams.companyId
					]
				},
				views: {
					'company@': {
						templateUrl: 'company/company.edit.html',
						controller: 'CompanyEditCtrl'
					}
				}
			})
	])
	.controller('ApplicationCtrl', ['$scope', ($scope) ->

	])