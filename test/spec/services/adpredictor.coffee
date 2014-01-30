'use strict'

describe 'Service: Adpredictor', () ->

  # load the service's module
  beforeEach module 'decisionTreeVisualizationApp'

  # instantiate service
  AdPredictor = {}
  
  beforeEach inject (_AdPredictor_) ->
    AdPredictor = _AdPredictor_

  it 'should do something', () ->
    expect(!!AdPredictor).toBe true
