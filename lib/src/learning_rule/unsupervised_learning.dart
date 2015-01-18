library LearningRule.UnSupervised;

import 'learning_rule.dart';
import '../Functions/Stop/max_iterations_function.dart';
import "../DataSet/instance.dart";


abstract class NoSupervisedLearningRule extends LearningRule {

  NoSupervisedLearningRule(int maxIterations):super() {
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
  }

  void learn(List<Instance>trainSet) {
    for (Instance instance in trainSet) {
      if (instance.isSupervised) {
        throw ("All instance must be unsupervised");
      }
    }
    while (!hasReachStopCondition()) {
      this.learnIteration(trainSet);
    }
  }

  void learnIteration(List<Instance>trainSet) {
    for (Instance trainInstance in trainSet) {
      this.learnPattern(trainInstance.values);
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