// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library LearningRule.Supervised;

import 'learning_rule.dart';
import '../functions/stop/max_iterations_function.dart';
import '../functions/error/error_function.dart';
import "../dataset/dataset_export.dart";

/// Learning rule for supervised dataSet.

abstract class SupervisedLearningRule extends LearningRule {

  ErrorFunction _errorFunction;
  List <double> errorIterations;
  List<List<double>> outputNetworkTrain;

  ///
  /// [new SupervisedLearningRule] use to create a supervised learning rule.
  ///
  /// The learning rule must have max iteration stop condition but its possible to add more.
  ///

  SupervisedLearningRule(int maxIterations):super() {
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
    this.errorIterations = [];
    this.outputNetworkTrain = [];
  }

  /// The error function indicates how to calculate the network error.

  set errorFunction(ErrorFunction errorFunction) {
    if (errorFunction != null) {
      this._errorFunction = errorFunction;
    }
  }

  get errorFunction => this._errorFunction;

  /// The learning process consists of the following steps:
  ///   1. For each instance of the training set :
  ///         1. Calculate the output of the network.
  ///         2. Calculate the error made by the network.
  ///         3. Adjust the weights according to the law of learning.
  ///   2. If all stop conditions are reached stop, if not return to 1.
  ///

  void learn(DataSet dataSet) {
    if(!dataSet.isSupervised)
      throw("For supervised learning, supervised dataset is needed");
    while (!hasReachStopCondition()) {
      this.learnIteration(dataSet);
    }
  }

  void learnIteration(DataSet dataSet) {
    for (int i = 0; i < dataSet.instances.length; i++) {
      if(dataSet.instances[i].isForTrain != null && dataSet.instances[i].isForTrain)
        this.learnPattern(dataSet.instanceValues(i), dataSet.instanceClassValues(i));
    }
    this.currentIteration++;
    this.errorIterations.add(this.errorFunction.totalError());
    this.errorFunction.reset();
  }

  void learnPattern(List<double>values, List<double>classValues) {
    this.network.inputNetwork = values;
    this.network.calculateOutput();
    List <double> outputNetwork = this.network.outputNetwork;
    this.outputNetworkTrain.add(outputNetwork);
    List <double> outputNetworkError = this.calculateOutputError(outputNetwork, classValues);
    this.errorFunction.addError(outputNetworkError);
    this.updateWeights(outputNetworkError);

  }

  List <double> calculateOutputError(List<double>output, List<double>desireOutput) {
    List outputFinal = [];
    for (int i = 0; i < desireOutput.length; i++) {
      outputFinal.add(desireOutput[i] - output[i]);
    }
    return outputFinal;
  }

  void updateWeights(List<double>outputError);
}