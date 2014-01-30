'use strict'

describe 'Directive: DecisionTree', () ->

  # load the directive's module
  beforeEach module 'decisionTreeVisualizationApp' 

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
