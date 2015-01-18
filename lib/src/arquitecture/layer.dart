// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Arquitecture.Layer;

import 'neuron.dart';
import '../functions/activation/activation_function.dart';
import '../functions/input/input_function.dart';
import "package:json_object/json_object.dart";

///
/// Structural unit that includes a set of neurons.
///

class Layer {

  String id;
  List<Neuron> neurons;

  ///
  /// [new Layer] use to create a layer.
  /// You can create a layer starting from a list of neurons.
  /// By default an empty layer neurons are created.
  ///

  Layer(this.id, {List<Neuron>neurons}) {
    if (neurons != null) {
      this.neurons = neurons;
    } else {
      this.neurons = [];
    }
  }

  ///
  /// Creates equal neurons forming the layer. Just provide the number of neurons of the layer.
  ///
  /// Example:
  ///   layer.createNeurons(5,InputFunction: some_input_function, ActivationFunction: some_activation_function);
  ///   Add 5 new neurons with some_input_function and some_activation_function.

  void createNeurons(int count, {InputFunction inputFunction, ActivationFunction activationFunction}) {
    this.neurons = [];
    for (int i = 0; i < count; i++) {
      Neuron temp = new Neuron("Neuron_" + i.toString(), inputFunction: inputFunction, activationFunction:activationFunction);
      this.neurons.add(temp);
    }
  }

  ///
  /// Returns true if the layer has 1 or more neurons.
  ///

  bool get hasNeurons {
    return this.neurons.isNotEmpty;
  }

  ///
  /// Returns the number of neurons of the layer.
  ///

  int get numNeurons {
    if (this.hasNeurons) {
      return this.neurons.length;
    } else {
      return 0;
    }
  }

  ///
  /// Add a new Neuron.
  ///
  /// If the neuron is null an exception will be thrown.
  ///

  void addNeuron(Neuron neuron) {
    if (neuron == null) {
      throw ("Neuron is empty");
    }
    this.neurons.add(neuron);
  }

  ///
  /// Remove all neurons.
  ///

  void removeAllNeurons() {
    this.neurons = [];
  }

  ///
  /// Remove a neuron at index.
  ///

  void removeNeuronAt(int index) {
    this.neurons.removeAt(index);
  }

  ///
  /// Return a neuron at index.
  ///

  Neuron getNeuron(int index) {
    return this.neurons[index];
  }

  ///
  /// Set a Neuron at index.
  ///

  void setNeuron(int index, Neuron neuron) {

    if (neuron == null) {
      throw ("Neuron is empty");
    }
    this.neurons[index] = neuron;

  }

  ///
  /// Calculate the output of all the neurons of the layer.
  ///

  void calculateOutput() {

    for (Neuron neuron in this.neurons) {
      neuron.calculateOutput();
    }

  }

}