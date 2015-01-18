// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library InputFunction.Sum;

import 'input_function.dart';
import "../../arquitecture/connection.dart";
import "package:json_object/json_object.dart";

class Sum extends InputFunction {

  ///
  /// Sum all entries.
  ///

  double getOutput(List<Connection> inputConnections) {

    double output = 0.0;
    for (Connection temp in inputConnections) {
      output += temp.inputNeuronDestination;
    }
    return output;

  }

}