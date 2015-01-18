// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library LearningRule.Basic;

import "supervised_learning.dart";
import "../arquitecture/neuron.dart";
import "../arquitecture/connection.dart";

/// Basic learning rule that most of the network use.

class BasicLearningRule extends SupervisedLearningRule {

  BasicLearningRule(int maxIterations):super(maxIterations) {
  }

  void updateWeights(List <double> outputError) {
    int i = 0;

    for (Neuron neuron in this.network.outputNeurons) {
      neuron.error = outputError[i];
      this.updateWeight(neuron);
      i++;
    }
  }

  ///
  /// Weight = oldWeight + learningRule * error * input.
  ///

  void updateWeight(Neuron neuron) {
    for (Connection connection in neuron.inputConnections) {
      connection.weight.increment(this.learningRate * neuron.error * connection.inputNeuronDestination);
    }
  }
}