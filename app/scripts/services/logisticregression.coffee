'use strict'

angular.module('decisionTreeVisualizationApp')
  .service 'LogisticRegression', ($log) ->
    class LogisticRegression
      constructor: (config) ->
        @config = config
        @weights = {}

      train: (features, label) ->
        prediction = @predict features
        update = label - prediction
        newWeights = _.chain(features)
          .map((f) => {
            feature: f.feature,
            weight: @getWeight(f.feature).weight +  @config.learningRate * update * f.value
          })
          .value()

        _.each(newWeights,  (grad) =>
          @setWeight grad.feature, grad.weight)

      getWeight: (feature) ->
        key = feature
        @weights[key] || {
          weight: 0.0
        }

      setWeight: (feature, weight) ->
        key = feature
        @weights[key] =
          weight: weight




      predict: (features, label) ->
        logit = _.chain(features)
          .map((f) => (@getWeight f.feature).weight * f.value)
          .reduce(((l, r) => l + r), 0)
          .value()
        1.0 / (1.0 + Math.exp(-logit))
      # AngularJS will instantiate a singleton by calling "new" on this function
