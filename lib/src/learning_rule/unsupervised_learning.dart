library LearningRule.UnSupervised;

import 'learning_rule.dart';
import '../functions/stop/max_iterations_function.dart';
import "../dataset/dataset_export.dart";


abstract class NoSupervisedLearningRule extends LearningRule {

  List<List<double>> outputNetworkTrain;

  NoSupervisedLearningRule(int maxIterations):super() {
    MaxIteration stopCondition = new MaxIteration(maxIterations, this);
    this.addStopCondition(stopCondition);
    this.outputNetworkTrain = [];
  }

  void learn(DataSet dataSet) {
    if(dataSet.isSupervised)
      throw("For unsupervised learning, unsupervised dataset is needed");
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
    List <double> outputNetwork = this.network.calculateOutput();
    this.outputNetworkTrain.add(outputNetwork);
    this.updateWeights();

  }

  void updateWeights();
}