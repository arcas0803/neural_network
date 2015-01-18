library LearningRule.UnSupervised;

import 'learning_rule.dart';
import '../functions/stop/max_iterations_function.dart';
import "../dataset/instance.dart";


abstract class NoSupervisedLearningRule extends LearningRule {

  NoSupervisedLearningRule(int maxIterations):super() {
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
  }

  void learn(List<Instance>trainSet) {
    while (!hasReachStopCondition()) {
      this.learnIteration(trainSet);
    }
  }

  void learnIteration(List<Instance>trainSet) {
    for (Instance trainInstance in trainSet) {
      this.learnPattern(trainInstance.);
      this.currentIteration++;
    }
  }

  void learnPattern(List<double>values) {
    this.network.inputNetwork = values;
    this.network.calculateOutput();
    this.updateWeights();

  }

  void updateWeights();
}