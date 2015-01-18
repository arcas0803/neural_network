library StopCondition.MaxIterations;

import 'stop_function.dart';
import '../../learning_rule/learning_rule.dart';

class MaxIteration implements StopCondition {

  int maxIterations;
  LearningRule learningRule;

  MaxIteration(this.maxIterations, this.learningRule) {
  }

  bool isReached() {
    if (learningRule.currentIteration < this.maxIterations) {
      return false;
    } else {
      return true;
    }
  }
}