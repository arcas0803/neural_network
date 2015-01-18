library StopCondition.MinError;

import 'stop_function.dart';
import '../../LearningRule/learning_rule.dart';

class MinError implements StopCondition {

  double minError;
  LearningRule learningRule;

  MinError(this.minError, this.learningRule) {
  }

  bool isReached() {
    if (learningRule.network.error.errorTrain.last < minError) {
      return true;
    } else {
      return false;
    }
  }
}