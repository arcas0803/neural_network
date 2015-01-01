// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Arquitecture.Connection;

import 'neuron.dart';
import 'weight.dart';
import "package:json_object/json_object.dart";

///
/// Link between two neurons that has an associated weight.
///

class Connection {

  Neuron neuronOrigin;
  Neuron neuronDestination;
  Weight weight;

  ///
  /// [new Connection] use to create a connection between to neurons.
  /// Its possible to set a value for the weight associated.
  /// By default the weight value is a random value.
  ///
  /// Example:
  ///   Connection example = new Connection (Neuron a, Neuron b, 2.0); => example.weightValue = 2.0
  ///

  Connection(Neuron origin, Neuron destination, [double value]) {
    if(origin != null && destination != null){
      if(value != null){
        this.weight = new Weight(value);
      }else{
        this.weight = new Weight();
      }
      this.neuronOrigin = origin;
      this.neuronDestination = destination;
    }else{
      throw ("Neuron origin and neuron destination can't be null");
    }
  }

  //
  // Create a Neuron from an JsonObject.
  //
  // JSON format:
  // {
  //  "neuronOrigin" : JsonObject neuronOrigin,
  //  "neuronDestination" : JsonObject neuronDestination,
  //  "weight" : JsonObject weight
  //  }
  //

  Connection.fromJSON(JsonObject json){
    this.neuronOrigin = new Neuron.fromJSON(json.neuronOrigin);
    this.neuronDestination = new Neuron.fromJSON(json.neuronDestination);
    this.weight = new Weight.fromJSON(json.weight);
  }

  ///
  /// Return the input value of the neuron destination.
  /// The input is the output of the neuron Origin.
  ///

  double get inputNeuronDestination => this.neuronOrigin.output;

  ///
  /// Get the value of the weight associated.
  ///

  double get weightValue => this.weight.value;

  void set weightValue(double value) {this.weight.value = value;}

  ///
  /// Get the previous value of the weight associated.
  ///

  double get weightPreviousValue => this.weight.previousValue;

  ///
  /// Get the variation of the weight associated.
  ///

  double get weightVariation => this.weight.variation;

  ///
  /// Increases the weight value associated.
  ///
  /// Example:
  ///   example.increment(1.0) => this.value = 2.2
  ///                             this.previousValue = 1.2;
  ///                             this.variation = 1.0;
  ///

  void increment(double value){
    this.weight.increment(value);
  }

  //
  // Return the JsonObject of the connection.
  //

  JsonObject toJSON(){

    JsonObject connection = new JsonObject();
    connection.neuronOrigin = this.neuronOrigin.toJSON();
    connection.neuronDestination = this.neuronDestination.toJSON();
    connection.weight = this.weight.toJSON();
    return connection;

  }

}