'use strict'

describe 'Service: Logisticregression', () ->

  # load the service's module
  beforeEach module 'decisionTreeVisualizationApp'

  # instantiate service
  LogisticRegression = {}
  beforeEach inject (_LogisticRegression_) ->
    LogisticRegression = _LogisticRegression_

  it 'should learn a positive weight', () ->
    lr = new LogisticRegression { learningRate: 1.0 }
    features = [
      {
        feature: 5
        value: chance.floating({min: -5, max: 5})
      }
    ]
    label = features[0].value > 0
    lr.train(features, label)
    expect(_.size(lr.weights)).toBe 1
    expect(lr.weights[5].weight).toBeGreaterThan(0)

  it 'should learn a negative weight', () ->
    lr = new LogisticRegression { learningRate: 1.0 }
    features = [
      {
        feature: 5
        value: chance.floating({min: -5, max: 5})
      }
    ]
    label = features[0].value < 0
    lr.train(features, label)

    expect(_.size(lr.weights)).toBe 1
    expect(lr.weights[5].weight).toBeLessThan(0)

