'use strict'

angular.module('decisionTreeVisualizationApp')
  .directive 'decisionTree', () ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the DecisionTree directive'
