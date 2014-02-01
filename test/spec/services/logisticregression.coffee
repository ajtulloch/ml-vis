'use strict'

describe 'Service: Logisticregression', () ->

  # load the service's module
  beforeEach module 'decisionTreeVisualizationApp'

  # instantiate service
  Logisticregression = {}
  beforeEach inject (_Logisticregression_) ->
    Logisticregression = _Logisticregression_

  it 'should do something', () ->
    expect(!!Logisticregression).toBe true
