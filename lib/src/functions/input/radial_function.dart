// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library InputFunction.Radial;

import 'dart:math';
import 'input_function.dart';
import "../../arquitecture/connection.dart";
import "package:json_object/json_object.dart";

class Radial extends InputFunction {

  /// Amplitude serves for the hidden neuron is activated in a region of the input space trying not to overlap
  /// the area of activation of other neurons.
  double amplitude = 1.0;

  ///
  /// Uses the input function of the difference but with a modification ; using amplitude.
  ///

  double getOutput(List<Connection> inputConnections) {

    double output = 0.0;
    for (Connection temp in inputConnections) {
      output += pow(temp.inputNeuronDestination - temp.weightValue,2);
    }
    return sqrt(output)/amplitude;

  }

  JsonObject toJSON(){

    JsonObject inputFunction = new JsonObject();
    inputFunction.type = "Radial";
    inputFunction.amplitude = this.amplitude;
    return inputFunction;

  }
}