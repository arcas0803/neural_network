// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library LearningRule;

import "../arquitecture/network.dart";
import '../functions/stop/stop_function.dart';
import "../dataset/dataset_export.dart";

// Indicates how the network should modify the weights for learning.

abstract class LearningRule {

  Network _neuralNetwork;
  List<StopCondition> _stopConditions;
  double _learningRate;
  int _currentIteration;

  ///
  /// [new LearningRule] use to create an empty learning rule.
  ///

  LearningRule() {
    this._stopConditions = [];
    this._currentIteration = 0;
  }

  /// It is used to control the variation of the weights.

  get learningRate => this._learningRate;

  /// Learning rate must be greater than 0.

  set learningRate(double value) {
    if (value > 0.0) {
      this._learningRate = value;
    }
  }

  get currentIteration => this._currentIteration;

  set currentIteration(int value) => this._currentIteration = value;

  get network => this._neuralNetwork;

  set network(Network neuralNetwork) {
    if (neuralNetwork != null) {
      this._neuralNetwork = neuralNetwork;
    }
  }

  void addStopCondition(StopCondition stopCondition) {
    if (stopCondition != null) {
      this._stopConditions.add(stopCondition);
    }
  }

  void removeStopCondition(int index) {
    this._stopConditions.removeAt(index);
  }

  get stopConditions => this._stopConditions;

  // Return true if all stop conditions has reached.

  bool hasReachStopCondition() {
    for (StopCondition stopCondition in this._stopConditions) {
      if (stopCondition.isReached()) {
        return true;
      }
    }
    return false;
  }

  void learn(DataSet dataSet);
}
