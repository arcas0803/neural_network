// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library StopCondition.MaxIterations;

import 'stop_function.dart';
import '../../learning_rule/learning_rule.dart';
import "package:json_object/json_object.dart";

// Sets a maximum number of iterations of training. When the learning process exceeded that limit the training ends.

class MaxIteration implements StopCondition {

  int maxIterations;
  LearningRule learningRule;

  MaxIteration(this.maxIterations, this.learningRule){}

  bool isReached(){

    if(learningRule.currentIteration < this.maxIterations){
      return false;
    } else{
      return true;
    }

  }

  JsonObject toJSON(){

    JsonObject stopFunction = new JsonObject();
    stopFunction.type = "MaxIteration";
    stopFunction.maxIterations = this.maxIterations;
    stopFunction.learningRule = this.learningRule.toJSON();
    return stopFunction;

  }
}