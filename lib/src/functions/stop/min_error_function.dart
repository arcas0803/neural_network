// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library StopCondition.MinError;

import 'stop_function.dart';
import '../../learning_rule/learning_rule.dart';

/// Sets a threshold value and if the error of all neurons in the network are lower than the threshold training stops.

class MinError implements StopCondition {

  double minError;
  LearningRule learningRule;

  MinError(this.minError, this.learningRule) {}

  bool isReached(){
    if(learningRule.network.error.errorTrain.last < minError){
      return true;
    }else{
      return false;
    }
  }
}