// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library ErrorFunction;

//Interface for implementing error functions.

abstract class ErrorFunction{

  /// Return the error of the network.
  double totalError(){}

  // Add a pattern error.
  void addError(List<double>error){}

  // Set all the variables to the default value.
  void reset(){}

}

