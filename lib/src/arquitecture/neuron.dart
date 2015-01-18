// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Arquitecture.Neuron;

import 'connection.dart';
import 'weight.dart';
import '../functions/activation/activation_function_export.dart';
import '../functions/input/input_function_export.dart';
import "package:json_object/json_object.dart";

///
/// Processing unit that from an input produces an output.
///

class Neuron {

  String id;
  List<Connection> inputConnections;
  List<Connection> outputConnections;
  double input = 0.0;
  double output = 0.0;
  double error = 0.0;
  ActivationFunction activationFunction;
  InputFunction inputFunction;

  ///
  /// [new Neuron] use to create a Neuron.
  ///
  /// With this constructor its possible to create different types of neurons:
  ///
  /// Example input neuron:
  ///   Neuron exampleNeuronInput = new Neuron("InputNeuron");
  ///
  /// Example hidden neuron:
  ///   Neuron exampleNeuronHidden = new Neuron("HiddenNeuron", InputFunction: some_input_function, ActivationFunction: some_activation_function);
  ///
  /// Example threshold neuron (the threshold is a neuron that always has output 1.0):
  ///   Neuron exampleNeuronThreshold = new Neuron("ThresholdNeuron");
  ///   exampleNeuronThreshold.input = 1.0;
  ///   exampleNeuronThreshold.output = 1.0;


  Neuron(this.id, {InputFunction inputFunction, ActivationFunction activationFunction}) {

    if (inputFunction != null) {
      this.inputFunction = inputFunction;
    }
    if (activationFunction != null) {
      this.activationFunction = activationFunction;
    }
    this.inputConnections = [];
    this.outputConnections = [];

  }

  ///
  /// Applies the function input all incoming connections. The result is applied to the activation function for the output of the neuron.
  ///

  void calculateOutput() {

    if (this.inputConnections.isNotEmpty && this.activationFunction != null && this.activationFunction != null) {
      this.input = this.inputFunction.getOutput(this.inputConnections);
      this.output = this.activationFunction.getOutput(this.input);
    } else {
      this.output = this.input;
    }

  }

  ///
  /// Return true if the neuron is a Threshold.
  ///

  bool get isThreshold {

    if (this.inputConnections.isEmpty && this.activationFunction == null && this.activationFunction == null && this.input == 1 && this.output == 1 && this.outputConnections.length == 1) {
      return true;
    } else {
      return false;
    }

  }

  ///
  /// Return true if the neuron has 1 or more input connections.
  ///

  bool get hasInputConnection {

    if (this.inputConnections.length > 0) {
      return true;
    } else {
      return false;
    }

  }

  ///
  /// Return true if the neuron has 1 or more output connections.
  ///

  bool get hasOutputConnection {

    if (this.outputConnections.length > 0) {
      return true;
    } else {
      return false;
    }

  }

  ///
  /// Return true if the neuron has connection from the neuron passed as parameter.
  ///

  bool hasConnectionFromNeuron(Neuron neuron) {

    for (Connection connection in this.inputConnections) {
      if (connection.neuronOrigin == neuron) {
        return true;
      }
    }
    return false;

  }

  ///
  /// Return true if the neuron has connection to the neuron passed as parameter.
  ///

  bool hasConnectionToNeuron(Neuron neuron) {

    for (Connection connection in this.outputConnections) {
      if (connection.neuronDestination == neuron) {
        return true;
      }
    }
    return false;

  }

  ///
  /// Return the weights of the input connections.
  ///

  List<Weight> get weights {

    List <Weight> weights = [];
    for (Connection connection in this.inputConnections) {
      weights.add(connection.weight);
    }
    return weights;

  }

  ///
  /// Return the values of the weights of the input connections.
  ///

  List <double> get weightsValues {

    List <double> temp = [];
    if (this.hasInputConnection) {
      for (Connection tempConnection in this.inputConnections) {
        temp.add(tempConnection.weightValue);
      }
    }
    return temp;

  }

  ///
  /// Return the previous values of the weights of the input connections.
  ///

  List <double> get weightsPreviousValues {

    List <double> temp = [];
    if (this.hasInputConnection) {
      for (Connection tempConnection in this.inputConnections) {
        temp.add(tempConnection.weightPreviousValue);
      }
    }
    return temp;

  }

  ///
  /// Return the variations of the weights of the input connections.
  ///

  List <double> get weightsVariation {

    List <double> temp = [];
    if (this.hasInputConnection) {
      for (Connection tempConnection in this.inputConnections) {
        temp.add(tempConnection.weightVariation);
      }
    }
    return temp;

  }

  ///
  /// Add a new input connection.
  ///
  /// The new connection cant be null, the neuron destination of the connection cant be the same as the actual neuron.
  /// If the connection already exist in the input connection list of the neuron, then this connection will not be added.
  ///

  void addInputConnection(Connection connection) {

    if (connection == null) {
      throw ("New connection can not be null!");
    }

    if (connection.neuronDestination != this) {
      throw ("The new connection does not connect with this neuron. Parameter from of connection must be wrong");
    }

    if (this.hasConnectionFromNeuron(connection.neuronOrigin)) {
      return;
    }

    this.inputConnections.add(connection);
    Neuron originNeuron = connection.neuronOrigin;
    originNeuron.addOutputConnection(connection);

  }

  ///
  /// Add a new input connection with the origin neuron.
  ///

  void addInputConnectionFromNeuron(Neuron origin) {

    this.addInputConnection(new Connection(origin, this));

  }

  ///
  /// Add a new output connection.
  ///
  /// The new connection cant be null, the neuron origin of the connection cant be the same as the actual neuron.
  /// If the connection already exist in the output connection list of the neuron, then this connection will not be added.
  ///

  void addOutputConnection(Connection connection) {

    if (connection == null) {
      throw ("New connection can not be null!");
    }

    if (connection.neuronOrigin != this) {
      throw ("The new connection does not connect with this neuron. Parameter from of connection must be wrong");
    }

    if (this.hasConnectionToNeuron(connection.neuronDestination)) {
      return;
    }
    this.outputConnections.add(connection);

  }

  ///
  /// Remove an input connection.
  /// When you remove an input connection, the same connection will be remove on the output list of the neuron origin.
  ///

  removeInputConnection(Connection connection) {

    if (connection != null && this.inputConnections.contains(connection)) {
      Neuron origin = connection.neuronOrigin;
      origin.outputConnections.remove(connection);
      this.inputConnections.remove(connection);
    }

  }

  ///
  /// Remove an output connection.
  /// When you remove an output connection, the same connection will be remove on the input list of the neuron destination.
  ///


  void removeOutputConnection(Connection connection) {
    if (connection != null && this.outputConnections.contains(connection)) {
      Neuron destination = connection.neuronDestination;
      destination.inputConnections.remove(connection);
      this.outputConnections.remove(connection);
    }
  }

  ///
  /// Remove the input connection that connects from the neuron provided by parameter.
  ///

  void removeInputConnectionFromNeuron(Neuron origin) {
    Connection connection = this.inputConnectionFromNeuron(origin);
    if (connection != null) {
      origin.removeOutputConnection(connection);
      this.removeInputConnection(connection);
    }
  }

  ///
  /// Remove the output connection that connects to the neuron provided by parameter.
  ///

  void removeOutputConnectionToNeuron(Neuron destination) {
    Connection connection = this.outputConnectionToNeuron(destination);
    if (connection != null) {
      destination.removeInputConnection(connection);
      this.removeOutputConnection(connection);
    }
  }

  ///
  /// Remove all input connections.
  /// When you remove all input connections the same connections of the output connections list in the neurons origin will be remove.
  ///

  void removeAllInputConnections() {
    List <Connection> tempInputConnections = [];
    tempInputConnections.addAll(this.inputConnections);
    for (Connection connection in tempInputConnections) {
      this.removeInputConnection(connection);
    }
  }

  ///
  /// Remove all input connections.
  /// When you remove all input connections the same connections of the output connections list in the neurons origin will be remove.
  ///

  void removeAllOutputConnections() {
    List <Connection> tempOutputConnections = [];
    tempOutputConnections.addAll(this.inputConnections);
    for (Connection connection in tempOutputConnections) {
      this.removeOutputConnection(connection);
    }
  }

  ///
  /// Remove all input an output connections.
  ///

  void removeAllConnections() {
    removeAllInputConnections();
    removeAllOutputConnections();
  }

  ///
  /// Returns the connection whose origin neuron is the same as neuron provided as parameter
  ///

  Connection inputConnectionFromNeuron(Neuron neuron) {
    for (var connection in this.inputConnections) {
      if (connection.neuronOrigin == neuron) {
        return connection;
      }
    }
    return null;
  }

  ///
  /// Returns the connection whose destination neuron is the same as neuron provided as parameter.
  ///

  Connection outputConnectionToNeuron(Neuron neuron) {
    for (var connection in this.outputConnections) {
      if (connection.neuronDestination == neuron) {
        return connection;
      }
    }
    return null;
  }
}