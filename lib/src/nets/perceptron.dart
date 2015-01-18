// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Perceptron;

import '../arquitecture/network.dart';
import '../arquitecture/layer.dart';
import '../arquitecture/neuron.dart';
import '../functions/input/weight_combination_function.dart';
import '../functions/activation/step_function.dart';
import '../functions/error/mean_square_error.dart';
import '../learning_rule/basic_learning.dart';


class Perceptron extends Network {

  Perceptron(int numInputNeurons, int maxIterations):super() {
    this.createNetwork(numInputNeurons, maxIterations);
  }

  void createNetwork(int numInputNeurons, int maxIterations) {

    Layer inputLayer = new Layer("InputLayer");
    inputLayer.createNeurons(numInputNeurons);
    //OutPut Layer
    Layer outputLayer = new Layer("OutputLayer");
    outputLayer.createNeurons(1, inputFunction: new WeightCombination(), activationFunction: new Step());

    Neuron umbral = new Neuron("Umbral");
    umbral.input = 1.0;
    umbral.output = 1.0;
    outputLayer.neurons[0].addInputConnectionFromNeuron(umbral);

    this.addLayer(inputLayer);
    this.addLayer(outputLayer);

    this.connectLayers();

    BasicLearningRule perceptronLearning = new BasicLearningRule(maxIterations);
    perceptronLearning.network = this;
    perceptronLearning.errorFunction = new MeanSquareError();
    perceptronLearning.learningRate = 0.01;

    this.learningRule = perceptronLearning;


  }


}