// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library MultilayerPerceptron;

import '../arquitecture/network.dart';
import '../arquitecture/layer.dart';
import '../arquitecture/neuron.dart';
import '../functions/input/weight_combination_function.dart';
import '../functions/activation/sigmoid_function.dart';
import '../functions/error/mean_square_error.dart';
import '../learning_rule/back_propagation_learning.dart';

class MultilayerPerceptron extends Network {

  MultilayerPerceptron(List<int>neuronsInLayers, int maxIterations) {
    this.createNetwork(neuronsInLayers, maxIterations);
  }

  void createNetwork(List<int>neuronsInLayers, int maxIterations) {

    Layer inputLayer = new Layer("InputLayer");
    inputLayer.createNeurons(neuronsInLayers[0]);
    this.addLayer(inputLayer);

    for (int i = 1; i < neuronsInLayers.length; i++) {
      Layer temp = new Layer("HiddenLayer" + i.toString());
      temp.createNeurons(neuronsInLayers[i], inputFunction: new WeightCombination(), activationFunction: new Sigmoid());
      this.addLayer(temp);
      for (Neuron neuron in this.layers[i].neurons) {
        Neuron umbral = new Neuron("Umbral " + i.toString());
        umbral.input = 1.0;
        umbral.output = 1.0;
        neuron.addInputConnectionFromNeuron(umbral);
      }
    }

    this.connectLayers();

    BackPropagationLearningRule multilayerPerceptronLearning = new BackPropagationLearningRule(maxIterations);
    multilayerPerceptronLearning.network = this;
    multilayerPerceptronLearning.errorFunction = new MeanSquareError();
    multilayerPerceptronLearning.learningRate = 0.01;
    this.learningRule = multilayerPerceptronLearning;

  }

}