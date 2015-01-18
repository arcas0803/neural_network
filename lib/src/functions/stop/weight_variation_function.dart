// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library StopCondition.WeightChange;

import 'stop_function.dart';
import '../../learning_rule/learning_rule.dart';

/// Sets a threshold value and if the variation of all weights in the network are lower than the threshold training stops.

class WeightVariation implements StopCondition {

  double variation;
  LearningRule learningRule;

  WeightVariation(this.variation, this.learningRule) {
  }

  bool isReached() {

    List <double> actualVariations;
    for (var layer in learningRule.network.layers) {
      for (var neuron in layer.neurons) {
        for (var variation in neuron.inputWeightsVariation) {
          actualVariations.add(variation);
        }
      }
    }
    for (double variation in actualVariations) {
      if (variation > this.variation) {
        return false;
      }
    }
    return true;

  }

}