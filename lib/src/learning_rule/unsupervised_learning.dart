library LearningRule.UnSupervised;

import 'learning_rule.dart';
import '../functions/stop/max_iterations_function.dart';
import "../dataset/dataset_export.dart";


abstract class NoSupervisedLearningRule extends LearningRule {

  NoSupervisedLearningRule(int maxIterations):super() {
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
  }

  void learn(DataSet dataSet) {
    while (!hasReachStopCondition()) {
      this.learnIteration(dataSet);
    }
  }

  void learnIteration(DataSet dataSet) {
    for (int i = 0; i < dataSet.instances.length; i++) {
      if(dataSet.instances[i].isForTrain != null && dataSet.instances[i].isForTrain)
        this.learnPattern(dataSet.instanceValues(i));
    }
    this.currentIteration++;
  }


  void learnPattern(List<double>values) {
    this.network.inputNetwork = values;
    this.network.calculateOutput();
    this.updateWeights();

  }

  void updateWeights();
}