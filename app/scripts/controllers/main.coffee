'use strict'

class Trainer
  constructor: (predictor) ->
    @loss = []
    @trainedPoints = []
    @predictor = predictor

  labelledPair: ->
    features = _.map _.range(@predictor.config.numFeatures), (x) ->
      feature: x + 1
      value: chance.integer({min: 0, max: 5})
    label = chance.bool()
    return {
      features: features
      label: label
    }

  train: ->
    pair = @labelledPair()
    @trainedPoints.push pair
    @predictor.train pair.features, pair.label
    @loss.push
        prediction: @predictor.predict pair.features

  lossSeries: -> [
    key: "Loss"
    values: _.map @loss, (loss, index) => [index, loss.prediction]
  ]

  weights: ->
    _.chain(@predictor.weights)
      .groupBy((weight, featureString) => JSON.parse(featureString).feature)
      .map (weights, feature) =>
        return {
          key: "Feature " + feature
          values: _.map weights, (weight, feature) =>
            x: weight.mean
            y: weight.variance
            size: 1.0 - weight.variance
        }
      .value()


angular.module('decisionTreeVisualizationApp')
  .controller 'MainCtrl', ($scope, $log, $interval, AdPredictor) ->
    config =
      beta: 0.05
      priorProbability: 0.4
      numFeatures: 10

    @trainer = new Trainer new AdPredictor config

    @trainingPromise = null

    @train = =>
      @trainer.train()
      $scope.lossSeries = @trainer.lossSeries()
      $scope.weights = @trainer.weights()

    # Run one round of training to begin with
    @train()
    # Train once every thousand milliseconds
    @startTraining = => @trainingPromise = $interval(@train, 1000)
    @startTraining()

    # Scope public API
    $scope.numExamples = => @trainer.trainedPoints.length
    $scope.xFunction = -> (d) -> d.x
    $scope.yFunction = -> (d) -> d.y
    $scope.formatFunction = -> (d) -> d3.round(d, 2)
    $scope.trainingStatus = => @trainingPromise != null
    $scope.toggleTraining = =>
      if $scope.trainingStatus()
        $interval.cancel(@trainingPromise)
        @trainingPromise = null
      else
        @startTraining()


