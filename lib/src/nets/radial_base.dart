// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library RadialBase;

import '../arquitecture/arquitecture_export.dart';
import '../functions/input/radial_function.dart';
import '../functions/input/weight_combination_function.dart';
import '../functions/activation/gaussian_function.dart';
import '../functions/activation/lineal_function.dart';
import '../learning_rule/radial_learning.dart';
import '../functions/error/mean_square_error.dart';


class RadialBase extends Network {
  RadialBase(int numInputNeurons, int numHiddenNeurons, int numOutputNeurons, int maxIterations):super() {
    this.createNetwork(numInputNeurons, numHiddenNeurons, numOutputNeurons, maxIterations);
  }

  void createNetwork(int numInputNeurons, int numHiddenNeurons, int numOutputNeurons, int maxIterations) {
    Layer inputLayer = new Layer("InputLayer");
    inputLayer.createNeurons(numInputNeurons);

    Layer hiddenLayer = new Layer("HiddenLayer");
    hiddenLayer.createNeurons(numHiddenNeurons, inputFunction: new Radial(), activationFunction: new Gaussian());

    Layer outputLayer = new Layer("OutputLayer");
    outputLayer.createNeurons(numOutputNeurons, inputFunction: new WeightCombination(), activationFunction: new Lineal());
    for (Neuron neuron in outputLayer.neurons) {
      Neuron umbral = new Neuron("Umbral");
      umbral.input = 1.0;
      umbral.output = 1.0;
      neuron.addInputConnectionFromNeuron(umbral);
    }


    this.addLayer(inputLayer);
    this.addLayer(hiddenLayer);
    this.addLayer(outputLayer);
    this.connectLayers();

    RadialLearning radialLearning = new RadialLearning(maxIterations);
    radialLearning.network = this;
    radialLearning.errorFunction = new MeanSquareError();
    radialLearning.learningRate = 0.01;
    this.learningRule = radialLearning;
  }
}