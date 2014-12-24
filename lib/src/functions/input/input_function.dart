// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library InputFunction;

import "../../arquitecture/connection.dart";

/// Interface for implementing input functions.

abstract class InputFunction {

  /// From a list of input connections calculates the total input for the neuron.
  double getOutput(List<Connection> inputConnections);
}


