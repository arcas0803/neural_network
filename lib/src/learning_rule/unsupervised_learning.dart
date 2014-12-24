// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library LearningRule.UnSupervised;

import 'learning_rule.dart';
import '../functions/stop/max_iterations_function.dart';
import "../dataset/instance.dart";

/// Learning rule for unsupervised dataSet.

abstract class UnSupervisedLearningRule extends LearningRule{

  ///
  /// [new UnSupervisedLearningRule] use to create a supervised learning rule.
  ///
  /// The learning rule must have max iteration stop condition but its possible to add more.
  ///

  UnSupervisedLearningRule(int maxIterations):super(){
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
  }

  /// The learning process consists of the following steps:
  ///   1. For each instance of the training set :
  ///         1. Calculate the output of the network.
  ///         2. Adjust the weights according to the law of learning.
  ///   2. If all stop conditions are reached stop, if not return to 1.
  ///

  void learn(List<Instance>trainSet){
    for(Instance instance in trainSet){
      if(instance.isSupervised){
        throw ("All instance must be unsupervised");
      }
    }
    while(!hasReachStopCondition()){
      this.learnIteration(trainSet);
    }
  }

  void learnIteration(List<Instance>trainSet){
    for(Instance trainInstance in trainSet){
      this.learnPattern(trainInstance.values);
      this.currentIteration++;
    }
  }

  void learnPattern(List<double>values){
    this.network.inputNetwork = values;
    this.network.calculateOutput();
    this.updateWeights();

  }

  void updateWeights();
}