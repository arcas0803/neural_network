// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ActivationFunction.ActivationFunction;

import "package:json_object/json_object.dart";

///
/// Interface to implement an activation function.
///

abstract class ActivationFunction {

  //From an input value return the output of the neuron.
  double getOutput(double value);

  //From an input value return the derived output of the neuron.
  double getDerivedOutput(double value);


  // Return the JsonObject of an activation function.
  JsonObject toJSON(){}

}



