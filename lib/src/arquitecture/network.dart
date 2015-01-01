// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Arquitecture.Network;

import 'layer.dart';
import 'neuron.dart';
import '../learning_rule/learning_rule.dart';
import "package:json_object/json_object.dart";

///
/// Set of interconnected layers.
///

class Network {

  List<Layer> layers;
  LearningRule learningRule;

  ///
  /// [new Network] use to create an empty network.
  ///

  Network() {
    this.layers = [];
  }

  //
  // Create a Network from an JsonObject.
  //
  // JSON format:
  // {
  //  "layers" : [JsonObject layer1,JsonObject layer2],
  //  }
  //

  Network.fromJSON(JsonObject json){

    this.layers = [];
    for(int i = 0; i < json.layers.length; i++){
      this.addLayer(new Layer.fromJSON(json.layers[i]));
    }

  }

  ///
  /// Return the input neurons of the network.
  ///

  List<Neuron> get inputNeurons => this.layers.first.neurons;

  ///
  /// Return the output neurons of the network.
  ///

  List<Neuron> get outputNeurons => this.layers.last.neurons;

  ///
  /// Set the input value of the input neurons.
  ///

  set inputNetwork(List<double> inputs) {
    if (inputs.length != this.inputNeurons.length) {
      throw ("Array length distinct");
    }
    int i = 0;
    for (Neuron neuron in this.inputNeurons){
      neuron.input = inputs[i];
      i++;
    }
  }

  ///
  /// Return the output of the outputs neurons.
  ///

  List<double> get outputNetwork {
    List <double> output = [];
    for(Neuron neuron in this.outputNeurons){
      output.add(neuron.output);
    }
    return output;
  }

  ///
  /// Return true if the network has 1 or more layers.
  ///

  bool get hasLayers{
    return this.layers.isNotEmpty;
  }

  ///
  /// Return the number of layers.
  ///

  int get numLayers => this.layers.length;

  ///
  /// Return the number of neurons.
  ///

  int get numNeurons {
    int count = 0;
    for(Layer temp in this.layers){
      count += temp.numNeurons;
    }
    return count;
  }

  ///
  /// Return the number of input neurons.
  ///

  int get numEntries => this.inputNeurons.length;

  ///
  /// Return the number of output neurons.
  ///

  int get numOutputs => this.outputNeurons.length;

  void addLayer(Layer layer) {
    this.layers.add(layer);
  }

  void addLayerAt(int index, Layer layer) {
    this.layers.insert(index, layer);
  }

  void removeLayer(Layer layer) {
    this.layers.remove(layer);
  }

  void removeLayerAt(int index) {
    this.layers.removeAt(index);
  }

  void removeAllLayers() {
    this.layers = [];
  }

  ///
  /// Calculate all the outputs of all the neurons.
  ///

  void calculateOutput() {
    for (Layer layer in this.layers) {
      layer.calculateOutput();
    }
  }

  ///
  /// Makes a full connection between all the layers of the network.
  ///

  void connectLayers(){
    for(int k = this.layers.length -1; k > 0; k--){
      for(int i = 0; i < this.layers[k].neurons.length; i++){
        for(int j = 0; j < this.layers[k-1].neurons.length; j++){
          this.layers[k].neurons[i].addInputConnectionFromNeuron(this.layers[k-1].neurons[j]);
        }
      }
    }
  }

  //
  // Return the JsonObject of the network.
  //

  JsonObject toJSON(){

    JsonObject network = new JsonObject();
    network.layers = new List();
    for(Layer layer in this.layers){
      network.layers.add(layer.toJSON());
    }
    return network;

  }
}