// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Adaline;

import '../arquitecture/arquitecture_export.dart';
import '../functions/input/weight_combination_function.dart';
import '../functions/activation/lineal_function.dart';
import '../functions/error/mean_square_error.dart';
import '../learning_rule/basic_learning.dart';

class Adaline extends Network {

  Adaline(int numInputNeurons, int maxIterations):super() {
    this.createNetwork(numInputNeurons, maxIterations);
  }

  void createNetwork(int numInputNeurons, int maxIterations) {
    //input Layer
    Layer inputLayer = new Layer("InputLayer");
    inputLayer.createNeurons(numInputNeurons);
    //OutPut Layer
    Layer outputLayer = new Layer("OutputLayer");
    outputLayer.createNeurons(1, inputFunction: new WeightCombination(), activationFunction: new Lineal());
    Neuron umbral = new Neuron("Umbral");
    umbral.input = 1.0;
    umbral.output = 1.0;
    outputLayer.neurons[0].addInputConnectionFromNeuron(umbral);
    this.addLayer(inputLayer);
    this.addLayer(outputLayer);

    this.connectLayers();

    BasicLearningRule adalineLearning = new BasicLearningRule(maxIterations);
    adalineLearning.network = this;
    adalineLearning.errorFunction = new MeanSquareError();
    adalineLearning.learningRate = 0.01;
    this.learningRule = adalineLearning;
  }


}
