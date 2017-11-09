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
#= require leaflet
#= require leaflet-contextmenu/dist/leaflet.contextmenu
#= require sidebar-v2/js/leaflet-sidebar
#= require_tree .

window.BmgApp = { }
BmgApp.LeafletGeosearch = require('leaflet-geosearch')

bmgApp = angular
	.module('bmgApp', ['templates', 'marker', 'sidebar.controller', 'map'])
	.controller('ApplicationCtrl', ['$scope', ($scope) ->

	])