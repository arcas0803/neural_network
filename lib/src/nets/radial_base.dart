// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library RadialBase;

import '../arquitecture/network.dart';
import '../arquitecture/layer.dart';
import '../arquitecture/neuron.dart';
import '../functions/input/radial_function.dart';
import '../functions/input/weight_combination_function.dart';
import '../functions/activation/gaussian_function.dart';
import '../functions/activation/lineal_function.dart';
import '../functions/error/mean_square_error.dart';
import '../functions/stop/max_iterations_function.dart';

class RadialBase extends Network{
  RadialBase(int numInputNeurons, int numHiddenNeurons, int numOutputNeurons, int maxIterations):super(){
    this.createNetwork(numInputNeurons, numHiddenNeurons,numOutputNeurons, maxIterations);
  }

  void createNetwork(int numInputNeurons, int numHiddenNeurons, int numOutputNeurons, int maxIterations){
    Layer inputLayer = new Layer("InputLayer");
    inputLayer.createNeurons(numInputNeurons);

    Layer hiddenLayer = new Layer("HiddenLayer");
    hiddenLayer.createNeurons(numHiddenNeurons, inputFunction: new Radial(), activationFunction: new Gaussian());

    Layer outputLayer = new Layer("OutputLayer");
    outputLayer.createNeurons(numOutputNeurons, inputFunction: new WeightCombination(), activationFunction: new Lineal());

    Network radial = new Network();
    radial.addLayer(inputLayer);
    radial.addLayer(hiddenLayer);
    radial.addLayer(outputLayer);
    radial.connectLayers();





  }
}