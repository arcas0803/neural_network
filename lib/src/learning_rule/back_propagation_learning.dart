library LearningRule.BackPropagation;

import "basic_learning.dart";
import "../Arquitecture/connection.dart";
import "../Arquitecture/neuron.dart";
import "../Arquitecture/layer.dart";


class BackPropagationLearningRule extends BasicLearningRule {

  BackPropagationLearningRule(int maxIterations):super(maxIterations) {
  }

  void updateWeights(List <double> outputError) {
    this.updateWeightsOutputNeurons(outputError);
    this.updateWeightsHiddenNeurons();
  }

  void updateWeightsOutputNeurons(List <double> outputError) {
    int i = 0;
    for (Neuron neuron in this.network.outputNeurons) {
      neuron.error = outputError[i] * neuron.activationFunction.getDerivedOutput(neuron.input);
      this.updateWeight(neuron);
      i++;
    }
  }

  void updateWeightsHiddenNeurons() {
    List <Layer> layers = network.layers;
    for (int i = layers.length - 2; i > 0; i--) {
      for (Neuron neuron in layers[i].neurons) {
        double delta = 0.0;
        for (Connection outputConnection in neuron.outputConnections) {
          delta += (outputConnection.neuronDestination.error * outputConnection.weightValue);
        }
        neuron.error = (neuron.activationFunction.getDerivedOutput(neuron.input) * delta);
        this.updateWeight(neuron);
      }
    }
  }
}